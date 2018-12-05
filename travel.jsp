<%@ page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="com.dch.mobile.trav.ws.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	// 获取用户信息
	BaseBean b = new BaseBean();
	User _user = HrmUserVarify.getUser(request, response);
	String _itcode = _user.getLoginid();
	TravalBefore travel = new TravalBeforeProxy();
	String apliInfo = null;
	String aproInfo = null;
	try{
		apliInfo = travel.GETAPLINFO(_itcode);
	}catch(Exception e){
		apliInfo = "-1";
	}
	try{
		aproInfo = travel.GETAPRINFO(_itcode);
	}catch(Exception e){
		aproInfo = "-1";
	}
	b.writeLog("获取的申请为-------"+apliInfo);
	b.writeLog("获取的审批为-------"+aproInfo);
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
<title>差旅计划</title>
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/jqueryui.js"></script>
<script src="js/touch_push.js" type="text/javascript"></script>
<script>
	$(function(){
		var $type = localStorage.getItem("type");
		if($type=="1"){
			// 如果是从待我审批跳转回来则页面默认显示待我审批列表
			getAproInfo();
			$("#spr1").css("background-color","#2C84F8");
			$("#spl1").css("background-color","white");
			$("#sprt").css("color","#2C84F8");
			$("#splt").css("color","black");
			localStorage.setItem("type","");
		}else{
			getApliInfo();// 页面加载时查询并显示我的申请
		}
		// 点击显示我的申请
		$("#spl").click(function(){
			getApliInfo();
			$("#spl1").css("background-color","#2C84F8");
			$("#spr1").css("background-color","white");
			$("#splt").css("color","#2C84F8");
			$("#sprt").css("color","black");
		});
		// 点击显示待我审批
		$("#spr").click(function(){
			getAproInfo();
			$("#spr1").css("background-color","#2C84F8");
			$("#spl1").css("background-color","white");
			$("#sprt").css("color","#2C84F8");
			$("#splt").css("color","black");
		});
		// 跳转新建申请页面
		$("#newTrav").click(function(){
			window.location.href="newTravl.jsp";
		});
		
    	// 查询我的申请
		function getApliInfo(){
		if(<%=apliInfo %>=="-1"){
				$("#main").html("查询失败,请稍后重试");
			}else{
      			var aplJson = eval('<%=apliInfo %>');
      			var aplStr = "";
      			for(var i=0;i<aplJson.length;i++){
      				var v = JSON.stringify(aplJson[i]);
      				aplStr += "<div class='sq' id='"+v+"' style='border-bottom:1px solid #B8B8B8;padding:10px'>";
      				aplStr += "<b>从&nbsp;"+aplJson[i].StStartDate+"&nbsp;到&nbsp;"+aplJson[i].StEndDate+"</b>";
      				aplStr += "<b style='float: right;text-align:right;'>"+aplJson[i].StProposerZH+"</b><br />";
      				aplStr += "<font color='gray'>申请日期:&nbsp;&nbsp;"+aplJson[i].StAppDate+"&nbsp;&nbsp;目的地:&nbsp;&nbsp;"+aplJson[i].StToCity+"</font><br />";
      				if(aplJson[i].TFCurNodeName=="结束"){
      					aplStr += "<img src='img/trip-icon3.png' width='15px' height='15px'>&nbsp;&nbsp;<font color='#2C84F8'>已完成</font>";
      				}else{
      					aplStr += "<img src='img/approving.png' width='15px' height='15px'>&nbsp;&nbsp;<font color='orange'>审批中&nbsp;&nbsp;("+aplJson[i].TFCurNodeName+"/"+aplJson[i].TFCurNodeAuthors+")</font>";
      				}
      				aplStr += "</div>";
      			}
      			$("#main").html(aplStr);
     		}
     		// 显示申请的详细信息
			$(".sq").click(function(){
				location.reload();
				var sqMsg = $(this).prop('id');
				localStorage.setItem("msg",sqMsg);
				window.location.href="showApply.jsp";
			});
     	}
    		
     	// 查询待我审批
		function getAproInfo(){
			if(<%=aproInfo %>=="-1"){
				$("#main").html("查询失败,请稍后重试");
			}else{
      			var aproJson = eval('<%=aproInfo %>');
      			var aproStr = "";
      			for(var i=0;i<aproJson.length;i++){
      				var vv = JSON.stringify(aproJson[i]);
      				aproStr += "<div class='sp' id='"+vv+"' style='border-bottom:1px solid #B8B8B8;padding:10px'>";
      				aproStr += "<b>从&nbsp;"+aproJson[i].StStartDate+"&nbsp;到&nbsp;"+aproJson[i].StEndDate+"</b>";
      				aproStr += "<b style='float: right;text-align:right;'>"+aproJson[i].StProposerZH+"</b><br />";
      				aproStr += "<font color='gray'>申请日期:&nbsp;&nbsp;"+aproJson[i].StAppDate+"&nbsp;&nbsp;目的地:&nbsp;&nbsp;"+aproJson[i].StToCity+"</font><br />";
      				aproStr += "<font color='gray'>"+aproJson[i].TFCurNodeName+"&nbsp;/&nbsp;"+aproJson[i].StProposerEN+"</font>";
      				aproStr += "</div>";
      			}
      			$("#main").html(aproStr);
     			}
     			// 显示审批的详细信息
				$(".sp").click(function(){
					location.reload();
					var spMsg = $(this).prop('id');
					localStorage.setItem("msg",spMsg);
					window.location.href="showApro.jsp";
				});
     	}
     	
     	
     	
	});
