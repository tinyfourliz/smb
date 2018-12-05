<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.io.*,java.util.*,weaver.monitor.cache.monitor.*,weaver.monitor.cache.Util.*,weaver.monitor.cache.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu1 = new FileUpload(request);
	BaseBean bb=new BaseBean();
	String name = Util.null2String((String) fu1.getParameter("name"));
	String count = Util.null2String((String) fu1.getParameter("count"));
	String itcode = name.split("/")[1];    // 收账人的itcode
	String dept = Util.null2String((String) fu1.getParameter("dept"));
	String imgUrl = "https://m.digitalchina.com/DCMobile2/HeadImage/"+itcode+"_middle2.jpg?OpenId=3.1415928&SysType=app";
	String touser = "";
	String fromuser = "";
	User _user1 = HrmUserVarify.getUser(request, response);
	String _itcode1 = _user1.getLoginid();
	RecordSet recordSet = new RecordSet();
	try{
	String sql = "SELECT accountkey FROM smb_dch WHERE itcode='"+_itcode1+"'";
	recordSet.executeSql(sql);
	
	if(recordSet.next()){
		fromuser = Util.null2String(recordSet.getString("accountkey"));
	}
	String sql1 = "SELECT accountkey FROM smb_dch WHERE itcode='"+itcode+"'";
	recordSet.executeSql(sql1);
	
	if(recordSet.next()){
		touser = Util.null2String(recordSet.getString("accountkey"));
	}

	String updatetablecache = "SuperSlideElement";
	CacheFactory sintance = CacheFactory.getInstance();
	String tkey = updatetablecache.trim().toLowerCase();
	String [] tables = new String[]{tkey};
	sintance.removeCache(tables);

	}catch(Exception e){
		bb.writeLog("turncount-------"+e);
   
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
<title>神州币转账</title>
<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/web3.min.js" ></script>
<script type="text/javascript" src="js/bignumber.js" ></script>
<style>
	.bq{
		height:30px;line-height:30px
	}

</style>

<script>
	$(function(){
		
		$("#pic").attr("src",'<%=imgUrl %>');
		$("#itcode").html('<%=name %>');
		$("#dept").html('<%=dept %>');
		$("#num").attr("placeholder","本次最多可转"+'<%=count %>');
		var toaccount = '<%=touser %>';
		var fromaccount = '<%=fromuser %>';
		var toitcode = '<%=itcode %>';
		var fromitcode = '<%=_itcode1 %>';
		
		// 修改标签的样式
		$(".bq").click(function(){
			
			if($(this).prop("id") == "2"){
				$(this).css("color","grey");
				$(this).css("border","1px solid grey");
				$(this).css("background","white");
				$(this).prop("id","1");
			} 
			
			else if($(this).prop("id") == "1"){
				$(this).css("color","red");
				$(this).css("border","1px solid red");
				$(this).css("background","#FFDAB9");
				$(this).prop("id","2");
				
				$(this).siblings(".bq").css("color","grey");
				$(this).siblings(".bq").css("border","1px solid grey");
				$(this).siblings(".bq").css("background","white");
				$(this).siblings(".bq").prop("id","1");
			} 
			
		});
		
		// 转账提交
		$("#turncount").click(function(){
			var turncount = $("#num").val();
			var flag = parseInt(turncount)>0;
			
			if($("#hi").val() == "1"){
				if(flag){
					var remark = "我欣赏对方的:"
					$(".bq").each(function(){
						if($(this).prop("id")=="2"){
							remark += $(this).text();
						}
					});
					
					var remark1 = $("#remark").val();
					if(remark1){
						remark = remark1;
					}
					
					$("#hi").val("");
					alert("转账可能有一定的延迟,请稍后查询!");
					$.ajax({
						url:"/mobile/plugin/dch/smb/turnmoney.jsp",
						data:{toaccount:toaccount,fromaccount:fromaccount,toitcode:toitcode,fromitcode:fromitcode,money:turncount,remark:remark},
						dataType:"text",
						// async:false,
						success:function(data){
							
						}
					});
					setTimeout(function() {
	                	window.location.href="/mobile/plugin/dch/smb/smb.jsp";
                	}, 2500);
				}else{
					alert("请输入正确的金额!!!");
				}
			}else{
				alert("请勿重复转账");
			}
		
		});

		$.ajax({
			url:"/mobile/plugin/dch/smb/getTransactionCounterByItcode.jsp",
			data:{itcode:toitcode},
			dataType:"text",
			success:function(data){
				// showDetail(data);
				var str = "";
				if (data == 0) {
					str = "Ta还未进行过交易,<br>邀请Ta使用可获得SZB奖励！";
				} else {
					str = "Ta已在神州区块链上交易" + data + "次";
				}
				$("#counter").html(str);
			}
		});
	});
</script>

</head>
<body style="font-family:微软雅黑" >
	<div style="height:100%;width:100%;margin:0;">
		<div style="height:230px;margin:5px;background-color:#0f364c;padding:10px">
			<center><img id="pic"  src="" style="margin:0 auto;width:80px;hetght:60px;border-radius:40px"></center>
			<center><div id="itcode" style="margin:0 auto;color:white;font-size:20px;margin:10px"></div></center>
			<center><div id="dept" style="margin:0 auto;color:white;font-size:13px;margin:10px"></div></center>
			<center><div id="counter" style="margin:0 auto;color:white;font-size:15px;margin-top:15px"></div></center>
		</div>
		<div style='float:right;'><a href='./test/erciyaoqingjieshao.jsp'>邀请好友得奖励</a></div>
		<div style="height:80px;margin-left:10px;margin-right:10px;font-size:20px;margin-top:20px;" >
			金额:</br>
			<input class="ys" id="num" type="text" style="height:30px;font-size:100%;border:0;margin:0;width:100%;outline:none;margin-top:10px">
		</div>
		<hr style="margin:0;color:gray;width:100%">
		<input type="hidden" value="1" id="hi" >
		<div style="height:50px;margin-left:10px;margin-right:10px;font-size:20px;margin-top:30px" >
			<div style="font-size:12px;width:100%;margin-bottom:15px">转账原因:我欣赏对方的:</div>
			<div id="1" class="bq" style="border:1px solid grey;float:left;width:25%;text-align:center;color:grey;border-radius:3px;font-size:14px">责任</div>
			<div id="1" class="bq" style="border:1px solid grey;float:left;width:25%;text-align:center;color:grey;border-radius:3px;font-size:14px;margin-left:12%">激情</div>
			<div id="1" class="bq" style="border:1px solid grey;float:right;width:25%;text-align:center;color:grey;border-radius:3px;font-size:14px">创新</div>
			
		</div>
		
		<div style="height:50px;margin-left:10px;margin-right:10px;font-size:14px;margin-top:20px;" >
			<input class="ys" id="remark" type="text" style="height:30px;font-size:14px;border:0;margin:0;width:100%;outline:none;margin-top:10px" placeholder="其他想说的">
		</div>
		<hr style="margin:0;color:gray;width:100%;">
		<div style="width:96%;
    		background-color: #0f364c;
		    height: 40px;
		    font-size: 18px;
		    position: fixed;
		    bottom: 0;
		    text-align: center;
		    line-height: 40px;
		    margin:0 auto;
		    border-bottom : 1px solid #a8a8a8;">
    		<div style="width: 100%;margin:0" id="turncount"><center><font size="3" color="white">确认转账</font></center></div>
    	</div>	
	</div>
	
</body>
</html>