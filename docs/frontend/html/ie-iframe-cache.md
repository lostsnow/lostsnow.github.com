IE iframe cache
===============

> 如何解决 IE Iframe 框架的缓存问题

Question
--------

我有一个主页面包含iframe框架, 每次刷新iframe地址都会改变, 但是在ie中, 始终只显示同一个iframe的内容, 该如何清除缓存?

Answer
------

用js动态的设置iframe的地址就可以了

    <iframe name="iframename"></iframe>

    <script type="text/javascript">
    (document.frames || window.frames)['iframename'].location.href = "http://images.sohu.com/bill/s2011/jiaren/lverya/0728/b/b.html";
    </script>

> 注: `.<iframe name="iframename"></iframe>` 不能增加src属性
