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
<title>神州币提现</title>
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
	//true已签到，false未签到
	var signinFlag = true;

	// $("#waitting").hide();
	// $.ajax({
	// 	url:"/mobile/plugin/dch/smb/getsignincount.jsp",
	// 	dataType:"text",
	// 	success:function(data){
	// 		// alert(data.trim());
	// 		$("#xx").html(data.trim());
	// 	}
	// });

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
	<!-- <div style="width:100%;" hidden="hidden">
		<div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
			<div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
				<b style="font-size:20px">猜数字</b><br/>
				<font color="gray">想要神州币吗？那就来玩吧！</font>
			</div>
			<div id="enterGameCasino" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入游戏
			</div>
		</div>
	</div> -->

	<div style="width:100%;" id="wor0k0">
		<div style="width:100%;height: 130px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
			<div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
				<b style="font-size:20px">连续签到奖励</b><br/>
				<font color="gray">本日已签到</font><font id="xx" color="gray"></font><font color="gray">人</font><br/>
				<font color="gray">您当月已连续签到</font><font id="xx1" color="gray"></font><font color="gray">天</font><br/>
				<font color="gray">再签到</font><font id="xx2" color="gray"></font><font color="gray">天可获得更高奖励</font><br/>
				<!-- <font color="gray">签到获取随机神州币奖励！</font> -->
			</div>
			<div id="qian" hidden="hidden" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:70px;text-align:center;border-radius:10px;color:white;margin-top:30px">签到</div>
			<div id="qian1" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:gray;width:70px;text-align:center;border-radius:10px;color:white;margin-top:30px">已签到</div>
			<div id="qian2" hidden="hidden" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:gray;width:70px;text-align:center;border-radius:10px;color:white;margin-top:30px">签到中</div>
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
	<div id="warning" style="margin-left:10%;position:fixed;color:red" hidden="hidden">
		<!-- <img id="tu" src="img/jinbi.gif" /> -->
		<b style="font-size:20px">您的账户存在异常，请与管理员联系！</b><br/>
	</div>
</body>
</html>