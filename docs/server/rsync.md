Rsync & Inotify
===============

>> ** 要使用inotify，linux的内核版本不能低于2.6.13 **

Install
-------

先安装inotify-tools

https://github.com/rvoicilas/inotify-tools/wiki/

Configure
---------

### 服务端 ###

#### 服务端脚本 ####

服务端脚本为 `inotify-rsync.sh`, 运行这段脚本后, 这个机器上对应的文件夹将会同步到其他机器上

#### 运行 ####

    cd /path/to/inotify-rsync
    chmod +x inotify-rsync.sh
    ./inotify-rsync

注: /proc/sys/fs/inotify/max_user_watches, 表示每个inotify instatnces可监控的最大目录数量. 如果监控的文件数目巨大, 需要根据情况, 适当增加此值的大小, 例如:

    echo 30000000 > /proc/sys/fs/inotify/max_user_watches
    /path/to/inotify-rsync.sh > /path/to/inotify-rsync/inotify.log 2>&1

/proc/sys/fs/inotify/max_queued_evnets, 表示调用inotify_init时分配给inotify instance中可排队的event的数目的最大值, 超出这个值的事件被丢弃, 但会触发IN_Q_OVERFLOW事件

/proc/sys/fs/inotify/max_user_instances, 表示每一个real user ID可创建的inotify instatnces的数量上限

### 同步端 ###

#### 设置 `/etc/rsyncd.conf` 文件 ####

    # rsyncd

    uid=root
    gid=root

    log file=/var/log/rsyncd.log

    # 这个test就是上面脚本中用到的rsync_module名
    # path指定同步过来的文件存放的路径
    # 如果只允许部分ip的机器进行同步的话，设置allow为 192.168.1.1/100 类似的格式
    [test]
    path=/opt/projects
    hosts allow=10.11.5.7
    read only=no

#### 启动 ####

    rsync --daemon

    echo "/usr/bin/rsync --daemon" >>/etc/rc.local

Other
-----

### rsync 相关参数 ###

    -vzrtpog --progress --delete --exclude-from=/path/to/exfile

     -v, --verbose               increase verbosity
     -z, --compress              compress file data during the transfer
         --compress-level=NUM    explicitly set compression level
         --skip-compress=LIST    skip compressing files with a suffix in LIST
     -r, --recursive             recurse into directories
     -t, --times                 preserve modification times
     -p, --perms                 preserve permissions
     -o, --owner                 preserve owner (super-user only)
     -g, --group                 preserve group
         --devices               preserve device files (super-user only)
         --specials              preserve special files
     -h, --human-readable        output numbers in a human-readable format
         --progress              show progress during transfer
     -F                          same as --filter='dir-merge /.rsync-filter'
                                 repeated: --filter='- .rsync-filter'
         --exclude=PATTERN       exclude files matching PATTERN
         --exclude-from=FILE     read exclude patterns from FILE
         --include=PATTERN       don't exclude files matching PATTERN
         --include-from=FILE     read include patterns from FILE
         --files-from=FILE       read list of source-file names from FILE
     -e, --rsh=COMMAND           specify the remote shell to use
         --rsync-path=PROGRAM    specify the rsync to run on the remote machine
         --existing              skip creating new files on receiver
         --ignore-existing       skip updating files that already exist on receiver
         --remove-source-files   sender removes synchronized files (non-dirs)
         --del                   an alias for --delete-during
         --delete                delete extraneous files from destination dirs
         --delete-before         receiver deletes before transfer, not during
         --delete-during         receiver deletes during transfer (default)
         --delete-delay          find deletions during, delete after
         --delete-after          receiver deletes after transfer, not during
         --delete-excluded       also delete excluded files from destination dirs
         --ignore-errors         delete even if there are I/O errors
         --force                 force deletion of directories even if not empty
         --max-delete=NUM        don't delete more than NUM files
         --max-size=SIZE         don't transfer any file larger than SIZE
         --min-size=SIZE         don't transfer any file smaller than SIZE
         --partial               keep partially transferred files
         --partial-dir=DIR       put a partially transferred file into DIR
         --delay-updates         put all updated files into place at transfer's end


    -avz

     -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
         --no-OPTION             turn off an implied OPTION (e.g. --no-D)

     -l, --links                 copy symlinks as symlinks
     -D                          same as --devices --specials
