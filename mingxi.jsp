
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu2 = new FileUpload(request);
	String acount = Util.null2String((String) fu2.getParameter("acount"));
	String type = Util.null2String((String) fu2.getParameter("type"));
	
	HttpUrlService service1 = new HttpUrlService();
	String json =  service1.doHttpUrlNet("http://10.0.5.217:8080/eth/findAll/"+acount,null,"GET");
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
<title>神州币明细</title>
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
	$(function(){
		
		var account = '<%= acount %>';
		var type = '<%= type %>';
		var jsonobj = eval(<%= json %>);
		showDetail(jsonobj);
		
		$("#typ").click(function(){
			var typ = $("#typ").attr("src");
			if(typ == "img/xia.png"){
				$("#typ").attr("src","img/shang.png");
				$("#aa").show();
			}else{
				$("#typ").attr("src","img/xia.png");
				$("#aa").hide();
			}
		});
		
		$(".lei").click(function(){
			$(this).siblings().css("background","#DCDCDC");
			$(this).css("background","#90EE90");
			$("#tou").find("span").text($(this).text());
			if($(this).text()=="收支明细"){
				type = "0";
			}
			if($(this).text()=="支出明细"){
				type = "1";
			}
			if($(this).text()=="收入明细"){
				type = "2";
			}
			$.ajax({
				url:"/mobile/plugin/dch/smb/getother.jsp",
				data:{account:account,type:type},
				dataType:"json",
				success:function(data){
					showDetail(data);
				}
			});
			
			$("#typ").attr("src","img/xia.png");
			$("#aa").hide();
		});
		
		$("#main").click(function(){
			$("#typ").attr("src","img/xia.png");
			$("#aa").hide();
		});
		
		function showDetail(jsonobj){
			var $main = "";
			$(jsonobj).each(function(i,n){
				$main += "<div style='width:100%;border-bottom:1px solid gray;margin-bottom:10px;height:120px'>";
				if(jsonobj[i].fromcount == account){
					var remark = jsonobj[i].remark;
					if(!jsonobj[i].remark){
						remark = "";
					}
					$main += "<div style='width:50%;float:left'>转账时间</div>";
					$main += "<div style='width:50%;float:right;margin:0'>"+jsonobj[i].turndate+"</div>";
					$main += "<div style='width:50%;float:left'>金额:</div>";
					$main += "<div style='width:50%;float:right'>-"+jsonobj[i].value+"</div>";
					$main += "<div style='width:50%;float:left'>收账人:</div>";
					$main += "<div style='width:50%;float:right'>"+jsonobj[i].toitcode+"</div>";
					$main += "<div style='width:50%;float:left'>备注:</div>";
					$main += "<div style='width:50%;float:right'>"+remark+"</div>";
				}else{
					var remark = jsonobj[i].remark;
					if(!jsonobj[i].remark){
						remark = "";
					}
					$main += "<div style='width:50%;float:left'>入账时间</div>";
					$main += "<div style='width:50%;float:right'>"+jsonobj[i].turndate+"</div>";
					$main += "<div style='width:50%;float:left'>金额:</div>";
					$main += "<div style='width:50%;float:right'>+"+jsonobj[i].value+"</div>";
					$main += "<div style='width:50%;float:left'>转账人:</div>";
					$main += "<div style='width:50%;float:right'>"+jsonobj[i].fromitcode+"</div>";
					$main += "<div style='width:50%;float:left'>备注:</div>";
					$main += "<div style='width:50%;float:right'>"+remark+"</div>";
				}
				$main += "</div>";
			});
			$("#main").html($main);
		}
	});
</script>

</head>
<body style="font-family:微软雅黑 " >
	<div id="bod" style="width:100%;overflow-x:hidden;position:relative">
		<div id="tou" style="width:100%;background-color:#F5F5F5;height:40px;font-size:30px;line-height:40px;text-align:center"><span style="font-size:22px">收支明细</span>
			<img id="typ" src="img/xia.png" style="width:10px;height:10px">
		</div>
		
		<div id="aa" style="width:100%;height:100px;z-index:2;float:left;color:red;position:fixed;
							border-radius:5px;background-color:#DCDCDC" hidden="hidden">
			<div id="0" class="lei" style="width:100%;height:30px;line-height:30px;font-size:20px;padding-left:10px">收支明细</div>
			<hr style="margin:2px">
			<div id="2" class="lei" style="width:100%;height:30px;line-height:30px;font-size:20px;padding-left:10px">收入明细</div>
			<hr style="margin:2px">
			<div id="1" class="lei" style="width:100%;height:30px;line-height:30px;font-size:20px;padding-left:10px">支出明细</div>
		</div>
		
		<div id="main" style="width: 92%;
			margin-left:4%;
		    font-size: 18px;
		    top: 30px;
		    z-index:1;">
		</div>
    </div>
</body>
</html>