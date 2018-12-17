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
        <title>从0开始学大数据</title>
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
            var lessonid = 11;
            var dataArr = [];

        	$(function() {
                var requestArr = function() {
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/lesson/getLessonInsertItcode.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "lesson" : "从0开始学大数据",
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
                        $(this).attr("href", "./lesson11/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid);
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
                                window.location.href="./lesson11/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid;
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
                        <p style="font-size: 120%;text-align: center;font-weight: bold;">从0开始学大数据<br><font style="font-size: 80%;color: red;">按章节收费，每章 2 SZB</font></p>
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
                                    <li><a id="00">开篇词 | 为什么说每个软件工程师都应该懂大数据技术</a></li>
                                    <li><a id="01">01 | 大数据技术发展史：大数据的前世今生</a></li>
                                    <li><a id="02">02 | 大数据应用发展史：从搜索引擎到人工智能</a></li>
                                    <li><a id="03">03 | 大数据应用领域：数据驱动一切</a></li>
                                    <li><a id="04">04 | 移动计算比移动数据更划算</a></li>
                                    <li><a id="05">05 | 从RAID看垂直伸缩到水平伸缩的演化</a></li>
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
                                    <li><a id="06">06 | 新技术层出不穷，HDFS依然是存储的王者</a></li>
                                    <li><a id="07">07 | 为什么说MapReduce既是编程模型又是计算框架</a></li>
                                    <li><a id="08">08 | MapReduce如何让数据完成一次旅行</a></li>
                                    <li><a id="09">09 | 为什么我们管Yarn叫作资源调度框架</a></li>
                                    <li><a id="10">10 | 模块答疑：我们能从Hadoop学到什么</a></li>
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
                                    <li><a id="11">11 | Hive是如何让MapReduce实现SQL操作的</a></li>
                                    <li><a id="12">12 | 我们并没有觉得MapReduce速度慢，知道Spark出现</a></li>
                                    <li><a id="13">13 | 同样的本质，为何Spark可以更高效</a></li>
                                    <li><a id="14">14 | BigTable的开源实现：HBase</a></li>
                                    <li><a id="15">15 | 流式计算的代表：Storm、Flink、Spark Streaming</a></li>
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
                                    <li><a id="16">16 | ZooKeeper是如何保证数据一致性的</a></li>
                                    <li><a id="17">17 | 模块答疑：这么多技术，到底都能用在什么场景里</a></li>
                                    <!-- <li><a id="18">18 | 同样的本质，为何Spark可以更高效</a></li>
                                    <li><a id="19">19 | BigTable的开源实现：HBase</a></li>
                                    <li><a id="20">20 | 流式计算的代表：Storm、Flink、Spark Streaming</a></li> -->
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