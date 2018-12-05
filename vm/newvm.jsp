<%@page import="java.util.UUID"%>
<%@page import="org.apache.commons.lang.math.RandomUtils"%>
<%@page import="java.util.Random"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.mobile.trav.ws.*" %>

<%
User user = HrmUserVarify.getUser (request , response) ;
String _itcode = user.getLoginid();
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
	<title>新建差旅计划</title>
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

	<style type="text/css">
	#userChooseDiv {
		position: fixed;
		left: 100%;
		top: 0px;
		width: 100%;
		height: 100%;
		z-index: 99999;
	}
	body.hrmshow #userChooseDiv {
		left: 0;
	}
	#userChooseFrame {
		width: 100%;
		height: 100%;
	}
	.image1{
		width:50px; 
		height:50px; 
		border-radius:100px; 
	}
	.sel{
		border-width: 0px;
		border-top-style: none; 
		border-right-style: none; 
		border-left-style: none; 
		border-bottom-style: none;
		
		-moz-appearance:menulist;
		-webkit-appearance:menulist;
		background: url("img/business-sj.png") no-repeat scroll right center transparent;
		padding-right: 14px;
	}
	td{
		height:45px;border-bottom:1px solid #E0E0E0;padding:0;width:20%;text-align:center
	}
	table{
		border-collapse:collapse;width:100%
	}
	.applyButton{
		background:#30b5ff;color:white
	}
	.appliedButton{
		background:grey;color:white
	}
	

</style>

<script type="text/javascript">
	var itcode = '<%=_itcode %>';
	console.error(itcode);
	$(function(){

		$.ajax({
			url:"/mobile/plugin/dch/smb/vm/getusedvm.jsp",
			dataType:"text",
			success:function(data){
				var res=$.trim(data).split("_");
				$("#tips").text(40-parseInt(res[0]));
				$("#usedr").text(parseInt(res[0])+"个资源被占用");
				$("#price").html("&nbsp;"+res[1]+"。");
			}
		}); 



		$("#apply").click(function(){

			if($("#tips").text()=="0"){
				alert("已无多余机器");
				return false;
			}

			$("#apply").attr("disabled",true);
			$("#apply").text("已提交");
			$("#afterApply").show();
			$.ajax({
				url:"/mobile/plugin/dch/smb/vm/createvm.jsp?usetime="+$("#usetime").val()+"&os="+$("#os").val()+"&memory="+$("input[name='memory']:checked").val()
				+"&cpu="+$("input[name='cpu']:checked").val()+"&harddisk="+$("input[name='harddisk']:checked").val()+"&hasnet="+$("input[name='hasnet']:checked").val(),
				dataType:"text",
				success:function(data){
					alert($.trim(data));
				}
			}); 
		});
		$("#guize").click(function(){
     		// 弹出模态框
     		$('#myModal').modal({
     			keyboard: true
     		});
     	});
		$("#myapply").click(function(){
			window.location.href="../myVM.jsp";
		});
		$("#usedr").click(function(){
			window.location.href="./getusedtable.jsp";
		});
		$('#windows').change(function() {
			if($(this).is(":checked")){    		  
				$('#linux').prop("checked",false);
				$("#os").val("windows");
				$("#gointernet").css("display","none");
				$("#online").prop("checked",false);
				$("#outline").prop("checked",true);
			}
		});
		$('#linux').change(function() {
			if($(this).is(":checked")){
				$("#os").val("linux");
				$('#windows').prop("checked",false);
				$("#gointernet").css("display","block");

				$("#online").prop("checked",false);
				$("#outline").prop("checked",true);
			}
		});




	})

</script>

