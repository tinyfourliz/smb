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
	String account_Key1 = Util.null2String((String) fu4.getParameter("accountKey"));
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
<title>神州币福利</title>
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
	var accountKey = '<%=account_Key1 %>';
	var itcode = '<%=it_code1 %>';
	var topicID;
	var topicName = "";
	var options;
	//true已签到，false未签到
	var signinFlag = true;

	$.ajax({
		url:"/mobile/plugin/dch/smb/getSigninStatus.jsp",
		data:{itcode:itcode},
		dataType:"json",
		success:function(data){
			if(data.status == 1){
				signinFlag = false;
				$("#qian").show();
				$("#qian1").hide();
				$("#qian2").hide();
			}
			$("#xx").html(data.value1);
			$("#xx1").html(data.value);
			$("#xx2").html(7 - (data.value%7));
		}
	});
	$(function(){
		$.ajax({
			url:"/mobile/plugin/dch/smb/vote/getVoteTodayTopic.jsp",
			dataType:"json",
			async:false, 
			success:function(data){
				if(data.status == "success"){
					topicName = data.topic;
					topicID = data.topicid;
					options = data.options;
				}else{
					alert(data.info);
				}
			}
		});

		var msg = "<div style='width:100%;' id='wor0k0'><div style='width:100%;height: 130px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;'><div style='width:70%;margin:0;padding-left:10px;height:100%;float:left'><b style='font-size:20px'>连续签到奖励</b><br/><font color='gray'>本日已签到</font><font id='xx' color='gray'></font><font color='gray'>人</font><br/><font color='gray'>您当月已连续签到</font><font id='xx1' color='gray'></font><font color='gray'>天</font><br/><font color='gray'>再签到</font><font id='xx2' color='gray'></font><font color='gray'>天可获得更高奖励</font><br/></div><div id='qian' hidden='hidden' style='float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:70px;text-align:center;border-radius:10px;color:white;margin-top:30px'>签到</div><div id='qian1' style='float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:gray;width:70px;text-align:center;border-radius:10px;color:white;margin-top:30px'>已签到</div><div id='qian2' hidden='hidden' style='float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:gray;width:70px;text-align:center;border-radius:10px;color:white;margin-top:30px'>签到中</div></div></div>";

		msg += "<div style='width:100%;margin-top:20px;background: #C0C0BB;padding-bottom:10px'><b style='font-size:20px;padding-left:20px'>投票奖励</b><br/><div style='text-align:center;font-size:15px'>(每日参与投票奖励1神州币)</br></div><div style='text-align:center;font-size:20px'>"
		//添加投票主题
		msg += topicName;

		msg += "</br></div><div style='text-align:center;font-size:20px'><font>人气值：</font><font id='vote"

		msg += topicID;

		msg += "Popularity'></font><br/></div>";

		for(var i=1; i <= options.length; i++){
			var msg1 = "<div class='option' topicID='" + options[i-1].topicid + "' optionID='" + options[i-1].optionid + "' style='padding-left:10px;width:94%;height:50px;border-bottom:1px solid black;margin-top:15px'><div style='color:white;background:#0f364c;float:left;width:40px;line-height:50px;margin:0;font-size:20px;text-align:center'>" + i + "</div><div style='float:left;height:50px;margin:0 0 0 15px;width:50%'><div class='optionkey' style='height:50%;margin:0'>" + options[i-1].optionkey + "</div></div><div style='float:right;width:60px;line-height:50px;text-align:center;margin:0'><font id='vote" + options[i-1].topicid + "Option" + options[i-1].optionid + "Popularity'></font><font>票</font></div></div>";
			msg += msg1;
		}

		msg += "</div><div id='warning' style='margin-left:10%;position:fixed;color:red' hidden='hidden'><b style='font-size:20px'>您的账户存在异常，请与管理员联系！</b><br/></div>";

		$("body").html(msg);

		$("#qian").click(function(){
			$("#qian").hide();
			$("#qian1").hide();
			$("#qian2").show();
			$.ajax({
				url:"/mobile/plugin/dch/smb/getSigninInfo.jsp",
				data:{itcode:itcode},
				dataType:"json",
				success:function(data){
					if(data.status == 1){
						$.ajax({
							url:"/mobile/plugin/dch/smb/getRewards.jsp",
							data:{itcode:itcode,reward:data.value},
							dataType:"text",
							success:function(data){
							}
						});
						$("#qian2").hide();
						$("#qian").hide();
						$("#qian1").show();
						location.reload();
					}else{
						$("#warning").show();
					}
				}
			});
		});

		$(".option").click(function(){
			var optionContent = this.children[1].innerText.trim();
			var topicID = this.getAttribute('topicID');
			var optionID = this.getAttribute('optionID');
			$(".option").each(function(){
				this.setAttribute("class","optionddddd");
			});
			$.ajax({
				url:"/mobile/plugin/dch/smb/vote/getTodayVoteStatus.jsp",
				data:{account:accountKey,
					topicID:topicID},
				dataType:"text",
				success:function(data){
					if (data.trim() == 'true') {
						var confirmMsg = "您确认投票 " + optionContent + " 选项吗？";
						if (confirm(confirmMsg)==true){
							$.ajax({
								url:"/mobile/plugin/dch/smb/vote/commmitVoteInfo.jsp",
								data:{topicID:topicID,
									optionID:optionID,
									account:accountKey},
								dataType:"text",
								success:function(data){
									alert("投票成功！");
									$.ajax({
										url:"/mobile/plugin/dch/smb/getVoteRewards.jsp",
										data:{itcode:itcode},
										dataType:"text",
										success:function(data){
										}
									});
									location.reload();
								}
							});
						}else{
							location.reload();	
						}
					}else{
						alert("您今日已投过该主题。");
						location.reload();
					}
				}
			});
		});

		$.ajax({
			url:"/mobile/plugin/dch/smb/vote/getVotePopularity.jsp",
			data:{topicID:topicID},
			dataType:"json",
			success:function(data){
				$("#vote" + topicID + "Popularity").html(data[0].popularity);
			}
		});

	
		$.ajax({
			url:"/mobile/plugin/dch/smb/vote/getOptionPopularity.jsp",
			data:{topicID:topicID},
			dataType:"json",
			success:function(data){
				$(data).each(function(){
					$("#vote" + this.topicid + "Option" + this.id + "Popularity").html(this.popularity);
				});
			}
		});
	});
</script>

</head>
<body style="font-family:微软雅黑" >
</body>
</html>