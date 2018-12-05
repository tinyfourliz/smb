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
        <title>赵成的运维体系管理课</title>
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
            var lessonid = 6;
            var dataArr = [];

        	$(function() {
                var requestArr = function() {
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/lesson/getLessonInsertItcode.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "lesson" : "赵成的运维体系管理课",
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
                        $(this).attr("href", "./lesson06/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid);
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
                                window.location.href="./lesson06/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid;
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
                        <p style="font-size: 120%;text-align: center;font-weight: bold;">赵成的运维体系管理课<br><font style="font-size: 80%;color: red;">按章节收费，每章 2 SZB</font></p>
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
                                    <li><a id="00">开篇词 | 带给你不一样的运维思考</a></li>
                                    <li><a id="01">01 | 为什么Netflix没有运维岗位</a></li>
                                    <li><a id="02">02 | 微服务架构时代，运维体系建设为什么要以“应用”为核心</a></li>
                                    <li><a id="03">03 | 标准化体系建设（上）：如何建立应用标准化体系和模型</a></li>
                                    <li><a id="04">04 | 标准化体系建设（下）：如何建立基础架构标准化及服务化体系</a></li>
                                    <li><a id="05">05 | 如何从生命周期的视角看待应用运维体系建设</a></li>
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
                                    <li><a id="06">06 | 我是如何走上运维岗位的</a></li>
                                    <li><a id="07">07 | 聊聊CMDB的前世今生</a></li>
                                    <li><a id="08">08 | 有了CMDB，为什么还需要应用配置管理</a></li>
                                    <li><a id="09">09 | 如何在CMDB中落地应用的概念</a></li>
                                    <li><a id="10">10 | 如何打造运维组织架构</a></li>
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
                                    <li><a id="11">11 | 谷歌SRE运维模式解读</a></li>
                                    <li><a id="12">12 | 从谷歌CRE模式谈起，运维如何培养服务意识</a></li>
                                    <li><a id="13">13 | 云计算和AI时代，运维应该如何做好转型</a></li>
                                    <li><a id="14">14 | 运维需要懂产品和运营吗</a></li>
                                    <li><a id="15">15 | 冷静下来想想，员工离职这事真能“防得住”吗</a></li>
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