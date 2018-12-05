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
<title>神州币福利</title>
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

	$("#waitting").hide();
	$.ajax({
		url:"/mobile/plugin/dch/smb/getsignincount.jsp",
		dataType:"text",
		success:function(data){
			// alert(data.trim());
			$("#xx").html(data.trim());
		}
	});

	$(function(){
		$("#qian").click(function(){
			$("#qimg").hide();
			$("#qimg1").hide();
			$("#waitting").show();
			$.ajax({
				url:"/mobile/plugin/dch/smb/dowork.jsp",
				data:{accountKey:accountKey,itcode:itcode},
				dataType:"text",
				success:function(data){
					if(data.trim() == "1"){
						$.ajax({
							url:"/mobile/plugin/dch/smb/getRewards.jsp",
							data:{itcode:itcode},
							dataType:"text",
							success:function(data){
							}
						});
						$("#waitting").hide();
						$("#qimg").show();
						setTimeout(hid,10000);
					}else{
						$("#waitting").hide();
						$("#qimg1").show();
						setTimeout(hid,10000);
					}
				}
			});
		});
		function hid(){
			$("#qimg").hide();
			$("#waitting").hide();
			$("#qimg1").hide();
		}
		$("#enterGameCasino").click(function(){
			window.location.href="/mobile/plugin/dch/smb/showGameCasino.jsp?itcode="+itcode;
		});
	});
</script>

</head>
<body style="font-family:微软雅黑 " >
	<div style="width:100%;" hidden="hidden">
		<div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
			<div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
				<b style="font-size:20px">猜数字</b><br/>
				<font color="gray">想要神州币吗？那就来玩吧！</font>
			</div>
			<div id="enterGameCasino" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入游戏
			</div>
		</div>
	</div>

	<div style="width:100%;" id="wor0k0">
		<div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
			<div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
				<b style="font-size:20px">签到奖励</b><br/>
				<font color="gray">本日已签到</font><font id="xx" color="gray"></font><font color="gray">人</font>
				<!-- <font color="gray">签到获取随机神州币奖励！</font> -->
			</div>
			<div id="qian" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:70px;text-align:center;border-radius:10px;color:white;margin-top:7px">签到</div>
		</div>
	</div>
	
	<div style="width:100%;margin-top:20px;background: #C0C0BB">
		<div style="text-align:center;font-size:20px">请给你心目中最理想的大学</br>投上宝贵的一票</div>
		<div style="width:94%;height:50px;border-bottom:1px solid black;margin-top:15px">
			<div style="color:white;background:#0f364c;float:left;width:40px;line-height:50px;margin:0;font-size:20px;text-align:center">1</div>
			<div style="float:left;width:50px;line-height:50px;margin:0;height:50px">
				<img src="img/qinghua.png" style="width:100%;height:100%">
			</div>
			<div style="float:left;height:50px;margin:0 0 0 15px;width:50%">
				<div style="height:50%;margin:0">清华大学</div>
				<div style="height:10px;margin:0;background:#0f364c;width:90%;border-radius:5px"></div>
			</div>
			<div style="float:right;width:60px;line-height:50px;text-align:center;margin:0">53.1%</div>
		</div>
		<div style="float:clear;width:94%;height:50px;border-bottom:1px solid black;margin-top:15px;margin-bottom:10px">
			<div style="color:white;background:#0f364c;float:left;width:40px;line-height:50px;margin:0;text-align:center">2</div>
			<div style="float:left;width:50px;line-height:50px;margin:0;">
				<img src="img/beida.jpg" style="width:100%;height:100%">
			</div>
			<div style="float:left;height:50px;margin:0 0 0 15px;width:50%">
				<div style="height:50%;margin:0">北京大学</div>
				<div style="height:10px;margin:0;background:#0f364c;width:87%;border-radius:5px"></div>
			</div>
			<div style="float:right;width:60px;line-height:50px;text-align:center;margin:0">46.9%</div>
		</div>
	</div> 
	<div id="waitting" style="margin-left:10%;position:fixed;color:gray" hidden="hidden">
		<!-- <img id="tu" src="img/jinbi.gif" /> -->
		<b style="font-size:20px">正在查询您的签到状态，请稍候...</b><br/>
	</div>
	<div id="qimg" style="margin-left:10%;position:fixed;color:red" hidden="hidden">
		<!-- <img id="tu" src="img/jinbi.gif" /> -->
		<b style="font-size:20px">签到奖励入帐中，稍后请转至明细查看!</b><br/>
	</div>
	<div id="qimg1" style="margin-left:10%;position:fixed;color:red" hidden="hidden">
		<!-- <img id="tu" src="img/jinbi.gif" /> -->
		<b style="font-size:20px">您今日已签到，请明日再来!</b><br/>
	</div>
</body>
</html>