<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu4 = new FileUpload(request);
	String it_code1 = Util.null2String((String) fu4.getParameter("itcode"));
    String flag = Util.null2String((String) fu4.getParameter("flag"));
 %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="author" content="Weaver E-Mobile Dev Group" />
        <meta name="description" content="Weaver E-mobile" />
        <meta name="keywords" content="weaver,e-mobile" />
        <meta name="viewport" content="width=device-width,minimum-scale=1.0, maximum-scale=1.0" />
        <title>数据结构与算法之美</title>
        <link rel="stylesheet" id="" href="../css/trav.css"/>
        <link rel="stylesheet" id="" href="../css/bootstrap.min.css" type="text/css" />
        <script src="../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" id="" href="../css/weui.min.css" />
        <link rel="stylesheet" id="" href="../css/jquery-weui.min.css" />
        <link rel="stylesheet" id="" href="../css/icon.css" />
        <link rel="stylesheet" id="" href="../css/task.css" />
        <script type='text/javascript' src='../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../js/jquery.form.js'></script>
        <script type='text/javascript' src="../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../js/web3.min.js'></script>
        <script type='text/javascript' src='../js/bignumber.js'></script>

        <script type="text/javascript">
        	var itcode = '<%=it_code1 %>';
            var lessonid = 3;
            var dataArr = [];

        	$(function() {
                var requestArr = function() {
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/lesson/getLessonInsertItcode.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "lesson" : "数据结构与算法之美",
                            "lessonid" : lessonid
                        })},
                        dataType: "json",
                        success: function(data) {
                            if (data.success) {
                                dataArr = data.data;
                            }
                        }
                    });
                }

                requestArr();

                $("ul a").click(function() {
                    var flag = false;
                    var chapterId = $(this).attr("id");
                    for(var i = 0; i < dataArr.length; i++) {
                        if (dataArr[i] == parseInt(chapterId)) {
                            flag = true;
                            break;
                        }
                    }
                    if (flag == true) {
                        $(this).attr("href", "./lesson03/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid);
                    } else {
                        $("#waitGif").show();
                        var jsonStr = JSON.stringify({
                                "itcode" : itcode,
                                "lessonId" : lessonid,
                                "chapterNum" : chapterId
                            });
                        $.ajax({
                            type: "GET",
                            url: "/mobile/plugin/dch/smb/lesson/getInsertBuyInfo.jsp",
                            data: {jsonStr : jsonStr},
                            dataType: "json",
                            contentType: 'application/json',
                            success: function(data) {
                                dataArr.push(parseInt(chapterId));
                                $("#waitGif").hide();
                                window.location.href="./lesson03/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid;
                            }
                        });
                    }
                });
            });
        </script>
    </head>
    <style type="text/css">
        a {
            text-align: left;
        }
    </style>
    <body style="font-family:微软雅黑;" >
    	 <div class="container" style="">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="margin-top: 5%;">
                    <div>
                        <p style="font-size: 120%;text-align: center;font-weight: bold;">数据结构与算法之美<br><font style="font-size: 85%;color: red;">按章节收费，每章 2 SZB</font></p>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse0">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 1 - 5 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse0">
                                <ul class="nav navbar-nav">
                                    <li><a id="00">开篇词 | 从今天起，跨过“数据结构与算法”这道坎</a></li>
                                    <li><a id="01">01 | 为什么要学习数据结构与算法</a></li>
                                    <li><a id="02">02 | 如何抓住重点，系统高效地学习数据结构与算法</a></li>
                                    <li><a id="03">03 | 复杂度分析（上）：如何分析、统计算法的执行效率和资源消耗</a></li>
                                    <li><a id="04">04 | 复杂度分析（下）：浅析最好、最坏、平均、均摊时间复杂度</a></li>
                                    <li><a id="05">05 | 数组：为什么很多编程语言中数组都从0开始编号</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse1">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 6 - 10 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse1">
                                <ul class="nav navbar-nav">
                                    <li><a id="06">06 | 链表（上）：如何实现LRU缓存淘汰算法</a></li>
                                    <li><a id="07">07 | 链表（下）：如何轻松写出正确的链表代码</a></li>
                                    <li><a id="08">08 | 栈：如何实现浏览器的前进和后退功能</a></li>
                                    <li><a id="09">09 | 队列：队列在线程池等有限资源池中的应用</a></li>
                                    <li><a id="10">10 | 递归：如何用三行代码找到“最终推荐人”</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse2">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 11 - 15 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse2">
                                <ul class="nav navbar-nav">
                                    <li><a id="11">11 | 排序（上）：为什么插入排序比冒泡排序更受欢迎</a></li>
                                    <li><a id="12">12 | 排序（下）：如何用快排思想在O(n)内查找第K大元素</a></li>
                                    <li><a id="13">13 | 线性排序：如何根据年龄给100万用户数据排序</a></li>
                                    <li><a id="14">14 | 排序优化：如何实现一个通用的、高性能的排序函数</a></li>
                                    <li><a id="15">15 | 二分查找（上）：如何用最省内存的方式实现快速查找功能</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse3">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 16 - 20 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse3">
                                <ul class="nav navbar-nav">
                                    <li><a id="16">16 | 二分查找（下）：如何快速定位IP对应的省份地址</a></li>
                                    <li><a id="17">17 | 跳表：为什么Redis一定要用跳表来实现有序集合</a></li>
                                    <li><a id="18">18 | 散列表（上）：Word文档中的单词拼写检查功能是如何实现的</a></li>
                                    <li><a id="19">19 | 散列表（中）：如何打造一个工业级水平的散列表</a></li>
                                    <li><a id="20">20 | 散列表（下）：为什么散列表和连表经常会一起使用</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse4">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 21 - 25 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse4">
                                <ul class="nav navbar-nav">
                                    <li><a id="21">21 | 哈希算法（上）：如何防止数据库中的用户信息被脱库</a></li>
                                    <li><a id="22">22 | 哈希算法（下）：哈希算法在分布式系统中有哪些应用</a></li>
                                    <li><a id="23">23 | 二叉树基础（上）：什么样的二叉树适合用数组来存储</a></li>
                                    <li><a id="24">24 | 二叉树基础（下）：有了如此搞高效的散列表，为什么还需要二叉树</a></li>
                                    <li><a id="25">25 | 红黑树（上）：为什么工程中都用红黑树这种二叉树</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse5">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 26 - 30 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse5">
                                <ul class="nav navbar-nav">
                                    <li><a id="26">26 | 红黑树（下）：掌握这些技巧，你也可以实现一个红黑树</a></li>
                                    <!-- <li><a id="27">27 | </a></li>
                                    <li><a id="28">28 | </a></li>
                                    <li><a id="29">29 | </a></li>
                                    <li><a id="30">30 | </a></li> -->
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <p style="color: gray;text-align: center;">-未完待续-</p>
                    </div>
                </div>
                <div id="divWait" class="col-xs-12 col-md-12" align="center" style="position: fixed;left: 50%;top: 50%;transform: translateX(-50%)translateY(-50%);-webkit-transform:translateX(-50%) translateY(-50%);">
                    <img id="waitGif" src="../img/walletWait.gif" hidden="hidden">
                </div>
            </div>
        </div>  
    </body>
</html>