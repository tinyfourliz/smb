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
        <title>深入浅出区块链</title>
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
            var lessonid = 2;
            var dataArr = [];

        	$(function() {
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/lesson/getLessonInsertItcode.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode,
                        "lesson" : "深入浅出区块链",
                        "lessonid" : lessonid
                    })},
                    dataType: "json",
                    success: function(data) {
                        if (data.success) {
                            dataArr = data.data;
                        }
                    }
                });

                $("ul a").click(function() {
                    $(this).attr("href", "./lesson02/" + $(this).attr("id") + ".html?itcode="+ itcode + "&lessonid=" + lessonid);
                });
                /*$("ul a").click(function() {
                    var flag = false;
                    var chapterId = $(this).attr("id");
                    for(var i = 0; i < dataArr.length; i++) {
                        if (dataArr[i] == parseInt(chapterId)) {
                            flag = true;
                            break;
                        }
                    }
                    if (flag == true) {
                        $(this).attr("href", "./lesson02/" + chapterId + ".html?itcode="+ itcode + "&lessonid=" + lessonid);
                    } else {
                        if(confirm("您未购买此课程，确认购买吗？") == true){
                            $.ajax({
                                type: "GET",
                                url: "/mobile/plugin/dch/smb/lesson/getInsertBuyInfo.jsp",
                                data: {"jsonStr" : JSON.stringify({
                                    "itcode" : itcode,
                                    "lessonId" : lessonid,
                                    "chapterNum" : chapterId
                                })},
                                dataType: "json",
                                success: function(data) {
                                    alert(JSON.stringify(data));
                                    if (data.success) {
                                        console.log("***********************");
                                        location.reload(true);
                                    }
                                }
                            });
                        }
                    }
                });*/
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
                        <p style="text-align: center;font-weight: bold;">深入浅出区块链</p>
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
                                    <li><a id="00" href="">开篇词 | 帮你从0到1深入学习区块链技术</a></li>
                                    <li><a id="01" href="">01 | 到底什么才是区块链</a></li>
                                    <li><a id="02" href="">02 | 区块链到底是怎么运行的</a></li>
                                    <li><a id="03" href="">03 | 浅说区块链共识机制</a></li>
                                    <li><a id="04" href="">04 | 区块链的应用类型</a></li>
                                    <li><a id="05" href="">05 | 如何理解数字货币？它与区块链又是什么样的关系？</a></li>
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
                                    <li><a id="06" href="">06 | 理解区块链之前，先上手体验一把数字货币</a></li>
                                    <li><a id="07" href="">07 | 区块链的常见误区</a></li>
                                    <li><a id="08" href="">08 | 最主流区块链项目有哪些</a></li>
                                    <li><a id="09" href="">09 | 深入区块链技术（一）：技术基础</a></li>
                                    <li><a id="10" href="">10 | 深入区块链技术（二）：P2P网络</a></li>
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
                                    <li><a id="11" href="">11 | 深入区块链技术（三）：共识算法与分布式一致性算法</a></li>
                                    <li><a id="12" href="">12 | 深入区块链技术（四）：PoW共识</a></li>
                                    <li><a id="13" href="">13 | 深入区块链技术（五）：PoS共识机制</a></li>
                                    <li><a id="14" href="">14 | 深入区块链技术（六）：DPoS共识机制</a></li>
                                    <li><a id="15" href="">15 | 深入区块链技术（七）：哈希与加密算法</a></li>
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
                                    <li><a id="16" href="">16 | 深入区块链技术（八）： UTXO与普通账户模型</a></li>
                                    <li><a id="17" href="">17 | 去中心化与区块链交易性能</a></li>
                                    <li><a id="18" href="">18 | 智能合约与以太坊</a></li>
                                    <li><a id="19" href="">19 | 上手搭建一条自己的智能合约</a></li>
                                    <li><a id="20" href="">20 | 区块链项目详解：比特股BTS</a></li>
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
                                    <li><a id="21" href="">21 | 引人瞩目的区块链项目：EOS、IOTA、Cardano</a></li>
                                    <li><a id="22" href="">22 | 国内区块链项目技术一览</a></li>
                                    <li><a id="23" href="">23 | 联盟链和它的困境</a></li>
                                    <li><a id="24" href="">24 | 比特币专题（一）历史与货币</a></li>
                                    <li><a id="25" href="">25 | 比特币专题（二）：扩容之争、IFO与链上治理</a></li>
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
                                    <li><a id="26" href="">26 | 数字货币和数字资产</a></li>
                                    <li><a id="27" href="">27 | 弄懂数字货币交易平台（一）</a></li>
                                    <li><a id="28" href="">28 | 弄懂数字货币交易平台（二）</a></li>
                                    <li><a id="29" href="">29 | 互联网身份与区块链数字身份</a></li>
                                    <li><a id="30" href="">30 | 区块链即服务BaaS</a></li>
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
                                <a class="navbar-brand">第 31 - 36 讲</a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbar-collapse6">
                                <ul class="nav navbar-nav">
                                    <li><a id="31" href="">31 | 数字货币钱包服务</a></li>
                                    <li><a id="32" href="">32 | 区块链与供应链（一）</a></li>
                                    <li><a id="33" href="">33 | 区块链与供应链（二）</a></li>
                                    <li><a id="34" href="">34 | 从业区块链需要了解什么</a></li>
                                    <li><a id="35" href="">35 | 搭建你的迷你区块链（设计篇）</a></li>
                                    <li><a id="36" href="">36 | 搭建你的迷你区块链（实践篇）</a></li>
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