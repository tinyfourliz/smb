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
<title>虚拟机申请</title>
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
	var itcode = '<%=it_code1 %>';

    $.ajax({
        url:"/mobile/plugin/dch/smb/casinoCheckStatus.jsp",
        data:{itcode:itcode},
        dataType:"text",
        success:function(data){
        }
    });

	$(function(){
        // 修改标签的样式
        $(".bq").click(function(){
            if($(this).prop("id") == "2"){
                $(this).css("color","grey");
                $(this).css("border","1px solid grey");
                $(this).css("background","white");
                $(this).prop("id","1");
            } else if($(this).prop("id") == "1"){
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

		$("#startBet").click(function(){
            $("#startBet").hide();
			$("#betYourNumber").show();
            $("#betYourNumber1").show();
		});
        //下注
        $("#commitBet").click(function(){
            if($("#hi").val() == "1"){
                var remark = "";
                $(".bq").each(function(){
                    if($(this).prop("id")=="2"){
                        remark = $(this).text();
                    }
                });

                $("#hi").val("-1");
                alert("下注可能有一定的延迟,请稍后查询!" + remark);
                $.ajax({
                    url:"/mobile/plugin/dch/smb/commitBet.jsp",
                    data:{itcode:itcode,remark:remark},
                    dataType:"text",
                    async:false,
                    success:function(data){
                        
                    }
                });
                window.location.href="/mobile/plugin/dch/smb/smb.jsp";
            }else if ($("#hi").val() == "-1") {
                alert("请勿重复下注!");
            }else{
                alert("请选择您要下注的数字!");
            }
        });
	})
</script>

</head>
<body style="font-family:微软雅黑" >
	<div id="bod" style="height:100%;overflow-x:hidden;margin:5px">
		<div style="width:100%;height:150px;background-color:#0f364c;margin:0;padding-top:20px">
			<div style="margin-left:10px;color:white;width:100%">
				本期奖池(神州币)
			</div>
			<div id="main" style="margin-top:10px;margin-left:50px;color:white;width:100%;font-size:60px;">
			</div>
		</div>
		<div id="dowork" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/benqiyuce.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;本期预测数字
			<span id="thisTimeNum" style="float:right;line-height:50px;font-size:20px">···</span>
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div id="zhuanzhang" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/shangqishuzi.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;上期中奖数字
			<span id="lastLuckyNum" style="float:right;line-height:50px;font-size:20px">···</span>
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/shangqijine.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;上期中奖金额
			<span id="lastReward" style="float:right;line-height:50px;font-size:20px">···</span>
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div id="mingxi" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/yucerenshu1.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;当期下注人数
			<span style="float:right;line-height:50px;font-size:20px">/20</span>
			<span id="betCounter" style="float:right;line-height:50px;font-size:20px">···</span>
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div id="startBet" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px" hidden="hidden">
			<img src="img/startBet.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;开始投注
			<img src="img/1.png" style="float:right;width:30px;height:30px;margin-top:10px" >
		</div>

		<div id="betYourNumber" hidden="hidden" style="overflow-y:scroll;height:270px">
			<input type="hidden" value="1" id="hi" >
			<div style="height:50px;margin-left:10px;margin-right:10px;font-size:20px;margin-top:30px" >
				<div style="font-size:20px;width:100%;margin-bottom:15px;color:gray">选择您的幸运数字:</div>
				<div id="1" class="bq" style="border:1px solid grey;float:left;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px">1</div>
				<div id="1" class="bq" style="border:1px solid grey;float:left;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px;margin-left:2%">2</div>
				<div id="1" class="bq" style="border:1px solid grey;float:left;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px;margin-left:2%">3</div>
				<div id="1" class="bq" style="border:1px solid grey;float:left;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px;margin-left:2%">4</div>
				<div id="1" class="bq" style="border:1px solid grey;float:right;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px;">5</div>
				<div style="margin:10px 0px 10px 0px;height:30px;"></div>
				<div id="1" class="bq" style="border:1px solid grey;float:left;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px">6</div>
				<div id="1" class="bq" style="border:1px solid grey;float:left;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px;margin-left:2%">7</div>
				<div id="1" class="bq" style="border:1px solid grey;float:left;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px;margin-left:2%">8</div>
				<div id="1" class="bq" style="border:1px solid grey;float:left;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px;margin-left:2%">9</div>
				<div id="1" class="bq" style="border:1px solid grey;float:right;width:18%;text-align:center;color:grey;border-radius:3px;font-size:18px;">10</div>
			</div>
           
        </div>
		<div style="width:96%;
    		background-color: #0f364c;
		    height: 40px;
		    font-size: 18px;
		    position: fixed;
		    bottom: 0;
		    text-align: center;
		    line-height: 40px;
		    margin:0 auto;
		    border-bottom : 1px solid #a8a8a8;" id="betYourNumber1" hidden="hidden">
    		<div style="width: 100%;margin:0" id="commitBet"><center><font size="3" color="white">确认下注</font></center></div>
    	</div>
	</div>
</body>
</html>