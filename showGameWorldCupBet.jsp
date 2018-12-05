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
	String it_code8 = Util.null2String((String) fu4.getParameter("itcode"));
	String match_id = Util.null2String((String) fu4.getParameter("matchid"));
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
<title>世界杯竞猜二级页面</title>
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
	var itcode = '<%=it_code8 %>';
    var matchid = '<%=match_id %>';
    var teamA = "";
    var teamB = "";
	var flag = true;
    $(function(){
    	var msg = "<div style='width:100%'><table id='tab' border='0' cellpadding='0' cellspacing='0' style='width:100%;margin:0;background:#DDDDDD'><img id='im' src='img/worldcup_bg1.png'>";
    	$.ajax({
			url:"getWorldCupMatchMsg.jsp",
			data:{matchid:matchid},
			async:false,
			dataType:"json",
			success:function(data){
				teamA = data.teamA;
				teamB = data.teamB;
				//展示比赛信息，两种状态，未开赛和已结束（显示比分）
				//以返回结构体中 data.result == "10"判断， 为真为未开赛。
				 msg += "<tr id='"+data.id+"' style='padding-top:10px'><td style='width: 30%;margin:10px 0 10px 0'><div style='margin:0 auto;width:100%;text-align:center'><div style='height:25px;'></div>";
        		 msg += "<img class='mg' src='img/"+data.teamaflag+"' style='display: inline-block;'/>";
        		 msg += "</div><div style='text-align: center;color: black;margin-bottom: 10px;'>"+data.teamA+"</div></td>";
        		 msg += "<td style='color: grey;width: 40%;text-align: center;'>";
        		 if(data.result == "10"){
        			 flag = false;
    	    		 msg += "<font color='green'>未开赛</font></br>";
	        		 msg += "<font>"+data.matchtime+"</font></br>";
	        		 msg += "<font color='red' size='5'>当前奖池："+data.betreward+"</font></br>";
        		 }else if(data.result == "11"){
    	    		 msg += "<font color='red'>停止竞猜</font></br>";
	        		 msg += "<font>"+data.matchtime+"</font></br>";
	        		 msg += "<font color='red' size='5'>当前奖池："+data.betreward+"</font></br>";
        		 }else{
        		 	msg += "<font color='red'>已结束，比分</font></br>";
        			msg += "<font color='red' size='5'>"+data.teamascore+":"+data.teambscore+"</font></br>";
        		 }
        		 
        		 msg += "</td><td style='width: 30%;margin:10px 0 10px 0'><div style='margin:0 auto;width:100%;text-align:center'><div style='height:25px;'></div>";
        		 msg += "<img class='mg' src='img/"+data.teambflag+"' style='display: inline-block;'/>";
        		 msg += "</div><div style='text-align: center;color: black;margin-bottom: 10px;'>"+data.teamB+"</div></td></tr></table></div>";
			}
		});
    	
    	var width = document.documentElement.clientWidth*0.96*0.3*0.8;
        var height = width*0.667;
        $("body").html(msg);
        $(".mg").css("width",width+"px");
        $(".mg").css("height",height+"px");
    	
		$.ajax({
			url:"getWorldCupBetMsg.jsp",
			data:{matchid:matchid,itcode:itcode},
			async:false,
			dataType:"text",
			success:function(data){
				//显示用户该场次投注信息，两种状态，未投注（显示投注界面）和已投注（显示投注详情）
				//未投注返回为空，已投注返回为bet结构体
				if(data.trim().length != 0){
					var obj = eval ("(" + data + ")");
					if(obj.betresult == "4"){
						var msge11 = "<div style='width:100%;margin:0;background:#DDDDDD;padding:10px 0 10px 0'><div style='margin:0 auto;width:80%;border-radius:10px;background:yellow;text-align:center;height:35px;line-height:35px'>您竞猜的结果是："+teamA+"胜</div></div>";
						$("body").append(msge11);
					}else if(obj.betresult == "5"){
						var msge11 = "<div style='width:100%;margin:0;background:#DDDDDD;padding:10px 0 10px 0'><div style='margin:0 auto;width:80%;border-radius:10px;background:yellow;text-align:center;height:35px;line-height:35px'>您竞猜的结果是：平局</div></div>";
						$("body").append(msge11);
					}else if(obj.betresult == "6"){
						var msge11 = "<div style='width:100%;margin:0;background:#DDDDDD;padding:10px 0 10px 0'><div style='margin:0 auto;width:80%;border-radius:10px;background:yellow;text-align:center;height:35px;line-height:35px'>您竞猜的结果是："+teamB+"胜</div></div>";
						$("body").append(msge11);
					}

					if (obj.result != null) {
						if(obj.betresult == obj.result){
							var msge12 = "<div style='width:100%;margin:0;background:#DDDDDD;padding:10px 0 10px 0'><div style='margin:0 auto;width:80%;border-radius:10px;background:yellow;text-align:center;height:35px;line-height:35px'>竞猜正确，获得" + obj.reward + "神州币奖励！</div></div>";
							$("body").append(msge12);
						}else{
							var msge12 = "<div style='width:100%;margin:0;background:#DDDDDD;padding:10px 0 10px 0'><div style='margin:0 auto;width:80%;border-radius:10px;background:yellow;text-align:center;height:35px;line-height:35px'>竞猜错误，请继续努力！</div></div>";
							$("body").append(msge12);
						}
					}
					
				}else{
					if(!flag){
						var msge = "<div id='tt' style='background:#DDDDDD;margin:0;padding:10px 0 10px 0'>";
						msge += "<input type='hidden' value='1' id='hi'>";
						msge += "<table  style='width:100%;margin:0 auto'><tr><td style='width:38%'>";
						msge += "<div id='1' class='bq' attr='4' style='margin:0 auto;width:80%;border-radius:10px;background:white;color:grey;border:1px solid grey;text-align:center;height:35px;line-height:35px'>"+teamA+"胜</div></td>";
						msge += "<td style='width:24%'><div id='1' class='bq' attr='5' style='margin:0 auto;width:80%;border-radius:10px;background:white;color:grey;border:1px solid grey;text-align:center;height:35px;line-height:35px'>平局</div></td>";
						msge += "<td style='width:38%'><div id='1' class='bq' attr='6' style='margin:0 auto;width:80%;border-radius:10px;background:white;color:grey;border:1px solid grey;text-align:center;height:35px;line-height:35px'>"+teamB+"胜</div></td></tr></table>";
						msge += "<div style='height:50px;'></div>";
						msge += "<div style='width:94%;background-color: #0f364c;height: 40px;font-size: 18px;text-align: center;line-height: 40px;margin:0 auto;border-bottom : 1px solid #a8a8a8;' id='betYourNumber1'><div style='width: 100%;margin:0' id='commitBet'><center><font size='3' color='white'>确认竞猜</font></center></div></div>";

						msge += "";
						$("body").append(msge);
						var width = document.documentElement.clientWidth;
					    var height = width*0.667;
						$("#tt").css("width",width+"px");
						$("#tab").css("width",width+"px"); 
					}else{
						var msge1 = "<div style='width:100%;margin:0;background:#DDDDDD;padding:10px 0 10px 0'><div style='margin:0 auto;width:80%;border-radius:10px;background:yellow;text-align:center;height:35px;line-height:35px'>您未参与本场竞猜!</div></div>";
						$("body").append(msge1);
					}
				}
				
			}
		});
	   	var w = document.documentElement.clientWidth;
		var h = w/2.2;
		$("#im").css("width",w+"px");
		$("#im").css("height",h+"px");

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
                $(this).parent().siblings().find(".bq").css("color","grey");
                $(this).parent().siblings().find(".bq").css("border","1px solid grey");
                $(this).parent().siblings().find(".bq").css("background","white");
                $(this).parent().siblings().find(".bq").prop("id","1");
            } 
        });

        //下注
        $("#commitBet").click(function(){
            if($("#hi").val() == "1"){
                var remark = "";
                $(".bq").each(function(){
                    if($(this).prop("id") == "2"){
                        remark = $(this).attr("attr");
                    }
                });

                $("#hi").val("-1");
                alert("竞猜状态确认有一定的延迟,请勿重复提交竞猜信息，竞猜结果请稍后刷新页面查看!");
                $.ajax({
                    url:"/mobile/plugin/dch/smb/commitTheWorldCupBet.jsp",
                    data:{itcode:itcode,remark:remark,matchid:matchid},
                    dataType:"text",
                    success:function(data){
                        
                    }
                });
                setTimeout(function() {
	                window.location.href="/mobile/plugin/dch/smb/showGameWorldCupBet.jsp?itcode="+itcode+"&matchid="+matchid;
                }, 2500);
            }else if ($("#hi").val() == "-1") {
                alert("请勿重复提交!");
            }else{
                alert("请选择您的竞猜信息!");
            }
        });
	});
</script>

</head>
<body style="font-family:微软雅黑;width:100%;margin:0;" >
	
</body>
</html>