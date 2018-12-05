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
        <title>左耳听风</title>
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
            var lessonid = 5;
            var dataArr = [];

        	$(function() {
                var requestArr = function() {
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/lesson/getLessonInsertItcode.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "lesson" : "左耳听风",
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
                        $(this).attr("href", "./lesson05/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid);
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
                                window.location.href="./lesson05/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid;
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
                        <p style="font-size: 120%;text-align: center;font-weight: bold;">左耳听风<br><font style="font-size: 80%;color: red;">按章节收费，每章 2 SZB</font></p>
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
                                    <li><a id="00">开篇词 | 洞悉技术的本质，享受科技的乐趣</a></li>
                                    <!-- <li><a id="01">01 | 为什么要学习网络协议</a></li>
                                    <li><a id="02">02 | 网络分层的真实含义是什么</a></li>
                                    <li><a id="03">03 | ifconfig：最熟悉又陌生的命令行</a></li>
                                    <li><a id="04">04 | DHCP与PXE：IP是怎么来的，又是怎么没的</a></li>
                                    <li><a id="05">05 | 从物理层到MAC层：如何在宿舍里自己组网玩联机游戏</a></li> -->
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <!-- <div>
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
                                    <li><a id="06">06 | 交换机与VLAN：办公室太复杂，我要回学校</a></li>
                                    <li><a id="07">07 | ICMP与ping：投石问路的侦察兵</a></li>
                                    <li><a id="08">08 | 世界这么大，我想出网关：欧洲十国游与玄奘西行</a></li>
                                    <li><a id="09">09 | 路由协议：西出网关无故人，敢问路在何方</a></li>
                                    <li><a id="10">10 | UDP协议：因性善而简单，难免碰到“城会玩”</a></li>
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
                                    <li><a id="11">11 | TCP协议（上）：因性恶而复杂，先恶后善反轻松</a></li>
                                    <li><a id="12">12 | TCP协议（下）：西行必定多妖孽，恒心智慧消磨难</a></li>
                                    <li><a id="13">13 | 套接字Socket：Talk is cheap, show me the code</a></li>
                                    <li><a id="14">14 | HTTP协议：看个新闻原来这么麻烦</a></li>
                                    <li><a id="15">15 | HTTPS协议：点外卖的过程原来这么复杂</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div> -->
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