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
        <title>朱赟的技术管理课</title>
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
            var lessonid = 8;
            var dataArr = [];

        	$(function() {
                var requestArr = function() {
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/lesson/getLessonInsertItcode.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "lesson" : "朱赟的技术管理课",
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
                        $(this).attr("href", "./lesson08/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid);
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
                                window.location.href="./lesson08/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid;
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
                        <p style="font-size: 120%;text-align: center;font-weight: bold;">朱赟的技术管理课<br><font style="font-size: 80%;color: red;">按章节收费，每章 2 SZB</font></p>
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
                                    <li><a id="00">开篇词 | 从工程师到管理者，我的思考与实践</a></li>
                                    <li><a id="01">01 | 职场分身术：从给答案到做引导</a></li>
                                    <li><a id="02">02 | Bug引发事故，该不该追究责任</a></li>
                                    <li><a id="03">03 | 每个工程师都应该了解的：A/B测试</a></li>
                                    <li><a id="04">04 | 如何帮助团队成员成长</a></li>
                                    <li><a id="05">05 | 当我们给别人提意见时，要注意些什么</a></li>
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
                                    <li><a id="06">06 | 每个工程师都应该了解的：聊聊幂等</a></li>
                                    <li><a id="07">07 | 当别人给我们提意见时，该如何应对</a></li>
                                    <li><a id="08">08 | 说说硅谷公司中的一对一沟通</a></li>
                                    <li><a id="09">09 | 每个工程师都应该了解的：大数据时代的算法</a></li>
                                    <li><a id="10">10 | 项目延期了，作为负责人该怎么办</a></li>
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
                                    <li><a id="11">11 | 管理和被管理：期望值差异</a></li>
                                    <li><a id="12">12 | 每个工程师都应该了解的：数据库知识</a></li>
                                    <li><a id="13">13 | 管理者在进行工作分配时，会考虑哪些问题</a></li>
                                    <li><a id="14">14 | 硅谷人到底忙不忙</a></li>
                                    <li><a id="15">15 | 每个工程师都应该了解的：系统拆分</a></li>
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
                                    <li><a id="16">16 | 技术人员如何建立个人影响力</a></li>
                                    <li><a id="17">17 | 管理者不用亲力亲为：关键是什么</a></li>
                                    <li><a id="18">18 | 每个工程师都应该了解的：API的设计和实现</a></li>
                                    <li><a id="19">19 | 硅谷面试：那些你应该知道的事</a></li>
                                    <li><a id="20">20 | 项目管理中的三个技巧</a></li>
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
                                    <li><a id="21">21 | 每个工程师都应该了解的：中美在支付技术和大环境下的差异</a></li>
                                    <li><a id="22">22 | 不要做微观的管理者</a></li>
                                    <li><a id="23">23 | 如何处理工作中的人际关系</a></li>
                                    <li><a id="24">24 | 编程语言漫谈</a></li>
                                    <li><a id="25">25 | 兼容并包的领导方式</a></li>
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
                                    <li><a id="26">26 | 如何做自己的职场规划</a></li>
                                    <li><a id="27">27 | 小议Java语言</a></li>
                                    <li><a id="28">28 | 如何激发团队人员的责任心</a></li>
                                    <li><a id="29">29 | 说说硅谷互联网公司的开发流程</a></li>
                                    <li><a id="30">30 | 编程马拉松</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse6">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 31 - 35 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse6">
                                <ul class="nav navbar-nav">
                                    <li><a id="31">31 | 工程师、产品经理、数据工程师是如何一起工作的</a></li>
                                    <li><a id="32">32 | 硅谷人如何做CodeReview</a></li>
                                    <li><a id="33">33 | 技术人的犯错成本</a></li>
                                    <li><a id="34">34 | 如何从错误中成长</a></li>
                                    <li><a id="35">35 | 理解并建立自己的工作弹性</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse7">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 36 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse7">
                                <ul class="nav navbar-nav">
                                    <li><a id="36">36 | 如何对更多的工作说不</a></li>
                                    <li><a id="37">尾声 | 成长不是顿悟，而是练习</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <p style="color: gray;text-align: center;">-完结-</p>
                    </div>
                </div>
                <div id="divWait" class="col-xs-12 col-md-12" align="center" style="position: fixed;left: 50%;top: 50%;transform: translateX(-50%)translateY(-50%);-webkit-transform:translateX(-50%) translateY(-50%);">
                    <img id="waitGif" src="../img/walletWait.gif" hidden="hidden">
                </div>
            </div>
        </div>  
    </body>
</html>