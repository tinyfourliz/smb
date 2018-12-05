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
        <title>神州区块链状态监测</title>
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
        	$(function() {
                
               /* $("#apply").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/admin/addVoteTopic.jsp?itcode="+itcode;
                });
                $("#laomo").click(function() {
                    window.location.href="./test/rankingList.jsp?itcode="+itcode;
                });
                $("#xuexi").click(function() {
                    window.location.href="./test/studyRankList.jsp?itcode="+itcode;
                });
                $("#jishu").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/technicalExperts.jsp?itcode="+itcode;
                });
                $("#kaopu").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/kaopu.jsp?itcode="+itcode;
                });
                $("#jiupin").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/jiupin.jsp?itcode="+itcode;
                });
                $("#koucai").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/koucai.jsp?itcode="+itcode;
                });
                $("#yanzhi").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/yanzhi.jsp?itcode="+itcode;
                });
                $("#yanzhi-man").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/yanzhi-man.jsp?itcode="+itcode;
                });*/
                $("#article").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/admin/ethNodesCheck.jsp?itcode="+itcode;
                });
            });
        </script>
    </head>
    <body style="font-family:微软雅黑;" >
    	 <div class="container" style="">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="margin-top: 5%;">
                    <button id="article" type="button" class="btn btn-default btn-lg btn-block" style="vertical-align: middle;"><!-- <img src="./img/newLesson.png" style="width: 25px;height: 25px;float: left;"> -->节点监测</button>
                   <!--  <button id="apply" type="button" class="btn btn-default btn-lg btn-block" style="vertical-align: middle;"><img src="./img/applyButtonIcon.png" style="width: 25px;height: 25px;float: left;">申请投票话题</button>
                    <button id="laomo" type="button" class="btn btn-default btn-lg btn-block" style="vertical-align: middle;"><img src="./img/lmButtonIcon.png" style="width: 25px;height: 25px;float: left;">劳模排行榜</button>
                    <button id="xuexi" type="button" class="btn btn-default btn-lg btn-block" style="margin-top: 10px;"><img src="./img/xxButtonIcon.png" style="width: 25px;height: 25px;float: left;">学习排行榜</button>
                    <button id="jishu" type="button" class="btn btn-default btn-lg btn-block" style="margin-top: 10px;"><img src="./img/jishuButtonIcon.png" style="width: 25px;height: 25px;float: left;">技术排行榜</button>
                    <button id="kaopu" type="button" class="btn btn-default btn-lg btn-block" style="margin-top: 10px;"><img src="./img/kaopuButtonIcon.png" style="width: 25px;height: 25px;float: left;">靠谱排行榜</button>
                    <button id="jiupin" type="button" class="btn btn-default btn-lg btn-block" style="margin-top: 10px;"><img src="./img/jiupinButtonIcon.png" style="width: 25px;height: 25px;float: left;">酒品排行榜</button>
                    <button id="koucai" type="button" class="btn btn-default btn-lg btn-block" style="margin-top: 10px;"><img src="./img/koucaiButtonIcon.png" style="width: 25px;height: 25px;float: left;">口才排行榜</button>
                    <button id="yanzhi" type="button" class="btn btn-default btn-lg btn-block" style="margin-top: 10px;"><img src="./img/yanzhiButtonIcon.png" style="width: 25px;height: 25px;float: left;">女神排行榜</button>
                    <button id="yanzhi-man" type="button" class="btn btn-default btn-lg btn-block" style="margin-top: 10px;"><img src="./img/yanzhi-manButtonIcon.png" style="width: 25px;height: 25px;float: left;">男神排行榜</button> -->
                </div>
            </div>
        </div>  
    </body>
</html>