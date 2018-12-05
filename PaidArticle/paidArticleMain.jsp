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
        <title>测试标签页面</title>
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
        	$(function(){
        		$("#newArticle").click(function(){
        			window.location.href="/mobile/plugin/dch/smb/PaidArticle/newArticle.jsp?itcode="+itcode;
        		});
                $("#queryArticle").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/PaidArticle/queryArticle.jsp?itcode="+itcode;
                });
                $("#queryMyArticle").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/PaidArticle/myArticles.jsp?itcode="+itcode;
                });
        	})
        </script>
    </head>
    <body style="font-family:微软雅黑 " >
    	<div style="width:100%;">
            <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
                <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                    <b style="font-size:20px">新建文章</b><br/>
                    <font color="gray">新建付费文章</font>
                </div>
                <div id="newArticle" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入
                </div>
            </div>
            <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
                <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                    <b style="font-size:20px">热门文章</b><br/>
                    <font color="gray">最热、最新的文章都在这里</font>
                </div>
                <div id="queryArticle" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入
                </div>
            </div>
            <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
                <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                    <b style="font-size:20px">我的文章</b><br/>
                    <font color="gray">查看阅读量、收益及提现</font>
                </div>
                <div id="queryMyArticle" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入
                </div>
            </div>
    	</div>
    </body>
</html>