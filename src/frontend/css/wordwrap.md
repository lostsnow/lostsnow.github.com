CSS word wrap
==============

> CSS 的强制换行

Question
--------

如何能够让各个浏览器兼容换行(包含连续英文情形下)?

Answer
------

```css
table-layout:fixed;     // table
word-break:break-all;
word-wrap:break-word;
```

其中 `table-layout` 是在使用 table 的时候设置给 table 的 CSS 属性