</script>

</head>
<body style="font-family:'微软雅黑'">
<div id="containment-wrapper" style="width: 100%;">
		<!-- 浮动的按钮  用于外部链接 -->
    <!-- 	<div id="draggable3" class="draggable ui-widget-content" style="position: absolute;
            top:0;
            right:0;
            width: 50px;
            height: 50px;
            background: #E0E0E0;
            border-radius:10px;">
            	<div style="width:40px;height:40px;border:3px solid white;border-radius:20px;margin-top:5px;margin-left:5px;opacity:0.5;">
    	    		<img id="div3" src="img/waibu.png" width="100%" height="100%" />
    	    	</div>
    	</div>  -->
    	
		<div style="width: 95%;margin: 0 auto;" id="head">
    		<span style="width: 49%;float: left;margin-bottom:10px;margin-top:10px;margin-left:0;margin-right:0;" id="spl"><center><font size="3" id="splt" style="color: #2C84F8;">我的申请</font></center></span>
    			<div style="float:left;margin-left:0;margin-right:0;margin-top:5px;margin-left:0;width:1px;border:1px solid #C0C0C0;height:30px"></div>
    		<span style="width: 49%;float: right;margin-bottom:10px;margin-top:10px;margin-left:0;margin-right:0;" id="spr"><center><font size="3" id="sprt">待我审批</font></center></span>
    		<span style="width: 49%;float: left;height: 2px;background-color: #2C84F8;" id="spl1"></span>
    		<span style="width: 49%;float: right;height: 2px;" id="spr1"></span>
    	</div>
    	<div style="height: 30px">
    	</div>
    	<div id="main" style="width: 95%;margin: 0 auto;height:600px;overflow-y:scroll">
    	</div>
    	<div style="height:35px"></div>
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
    		<div style="width: 80%;margin:0;float:left;"><center><font size="3" color="white" id="newTrav">新建申请</font></center></div>
    		<div  style="width: 10%;margin:0;float:right;height:100%"><img id="waibu" src="img/aa.png" width="100%" height="100%" /></div>
    	</div>
</div>    	
    	
    <!-- 外部链接模态框 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><center>友&nbsp;情&nbsp;链&nbsp;接</center></h4>
            </div>
            <div class="modal-body" style="height: 200px">
            	<center><font size="4" color="#2C84F8" id="id1">机票预订</font></center>
            	<hr style="margin:10px">
   				<center><font size="4" color="#2C84F8" id="id2">酒店预订</font></center>
            	<hr style="margin:10px">
				<center><font size="4" color="#2C84F8" id="id3">差旅政策</font></center>
            	<hr style="margin:10px">
            	<center><font size="4" color="#2C84F8" id="id4">常见问题</font></center>
			<div id="MainccID"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
   
	<script>
     $(function(){
     	$( "#draggable3" ).draggable({ containment: "#containment-wrapper", scroll: false });
     	
     	$("#aa").click(function(){
     		window.location.href="aaa.jsp";
     	});
     	/* $("#div3").click(function(){
     		 // 弹出模态框
			 $('#myModal').modal({
        		keyboard: true
    		});
     	}); */
     	$("#waibu").click(function(){
     		 // 弹出模态框
			 $('#myModal').modal({
        		keyboard: true
    		});
     	});
     	
     	// 外部链接
     	$("#id1").click(function(){
     		window.location.href="http://c.eqxiu.com/s/rBPLawkh";
     	});
     	$("#id2").click(function(){
     		window.location.href="http://c.eqxiu.com/s/1I9wqcZZ";
     	});
     	$("#id3").click(function(){
     		window.location.href="http://c.eqxiu.com/s/ElyIdg7I";
     	});
     	$("#id4").click(function(){
     		window.location.href="http://b.eqxiu.com/s/MuFrukWj";
     	});
     });
     
</script>
</body>
</html>