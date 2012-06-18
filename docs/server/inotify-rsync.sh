#!/bin/bash
#
# echo 30000000 > /proc/sys/fs/inotify/max_user_watches
# /path/to/inotify-rsync.sh > /path/to/log/inotify.log 2>&1

###########################
# 在这里配置本地文件夹,目标host,目标的rsync_module。rsync_module在同步机器的/etc/rsyncd.conf文件中配置
# 逗号前后不要有空格
sync[0]='/path/to/testrsync,192.168.0.11,test' # localdir,host,rsync_module
# sync[1]='/path/to/local/dir,host,rsync_module'
###########################

for item in ${sync[@]}; do

dir=`echo $item | awk -F"," '{print $1}'`
host=`echo $item | awk -F"," '{print $2}'`
module=`echo $item | awk -F"," '{print $3}'`
exfile=/opt/projects/task/sh/exfile-${module}

inotifywait -mrq --timefmt '%d/%m/%y %H:%M' --format  '%T %w%f %e' \
 --event CLOSE_WRITE,create,move,delete $dir | while read date time file event
    do
        d1=`date '+%Y%m'`
        d2=`date '+%Y%m%d'`
        logdir=/opt/projects/release/log/${d1}
        mkdir -p ${logdir}
        #echo $event'-'$file
        case $event in
            CLOSE_WRITE,CLOSE|MODIFY|CREATE|MOVE|MODIFY,ISDIR|CREATE,ISDIR|MODIFY,ISDIR)
                if [ "${file: -4}" != '4913' ]  && [ "${file: -1}" != '~' ]; then
                    echo $event'-'$file >> ${logdir}/tasksh-${d2}.log
                    cmd="rsync -avz --exclude-from=$exfile --exclude='*' --include=$file $dir $host::$module"
                    # echo $cmd
                    $cmd
                fi
                ;;

            MOVED_FROM|MOVED_FROM,ISDIR|DELETE|DELETE,ISDIR)
                if [ "${file: -4}" != '4913' ]  && [ "${file: -1}" != '~' ]; then
                    echo $event'-'$file >> ${logdir}/tasksh-${d2}.log
                    cmd="rsync -avz --exclude-from=$exfile --exclude="$file" $dir $host::$module"
                    # echo $cmd
                    $cmd
                fi
                ;;
        esac
    done &
done
