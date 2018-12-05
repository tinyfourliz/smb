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
<title>猜数字</title>
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
            //是否投注;本次猜数;上次中奖数字;上次奖金;总奖池;下注人数
            if(data != "error"){
                var str = data.split(";");
                var ifBet = str[0];
                var thisTimeNum = str[1];
                var lastLuckyNum = str[2];
                var lastReward = str[3];
                var totalReward = str[4];
                var betCounter = str[5];

                $("#lastLuckyNum").html(lastLuckyNum);
                $("#lastReward").html(lastReward);
                $("#main").html(totalReward);
                $("#betCounter").html(betCounter);

                if (ifBet.trim() == "0") {
                    $("#startBet").show();
                    $("#thisTimeNum").html("未投注");
                } else if (ifBet.trim() == "1") {
                    $("#thisTimeNum").html(thisTimeNum);
                }
            }
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
        // 查看玩法简介
        $("#gameIntroduction").click(function(){
            alert(" 1、每人每期可选择数字X作为自己本期的幸运数字； \n 2、系统每期将随机生成一个幸运数字Y； \n 3、每期参与人数上限为50人，超过则自动进入下一期； \n 4、若X=Y，则可获得奖池奖励，奖励金额=（奖池金额）/（当期幸运数字为Y的人数）； \n 5、区块链APP会在猜选和奖金分发时扣除一定量的手续费（约为0.2神州币）； \n 6、为保证可正常参与游戏，请确保账户余额大于10神州币； \n 7、如有任何问题，请与mojja或fannl联系，本活动最终解释权归DCG信息化管理部所有。");
        });
        // 刷新账户余额
        $("#re").click(function(){
            window.location.href="/mobile/plugin/dch/smb/showGameCasino.jsp?itcode="+itcode;
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
                alert("结果确认有一定的延迟,请勿重复提交幸运数字，1分钟左右刷新页面即可查看!");
                $.ajax({
                    url:"/mobile/plugin/dch/smb/commitBet.jsp",
                    data:{itcode:itcode,remark:remark},
                    dataType:"text",
                    success:function(data){
                        
                    }
                });
                window.location.href="/mobile/plugin/dch/smb/showGameCasino.jsp?itcode="+itcode;
            }else if ($("#hi").val() == "-1") {
                alert("请勿重复提交!");
            }else{
                alert("请选择您的幸运数字!");
            }
        });
	})
</script>

</head>
<body style="font-family:微软雅黑" >
	<div id="bod" style="height:100%;overflow-x:hidden;margin:5px">
		<div style="width:100%;height:185px;background-color:#0f364c;margin:0;padding-top:20px">
            <div id="gameIntroduction" style="float:right;height:40px;margin-right:10px;line-height:40px;font-size:18px;border:1px solid white;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">玩法简介
            </div>
			<div style="margin-left:10px;color:white;width:100%">
				本期奖池(神州币)
			</div>
			<div id="main" style="margin-top:10px;margin-left:50px;color:white;width:100%;font-size:60px;">
			</div>
            <div style="width:100%"><img src="img/refresh.png" style="width:20px;height:20px;margin-left:90%" id="re" />
            </div>
		</div>
		<div id="dowork" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/benqiyuce.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;本期选择数字
			<span id="thisTimeNum" style="float:right;line-height:50px;font-size:20px">···</span>
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div id="zhuanzhang" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/shangqishuzi.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;上期幸运数字
			<span id="lastLuckyNum" style="float:right;line-height:50px;font-size:20px">...</span>
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/shangqijine.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;上期幸运奖励
			<span id="lastReward" style="float:right;line-height:50px;font-size:20px">...</span>
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div id="mingxi" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/yucerenshu1.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;当前参与人数
			<span style="float:right;line-height:50px;font-size:20px">/50</span>
			<span id="betCounter" style="float:right;line-height:50px;font-size:20px">···</span>
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div id="startBet" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px" hidden="hidden">
			<img src="img/startBet.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;开始参与
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
    		<div style="width: 100%;margin:0" id="commitBet"><center><font size="3" color="white">确认参与</font></center></div>
    	</div>
	</div>
</body>
</html>