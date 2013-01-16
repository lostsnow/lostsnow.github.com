IE download filename in PHP
===========================

> IE中通过PHP下载文件得到错误的文件名

Question
--------

从一个php脚本中下载文件, 在ie下的不到正确的文件名, 返回的总是php脚本的名称, firefox和chrome无此症状

代码如下(download.php):

    <?php
    $filename = 'example.zip';
    header('Content-Type: application/octet-stream;');
    header('Content-Disposition: attachment;filename=' . $filename);
    echo file_get_contents('./example.zip');

在ie中只能得到download.php的文件名称

Answer
------

这是一个ie的bug, 当收到一个`Cache-Control: no-cache的header` 的时候, ie会忽略filename的头

加上下面两条就可以解决了

    <?php
    header("Cache-Control: maxage=1");
    header("Pragma: public");
