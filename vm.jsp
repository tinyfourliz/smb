<%@page import="com.dch.HttpUrlService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%
	User user = HrmUserVarify.getUser(request, response);
	String code = user.getLoginid();

	HttpUrlService service = new HttpUrlService();
	String result = service.doHttpUrlNet("http://10.0.3.112:8080/vm/allUsableVms?pageNum=500&pageSize=500", null, "GET");
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
<title>虚拟机申请</title>
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/jqueryui.js"></script>
<script src="js/touch_push.js" type="text/javascript"></script>
<style>
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
<script>
	$(function(){
		var jsonStr = '<%=result %>';
		var json = eval("("+jsonStr+")");

		var msg = "<div><center><font size='4' color='red'>重要：每台虚拟机可使用30天，到期机器自动收回，不可续租，请提前备份重要文件。</font></center><hr style='margin:10px'></div><table>";
		var msg1 = "";
		msg += "<tr><td>机器名称</td>";
		msg += "<td>机器简介</td>";
		msg += "<td>价格</td>";
		msg += "<td>使用状态</td>";
		msg += "<td>申请状态</td>";
		$(json.list).each(function(i,n){
			if(this.status == 1){
				msg += "<tr><td>VM-"+(i+1)+"</td>";
				msg += "<td>"+this.spare1+"</td>";
				msg += "<td>"+this.spare2+"</td>";
				if(this.userItcode){
					msg += "<td>使用者:"+this.userItcode+"</td>";
				}else{
					msg += "<td>空闲</td>";
				}
				msg += "<td><button id='" + this.id + "' class='applyButton'>申请</button></td></tr>";
			}else{
				msg1 += "<tr><td>VM-"+(i+1)+"</td>";
				msg1 += "<td>"+this.spare1+"</td>";
				msg1 += "<td>"+this.spare2+"</td>";
				if(this.userItcode){
					msg1 += "<td>使用者:"+this.userItcode+"</td>";
				}else{
					msg1 += "<td>空闲</td>";
				}
				msg1 += "<td><button id='" + this.id + "' class='appliedButton'>已被申请</button></td></tr>";
			}
		});
		msg += msg1;
		msg += "</table>";
		$("#main").html(msg);
		
		// 查看我的申请
		$("#myapply").click(function(){
			window.location.href="myVM.jsp";
		});
		// 申请机器
		$(".applyButton").click(function(){
			var confirmMsg = "申请该虚拟机需扣除600神州币，请您确认！";
			if (confirm(confirmMsg)==true){
				var machineid = $(this).prop("id");
				var itcode = '<%=code %>';
				alert("申请及扣费状态确认有一定的延迟,请勿重复提交申请，以免重复扣费，申请结果请稍后点击我的申请按钮查看!");
	            $.ajax({
	                url:"/mobile/plugin/dch/smb/vmApplyAction.jsp",
	                data:{itcode:itcode,machineid:machineid},
	                dataType:"json",
	                success:function(data){
	                	alert(data.value);
	                }
	            });
			}
		});

		$("#guize").click(function(){
     		// 弹出模态框
			$('#myModal').modal({
        		keyboard: true
    		});
     	});
	});
</script>

</head>
<body style="font-family:'微软雅黑'">
	<div id="main" style="width:96%;margin:0 auto"></div>
	<div id="msg" style="height:35px"></div>
	<div style="width: 100%;
		background-color: #2C84f8;
	    height: 40px;
	    position: fixed;
	    bottom: 0;
	    text-align: center;
	    line-height: 40px;
	    border-bottom : 1px solid #a8a8a8;">
	    <div style="width: 9%;margin:0;float:left;height:100%"></div>
		<!-- <div id="myapply" style="width: 80%;margin:0;;text-align:center;font-size:20px;color:white">我的申请</div> -->
		<div style="width: 80%;margin:0;float:left;"><center><font size="3" color="white" id="myapply">我的申请</font></center></div>
		<div  style="width: 10%;margin:0;float:right;height:100%"><img id="guize" src="img/guize.png" width="100%" height="100%" /></div>
	</div>

	<!-- 外部链接模态框 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><center><font size="4" color="#2C84F8">规&nbsp;则&nbsp;简&nbsp;介</font></center></h4>
            </div>
            <div class="modal-body" style="height: 290px">
            	<font>1.虚拟机资源会在每天上午9:30-10:00随机放出，先到先得。</font>
            	<hr style="margin:10px">
            	<font>2.申请虚拟机需支付600神州币，余额不足将导致申请失败。申请成功后机器详细信息可在我的申请中查询。</font>
            	<hr style="margin:10px">
   				<font>3.每台虚拟机可使用30天，到期机器自动收回，不可续租，请提前备份重要文件。</font>
            	<hr style="margin:10px">
				<font>4.申请虚拟机属于一次性消费服务，一经申请，不可取消及退还神州币。</font>
            	<hr style="margin:10px">
            	<font>5.使用中如遇到任何问题或有任何建议，请与fannl@digitalchina.com联系，谢谢。</font>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</body>
</html>