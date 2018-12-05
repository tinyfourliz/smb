<%@page import="com.dch.HttpUrlService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%
	User user = HrmUserVarify.getUser(request, response);
	String code = user.getLoginid();

	HttpUrlService service = new HttpUrlService();
	String result = service.doHttpUrlNet("http://10.7.10.124:8080/vm/allUsableVms?pageNum=500&pageSize=500", null, "GET");
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
<script src="../js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="../js/bootstrap.min.js" type="text/javascript"></script>
<script src="../js/jqueryui.js"></script>
<script src="../js/touch_push.js" type="text/javascript"></script>
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

		var msg = "<div><center><font size='4' color='red'>已被占用的资源</font></center><hr style='margin:10px'></div><table>";
		var msg1 = "";
		msg += "<tr>";
		msg += "<td>机器简介</td>";
		msg += "<td>价格</td>";
		msg += "<td>使用状态</td>";
		msg += "<td>申请状态</td>";
		
		$(json.list).each(function(i,n){
			if(this.applystatus == 1){
				msg += "<tr>";
				msg += "<td>"+this.spare1+"</td>";
				msg += "<td>"+this.spare2+"</td>";
				msg += "<td>使用者:"+this.userItcode+"</td>";
				
				msg += "<td><button id='" + this.id + "' class='applyButton'>已被申请</button></td></tr>";
			}else if(this.applystatus == 0){
				msg1 += "<tr>";
				msg1 += "<td>"+this.spare1+"</td>";
				msg1 += "<td>"+this.spare2+"</td>";
					msg1 += "<td>申请者:"+this.userItcode+"</td>";
				msg1 += "<td><button id='" + this.id + "' class='appliedButton'>正在申请</button></td></tr>";
			}
		});
		msg += msg1;
		msg += "</table>";
		$("#main").html(msg);
	});
</script>

</head>
<body style="font-family:'微软雅黑'">
	<div id="main" style="width:96%;margin:0 auto"></div>

</body>
</html>