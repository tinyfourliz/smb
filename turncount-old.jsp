<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu1 = new FileUpload(request);
	String name = Util.null2String((String) fu1.getParameter("name"));
	String count = Util.null2String((String) fu1.getParameter("count"));
	String itcode = name.split("/")[1];
	String dept = Util.null2String((String) fu1.getParameter("dept"));
	String imgUrl = "https://m.digitalchina.com/DCMobile2/HeadImage/"+itcode+"_middle2.jpg?OpenId=3.1415928&SysType=app";
	
	User _user1 = HrmUserVarify.getUser(request, response);
	String _itcode1 = _user1.getLoginid();
	RecordSet recordSet = new RecordSet();
	String sql = "SELECT accountkey FROM smb_dch WHERE itcode='"+_itcode1+"'";
	recordSet.executeSql(sql);
	String fromuser = "";
	if(recordSet.next()){
		fromuser = Util.null2String(recordSet.getString("accountkey"));
	}
	String sql1 = "SELECT accountkey FROM smb_dch WHERE itcode='"+itcode+"'";
	recordSet.executeSql(sql1);
	String touser = "";
	if(recordSet.next()){
		touser = Util.null2String(recordSet.getString("accountkey"));
	}
 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="author" content="Weaver E-Mobile Dev Group" />
	<meta name="description" content="Weaver E-mobile" />
	<meta name="keywords" content="weaver,e-mobile" />
	<meta name="viewport" content="width=device-width,minimum-scale=1.0, maximum-scale=1.0" />
<title>神码币转账</title>
<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/web3.min.js" ></script>
<script type="text/javascript" src="js/bignumber.js" ></script>
<script>
	$(function(){
		$("#pic").attr("src",'<%=imgUrl %>');
		$("#itcode").html('<%=name %>');
		$("#dept").html('<%=dept %>');
		$("#num").attr("placeholder","本次最多可转"+'<%=count %>');
		var tocode = '<%=touser %>';
		var fromitcode = '<%=fromuser %>';
		
		$("#turncount").click(function(){
			var turncount = $("#numa").val();
			$.ajax({
				url:"/mobile/plugin/dch/smb/turnmoney.jsp",
				data:{tocode:tocode,fromitcode:fromitcode,money:turncount},
				dataType:"text",
				success:function(data){
					window.location.href="smb.jsp";
				}
			});
		});
	});
</script>

</head>
<body style="font-family:微软雅黑" >
	<div style="height:100%;width:100%;margin:0;overflow-x:hidden">
		<div style="height:230px;margin:5px;background-color:#0f364c;padding:10px">
			<center><img id="pic"  src="" style="margin:0 auto;width:80px;hetght:60px;border-radius:40px"></center>
			<center><div id="itcode" style="margin:0 auto;color:white;font-size:30px;margin:10px"></div></center>
			<center><div id="dept" style="margin:0 auto;color:white;font-size:17px;margin:10px"></div></center>
		</div>
		<div style="height:45px;margin:10px;font-size:20px;" >
			金额：
			<input class="ys" id="numa" type="text" maxlength=40 style="border:0;background:transparent;width: 120px;height:39px;
			font-size:90%;float: right;width:50%;margin-right: 10px;text-align:right;">
		</div>
	
		<hr style="margin:0 10px 0 10px;color:gray">
			
		<div style="height:45px;margin:10px;font-size:20px;" >
			备注：
			<input class="ys" id="TravelPerson" type="text" maxlength=40 style="border:0;background:transparent;width: 120px;height:39px;
			font-size:90%;float: right;width:50%;margin-right: 10px;text-align:right;margin-bottom:0">
		</div>
	
		<hr style="margin:0 10px 0 10px;color:gray">
		<div style="width: 100%;
    		background-color: #2C84f8;
		    height: 40px;
		    font-size: 18px;
		    position: fixed;
		    bottom: 0;
		    text-align: center;
		    line-height: 40px;
		    border-bottom : 1px solid #a8a8a8;" id="foot">
		    <div style="width: 9%;margin:0;float:left;height:100%"></div>
    		<div style="width: 80%;margin:0;float:left;"><center><font size="3" color="white" id="turncount">确认转账</font></center></div>
    	</div>	
	</div>
	
</body>
</html>