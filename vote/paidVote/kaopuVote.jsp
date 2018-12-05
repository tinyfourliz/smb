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
<title>神州币付费投票</title>
<script src="../../js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/web3.min.js" ></script>
<script type="text/javascript" src="../../js/bignumber.js" ></script>
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
		$("#num").attr("placeholder","请填入整数票");
		var toaccount = '<%=touser %>';
		var fromaccount = '<%=fromuser %>';
		var toitcode = '<%=itcode %>';
		var fromitcode = '<%=_itcode1 %>';
		var topicId = 2;
		// 转账提交
		$("#turncount").click(function(){
			var turncount = $("#num").val();
			var flag = parseInt(turncount)>0;
			
			if(flag){
				var remark = ""
				var remark1 = $("#remark").val();
				if(remark1){
					remark = remark1;
				}
				alert("投票确认可能有一定的延迟,请稍后查询!");
				$.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/vote/commitPaidVoteDetail.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "toaccount" : toaccount,
                        "fromaccount" : fromaccount,
                        "toitcode" : toitcode,
                        "fromitcode" : fromitcode,
                        "turncount" : turncount,
                        "remark" : remark,
                        "topicId" : topicId
                    })},
                    dataType: "json",
                    success: function(data) {
                    }
                });
				setTimeout(function() {
                	window.location.href="/mobile/plugin/dch/smb/vote/paidVote/kaopu.jsp?itcode="+fromitcode;
            	}, 2500);
			}else{
				alert("请输入正确的票数!");
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
			<center><div id="counter" style="margin:0 auto;color:white;font-size:15px;margin-top:15px">为TA投上支持的一票，<br>每一票将会消耗您 1 SZB！</div></center>
		</div>
		<div style="height:80px;margin-left:10px;margin-right:10px;font-size:20px;margin-top:20px;" >
			为TA投票张数：</br>
			<input class="ys" id="num" type="text" style="height:30px;font-size:100%;border:0;margin:0;width:100%;outline:none;margin-top:10px">
		</div>
		<hr style="margin:0;color:gray;width:100%">
		
		<div style="height:50px;margin-left:10px;margin-right:10px;font-size:14px;margin-top:20px;" >
			<input class="ys" id="remark" type="text" style="height:30px;font-size:14px;border:0;margin:0;width:100%;outline:none;margin-top:10px" placeholder="对TA说点儿什么">
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
    		<div style="width: 100%;margin:0" id="turncount"><center><font size="3" color="white">确认投票</font></center></div>
    	</div>	
	</div>
	
</body>
</html>