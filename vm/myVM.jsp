<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%@page import="com.dch.HttpUrlService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	
	User user = HrmUserVarify.getUser(request, response);
	String code = user.getLoginid();
	
	HttpUrlService service = new HttpUrlService();
	String result = service.doHttpUrlNet("http://10.7.10.124:8080/vm/myVms?itcode=" + code, null, "GET");
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
<style>
	td{
		height:45px;border-bottom:1px solid #E0E0E0;padding:0;width:50%;text-align:center
	}
	table{
		border-collapse:collapse;width:100%
	}
	button{
		background:#30b5ff;color:white
	}
</style>
<script>
function createsnapshot(vmid){
alert(vmid);
	$.ajax({
   				url:"/mobile/plugin/dch/smb/vm/createsnapshot.jsp?vmid="+vmid,
				dataType:"text",
				success:function(data){
				alert($.trim(data));
				}
   			}); 
}
function revertsnapshot(vmid){
	$.ajax({
   				url:"/mobile/plugin/dch/smb/vm/revertsnapshot.jsp?vmid="+vmid,
				dataType:"text",
				success:function(data){
				alert($.trim(data));
				}
   			}); 
}
	$(function(){
		var jsonStr = '<%=result %>';
		var json = eval("("+jsonStr+")");
		
		var msg = "";
		$(json).each(function(i,n){
		    var statusmes="";
		    if(this.applystatus=="0"){
		    statusmes="正在申请";
		    }else if(this.applystatus=="1"){
		   statusmes="申请成功";
		    }else if(this.applystatus=="2"){
		    statusmes="申请失败";
		    }else if(this.applystatus=="3"){
                                       statusmes="已过期";
                                     }
			msg += "<div style='margin:15px 0 0 0;border-radius:10px;background:#E8E8E8;paddind:5px 0 5px 0;width:100%'><table>";
			msg += "<tr><td colspan='2' style='font-size:20px;border-bottom:1px solid black'>VM"+(i+1)+"</td></tr>";
			msg += "<tr><td>IP地址</td><td>"+this.ip+"</td></tr>";
			msg += "<tr><td>用户名</td><td>"+this.user+"</td></tr>";
			msg += "<tr><td>密码</td><td>"+this.password+"</td></tr>";
			msg += "<tr><td>使用期限</td><td>"+this.spare3+"</td></tr>";
			msg += "<tr><td>描述</td><td>"+this.spare1+"</td></tr>";
			msg += "<tr><td>价格</td><td>"+this.spare2+"</td></tr>";
				msg += "<tr><td>申请状态</td><td>"+statusmes+"</td></tr>";
				msg += "<tr><td>可用快照时间</td><td>"+this.editdate+"</td></tr>";
if(this.applystatus=="1"){
msg+="<tr><td><input type='button' value='创建快照' style='width: 80px;margin-left: 0%; ' onclick='createsnapshot("+this.resourceid+")'></td><td><input type='button' value='恢复快照'  style='width: 80px;margin-left: 0%;' onclick='revertsnapshot("+this.resourceid+")'></td></tr>"
}
			msg += "</table></div>";
		});
		
		if (msg != "") {
			var msg1 = "<div><center><font size='4' color='red'>重要：到期机器自动收回，不可续租，请根据您的使用期限，提前备份重要文件，谢谢。</font></center><hr style='margin:10px'></div>";
			msg1 += msg;
			$("#main").html(msg1);
		} else {
			$("#main").html("暂无您的申请信息。");
		}
		
	});

</script>

</head>
<body style="font-family:'微软雅黑'">
	<div id="main" style="width:96%;margin:0 auto"></div>
</body>
</html>