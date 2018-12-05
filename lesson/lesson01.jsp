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
        <title>从0开始学架构</title>
        <link rel="stylesheet" href="../css/trav.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css" />
        <script src="../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../css/weui.min.css" />
        <link rel="stylesheet" href="../css/jquery-weui.min.css" />
        <link rel="stylesheet" href="../css/icon.css" />
        <link rel="stylesheet" href="../css/task.css" />
        <script type='text/javascript' src='../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../js/jquery.form.js'></script>
        <script type='text/javascript' src="../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../js/web3.min.js'></script>
        <script type='text/javascript' src='../js/bignumber.js'></script>

        <script type="text/javascript">
        	var itcode = '<%=it_code1 %>';
            var lessonid = 1;
        	$(function() {
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/lesson/getLessonInsertItcode.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode,
                        "lesson" : "从0开始学架构",
                        "lessonid" : lessonid
                    })},
                    dataType: "json",
                    success: function(data) {
                    }
                });

                $("ul a").click(function() {
                    $(this).attr("href", "./lesson01/" + $(this).attr("id") + ".html?itcode="+ itcode + "&lessonid=" + lessonid);
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
                        <p style="text-align: center;font-weight: bold;">从0开始学架构</p>
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
                                    <li><a id="00" href="">开篇语</a></li>
                                    <li><a id="01" href="">01 | 架构到底是指什么</a></li>
                                    <li><a id="02" href="">02 | 架构设计的历史背景</a></li>
                                    <li><a id="03" href="">03 | 架构设计的目的</a></li>
                                    <li><a id="04" href="">04 | 复杂度来源：高性能</a></li>
                                    <li><a id="05" href="">05 | 复杂度来源：高可用</a></li>
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
                                    <li><a id="06" href="">06 | 复杂度来源：可扩展性</a></li>
                                    <li><a id="07" href="">07 | 复杂度来源：低成本、安全、规模</a></li>
                                    <li><a id="08" href="">08 | 架构设计三原则</a></li>
                                    <li><a id="09" href="">09 | 架构设计原则案例</a></li>
                                    <li><a id="10" href="">10 | 架构设计流程：识别复杂度</a></li>
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
                                    <li><a id="11" href="">11 | 架构设计流程：设计备选方案</a></li>
                                    <li><a id="12" href="">12 | 架构设计流程：评估和选择备选方案</a></li>
                                    <li><a id="13" href="">13 | 架构设计流程：详细方案设计</a></li>
                                    <li><a id="14" href="">14 | 高性能数据库集群：读写分离</a></li>
                                    <li><a id="15" href="">15 | 高性能数据库集群：分库分表</a></li>
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
                                    <li><a id="16" href="">16 | 高性能NoSQL</a></li>
                                    <li><a id="17" href="">17 | 高性能缓存架构</a></li>
                                    <li><a id="18" href="">18 | 单服务器高性能模式：PPC与TPC</a></li>
                                    <li><a id="19" href="">19 | 单服务器高性能模式：Reactor与Proactor</a></li>
                                    <li><a id="20" href="">20 | 高性能负载均衡：分类及架构</a></li>
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
                                    <li><a id="21" href="">21 | 高性能负载均衡：算法</a></li>
                                    <li><a id="22" href="">22 | 想成为架构师，你必须知道CAP理论</a></li>
                                    <li><a id="23" href="">23 | 想成为架构师，你必须掌握CAP细节</a></li>
                                    <li><a id="24" href="">24 | FMEA方法，排除架构可用性隐患的利器</a></li>
                                    <li><a id="25" href="">25 | 高可用存储架构：双机架构</a></li>
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
                                    <li><a id="26" href="">26 | 高可用存储架构：集群和分区</a></li>
                                    <li><a id="27" href="">27 | 如何设计计算高可用架构</a></li>
                                    <li><a id="28" href="">28 | 业务高可用的保障：异地多活架构</a></li>
                                    <li><a id="29" href="">29 | 异地多活设计4大技巧</a></li>
                                    <li><a id="30" href="">30 | 异地多活设计4步走</a></li>
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
                                    <li><a id="31" href="">31 | 如何应对接口级的故障</a></li>
                                    <li><a id="32" href="">32 | 可扩展架构的基本思想和模式</a></li>
                                    <li><a id="33" href="">33 | 传统的可扩展架构模式：分层架构和SOA</a></li>
                                    <li><a id="34" href="">34 | 深入理解微服务架构：银弹 or 焦油坑</a></li>
                                    <li><a id="35" href="">35 | 微服务架构最佳实践 - 方法篇</a></li>
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
                                <a class="navbar-brand">第 36 - 40 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse7">
                                <ul class="nav navbar-nav">
                                    <li><a id="36" href="">36 | 微服务架构最佳实践 - 基础设施篇</a></li>
                                    <li><a id="37" href="">37 | 微内核架构详解</a></li>
                                    <li><a id="38" href="">38 | 架构师应该如何判断技术演进的方向</a></li>
                                    <li><a id="39" href="">39 | 互联网技术演进的模式</a></li>
                                    <li><a id="40" href="">40 | 互联网架构模板：“存储层”技术</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse9">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 41 - 45 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse9">
                                <ul class="nav navbar-nav">
                                    <li><a id="41" href="">41 | 互联网架构模板：“开发层”和“服务层”技术</a></li>
                                    <li><a id="42" href="">42 | 互联网架构模板：“网络层”技术</a></li>
                                    <li><a id="43" href="">43 | 互联网架构模板：“用户层”和“业务层”技术</a></li>
                                    <li><a id="44" href="">44 | 互联网架构模板：“平台”技术</a></li>
                                    <li><a id="45" href="">45 | 架构重构内功心法第一式：有的放矢</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="navbar-header" align="center">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#navbar-collapse8">
                                    <span class="sr-only"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand">第 46 - 50 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse8">
                                <ul class="nav navbar-nav">
                                    <li><a id="46" href="">46 | 架构重构内功心法第二式：合纵连横</a></li>
                                    <li><a id="47" href="">47 | 架构重构内功心法第三式：运筹帷幄</a></li>
                                    <li><a id="48" href="">48 | 再谈开源项目：如何选择、使用以及二次开发</a></li>
                                    <li><a id="49" href="">49 | 谈谈App架构的演进</a></li>
                                    <li><a id="50" href="">50 | 架构实战：架构设计文档模板</a></li>
                                    <li><a id="51" href="">结束语：坚持，成就你的技术梦想</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div>
                        <p style="color: gray;text-align: center;">-已完结-</p>
                    </div>
                </div>
            </div>
        </div>  
    </body>
</html>