</head>
<body id="body" ontouchstart style="overflow：hidden">
	<p style=" background-color:#B2DFEE;text-align: center;">已有<a id="usedr"></a>
		，剩余<span id="tips"></span>个资源可申请。<span id="discount" style="color:red"></span></p>
		<!-- <div style="width: 100%;background: gainsboro;height: 10px;padding: 0;margin: 0;overflow-x:hidden"></div> -->
		<form style="padding-top: 0px;width:100%;overflow-x:hidden;font-family:微软雅黑;font-size:14px" method="post">
			<div class="table1" >
				申请时长：
				<select style="float: right;margin-right: 10px;" id="usetime" class="sel">
					<option name="oneweek" id="oneweek" value="4">一周</option>
					<option name="onem" id="onem" value="1">一个月</option>
					<option name="twom" id="twom" value="2">两个月</option>
					<option name="threem" id="threem" value="3">三个月</option>

				</select>
			</div>

			<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">

			<div class="table1">
				操作系统：
				<input type="radio" name="windows" id="windows" value="windows" checked="checked" /> Windows Server&nbsp;&nbsp;
				<input type="radio" name="linux" id="linux" value="linux" /> Centos7.5
				<input type="hidden" id="os" value="windows">
			</div>

			<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">

			<div class="table1" >
				内存：&nbsp;&nbsp;&nbsp;


				<input type="radio" name="memory"  value="4" checked="checked" /> 4G&nbsp;&nbsp;
				<input type="radio" name="memory"  value="8"  /> 8G&nbsp;&nbsp;
				<input type="radio" name="memory"  value="16"  /> 16G&nbsp;&nbsp;


			</div>

			<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">

			<div class="table1" style="overflow:hidden" >
				硬盘：&nbsp;&nbsp;&nbsp;
				<input type="radio" name="harddisk"  value="100"  checked="checked"/> 100G&nbsp;&nbsp;
				<input type="radio" name="harddisk"  value="200"  /> 200G&nbsp;&nbsp;
				<input type="radio" name="harddisk"  value="400"  /> 400G&nbsp;&nbsp;
			</div>

			<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;" id="sfz2">

			<div class="table1" style="overflow:hidden;" >
				核心数：
				<input type="radio" name="cpu"  value="2" checked="checked" /> 2&nbsp;&nbsp;
				<input type="radio" name="cpu"  value="4" /> 4&nbsp;&nbsp;
				<input type="radio" name="cpu"  value="6" /> 6&nbsp;&nbsp;
				<input type="radio" name="cpu"  value="8" /> 8&nbsp;&nbsp;
				<input type="hidden" id="os" value="windows">
			</div>

			<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;" id="sfz2">
			<div class="table1" style="overflow:hidden;display: none;"   id="gointernet">
				是否上网：
				<input type="radio" name="hasnet"   value="online" id="online" style="flex:1" /> 是&nbsp;&nbsp;
				<input type="radio" name="hasnet"  value="outline" id="outline" style="flex:1"   checked="checked"/> 否&nbsp;&nbsp;
			</div>


			<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;" id="sfz2">
			<div class="table1" style="overflow:hidden;background-color:#ffffff" id="useprice">
				价格：<font  id="price" >&nbsp;&nbsp;600神州币/月</font>
				<p><font style="color: red;">最新活动：购买后次日返现，最高返现300神州币，每人仅限参与一次。</font></p>
			</div>

			<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;" id="sfz2">
			<div style="height: 50px;"></div>
			<div class="footer11">
				<!-- <div class="dv1"></div> -->
				<div class="footer1">
					<button id="apply" type="button" class="btn btn-info btn-lg btn-block" style="width:60%; position: fixed;
					left: 20%;">
				提交申请</button>
			</div>
		</div>
	</form>
	<p id="afterApply" hidden="hidden" style="margin-top: 55px;text-align: center;color: red;">请5-10分钟后在“我的申请”中查看</p>
	<div id="main" style="width:96%;margin:0 auto"></div>

	<!-- 2C84f8 -->
	<div style="width: 100%;
	background-color: #5BC0DE;
	height: 40px;
	position: fixed;
	bottom: 0;
	text-align: center;
	line-height: 40px;
	border-bottom : 1px solid #a8a8a8;">
	<div style="width: 9%;margin:0;float:left;height:100%"></div>
	<!-- <div id="myapply" style="width: 80%;margin:0;;text-align:center;font-size:20px;color:white">我的申请</div> -->
	<div style="width: 80%;margin:0;float:left;"><center><font size="3" color="white" id="myapply">我的申请</font></center></div>
	<div  style="width: 10%;margin:0;float:right;height:100%"><img id="guize" src="../img/guize.png" width="100%" height="100%" /></div>
</div>
<!-- 外部链接模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel"><center><font size="4" color="#2C84F8">规&nbsp;则&nbsp;简&nbsp;介</font></center></h4>
			</div>
			<div class="modal-body" style="height: 400px">
				<font>1.虚拟机资源通过申请放出，先到先得。</font>
				<hr style="margin:10px">
				<font>2.申请虚拟机需支付600神州币/月，余额不足将导致申请失败。申请成功后机器详细信息可在我的申请中查询。</font>
				<hr style="margin:10px">
				<font>3.到期机器自动收回，不可续租，请提前备份重要文件。</font>
				<hr style="margin:10px">
				<font>4.申请虚拟机属于一次性消费服务，一经申请，不可取消及退还神州币。</font>
				<hr style="margin:10px">
				<font>5.使用中如遇到任何问题或有任何建议，请与fannl@digitalchina.com或fengshuo1@digitalchina.com联系，谢谢。</font>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>



</body>
</html>