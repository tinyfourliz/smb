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
	String account_Key1 = Util.null2String((String) fu4.getParameter("accountKey"));
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
<title>神州币充值</title>
<link rel="stylesheet" href="css/trav.css"/>
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/weui.min.css" />
<link rel="stylesheet" href="css/jquery-weui.min.css" />
<link rel="stylesheet" href="css/icon.css" />
<link rel="stylesheet" href="css/task.css" />
<script type='text/javascript' src='js/jquery.textarea.autoheight.js'></script>
<script type='text/javascript' src='js/jquery.form.js'></script>
<script type='text/javascript' src="js/jquery-weui.js"></script>
<script type='text/javascript' src='js/fastclick.min.js'></script>
<script type='text/javascript' src='js/web3.min.js'></script>
<script type='text/javascript' src='js/bignumber.js'></script>

<script type="text/javascript">
	var accountKey = '<%=account_Key1 %>';
	var itcode = '<%=it_code1 %>';

	$.ajax({
		url:"/mobile/plugin/dch/smb/getSigninStatus.jsp",
		data:{itcode:itcode},
		dataType:"json",
		success:function(data){
			if(data.status == 1){
				signinFlag = false;
				$("#qian").show();
				$("#qian1").hide();
				$("#qian2").hide();
			}
			$("#xx").html(data.value1);
			$("#xx1").html(data.value);
			$("#xx2").html(7 - (data.value%7));
		}
	});
	$(function(){
		$("#qian").click(function(){
			$("#qian").hide();
			$("#qian1").hide();
			$("#qian2").show();
			$.ajax({
				url:"/mobile/plugin/dch/smb/getSigninInfo.jsp",
				data:{itcode:itcode},
				dataType:"json",
				success:function(data){
					if(data.status == 1){
						$.ajax({
							url:"/mobile/plugin/dch/smb/getRewards.jsp",
							data:{itcode:itcode,reward:data.value},
							dataType:"text",
							success:function(data){
							}
						});
						$("#qian2").hide();
						$("#qian").hide();
						$("#qian1").show();
						location.reload();
					}else{
						$("#warning").show();
					}
				}
			});
		});
		function hid(){
			$("#qimg").hide();
			$("#waitting").hide();
			$("#qimg1").hide();
			$("#warning").hide();
		}
		/*$("#enterGameCasino").click(function(){
			window.location.href="/mobile/plugin/dch/smb/showGameCasino.jsp?itcode="+itcode;
		});*/
	});
</script>

</head>
<body style="font-family:微软雅黑" >
	<div style="height:100%;width:100%;margin:0;">
		<div style="height:80px;margin-left:10px;margin-right:10px;font-size:10px;margin-top:20px;" >
			<font color="#2C84f8">来源账户地址:</font></br>
			<input class="ys" id="account" type="text" style="height:30px;font-size:100%;border:0;margin:0;width:100%;outline:none;margin-top:10px">
		</div>
		<hr style="margin:0;color:#2C84f8;width:100%">
		<div style="height:80px;margin-left:10px;margin-right:10px;font-size:10px;margin-top:20px;" >
			充值金额:</br>
			<input class="ys" id="transferValue" type="text" style="height:30px;font-size:100%;border:0;margin:0;width:100%;outline:none;margin-top:10px">
		</div>
		<hr style="margin:0;color:#2C84f8;width:100%">
		<div style="height:80px;margin-left:10px;margin-right:10px;font-size:10px;margin-top:20px;" >
			地址密码:</br>
			<input class="ys" id="accountPassword" type="text" style="height:30px;font-size:100%;border:0;margin:0;width:100%;outline:none;margin-top:10px">
		</div>
		<hr style="margin:0;color:#2C84f8;width:100%">
		<div style="height:20px;margin-left:10px;margin-right:10px;font-size:20px;margin-top:20px;" >
		</div>
		<div style="width:100%;
    		background-color: #2C84f8;
		    height: 50px;
		    font-size: 40px;
		    position: fixed;
		    bottom: 1px;
		    text-align: center;
		    line-height: 40px;
		    margin:0 auto;
		    border-bottom : 1px solid #a8a8a8;">
    		<div style="width: 100%;margin:0;font-size: 40px;" id="turncount"><center><font color="white">确认充值</font></center></div>
    	</div>	
	</div>
</html>