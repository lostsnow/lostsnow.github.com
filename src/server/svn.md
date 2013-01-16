Subversion
==========

SVN sync
--------

### master ###

    # hooks/pre-commit
    # hooks/post-commit
    chmod 755 /path/to/adprojects/hooks/pre-commit
    chmod 755 /path/to/adprojects/hooks/post-commit

    # post-commit 内的脚本
    svnsync sync --non-interactive svn://${slave}/projecta --username ${username} --password ${password}

> 详见 post-commit 脚本, 注意更改用户名密码及slave 的 IP
>
> ${slave} 是 slave 的IP或域名, ${username}, ${password} 是svn的用户名密码


### slave ###

    svnadmin create /path/to/projecta;

    # hooks/pre-revprop-change;
    chmod 755 /path/to/projecta/hooks/pre-revprop-change;

    # 以下命令手动执行一遍
    svnsync init svn://${slave}/projecta svn://${master}/projecta;
    svnsync sync svn://${slave}/projecta svn://${master}/projecta;

> ${master} 是 master 的IP或域名

Tips
----

导出 svn 版本库

    svn export --force svn://${master}/projecta /export/path/to/projecta