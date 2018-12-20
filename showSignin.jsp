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
<link rel="stylesheet" href="./css/trav.css"/>
<link rel="stylesheet" href="./css/bootstrap.min.css" type="text/css" />
<script src="./js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="./css/weui.min.css" />
<link rel="stylesheet" href="./css/jquery-weui.min.css" />
<link rel="stylesheet" href="./css/icon.css" />
<link rel="stylesheet" href="./css/task.css" />
<script type='text/javascript' src='./js/jquery.textarea.autoheight.js'></script>
<script type='text/javascript' src='./js/jquery.form.js'></script>
<script type='text/javascript' src="./js/jquery-weui.js"></script>
<script type='text/javascript' src='./js/fastclick.min.js'></script>
<script type='text/javascript' src='./js/web3.min.js'></script>
<script type='text/javascript' src='./js/bignumber.js'></script>
<style type="text/css">
.btn-circle {  width: 30px;  height: 30px;  text-align: center;  padding: 6px 0;  font-size: 12px;  line-height: 1.428571429;  border-radius: 15px;}.btn-circle.btn-lg {  width: 50px;  height: 50px;  padding: 10px 16px;  font-size: 18px;  line-height: 1.33;  border-radius: 25px;}.btn-circle.btn-xl {  width: 70px;  height: 70px;  padding: 10px 16px;  font-size: 24px;  line-height: 1.33;  border-radius: 35px;}
	.tanchu{
		display: none;
		background:url(./img/luckyCash.png);
		background-repeat:no-repeat;
		background-size:100% 100%;
		-moz-background-size:100% 100%;
	    position: absolute;
	    top: 25%;
	    left: 5%;
	    width: 90%;
	    height: 400px;
	    border: 2px solid #d3d3d3;
	    background-color: white;
	    z-index: 1002;
	}
	#luckyImg{
		background:url(./img/luckyCash.png);
		background-repeat:no-repeat;
		background-size:100% 100%;
		-moz-background-size:100% 100%;

	    position: absolute;
	    top: 25%;
	    left: 5%;
	    width: 90%;
	    /*border: 2px solid #d3d3d3;
	    background-color: white;*/
	    z-index: 1002;
	}
</style>
<script type="text/javascript">
	var accountKey = '<%=account_Key1 %>';
	var itcode = '<%=it_code1 %>';
	var topicID;
	var topicName = "";
	var options;

	var luckyHeight = document.documentElement.clientWidth * 0.9 / 800 * 492;
	var fontHeight = luckyHeight / 492 * 40;
	var fontWidth = fontHeight * 5;
	var fontTop = luckyHeight / 492 * 266;
	var fontLeft = luckyHeight / 492 * 300;

	//抽奖
	var infoData;
    var detailData;
    var boughtCount;
    var lotteryId = 13;

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
		// var msgTanchu = "<div id='MyDiv' class='tanchu'></div>";
	
		var msgTanchu = "<div class='modal fade' id='luckyModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true' style='top:20%;'><div class='modal-dialog'><div class='modal-content'><div id='luckyImg' class='modal-body' align='center'><font id='luckyNumber' style='position:absolute;color:red;font-weight:bold'></font></div></div></div></div>"

		var msg = "<div style='width:100%;' id='wor0k0'><div style='width:100%;height: 130px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;border: 2px solid #EDEDED;'><div style='width:70%;margin:0;padding-left:10px;height:100%;float:left'><b style='font-size:20px'>连续签到奖励</b><br/><font color='gray'>本日已签到</font><font id='xx' color='gray'></font><font color='gray'>人</font><br/><font color='gray'>您当月已连续签到</font><font id='xx1' color='gray'></font><font color='gray'>天</font><br/><font color='gray'>再签到</font><font id='xx2' color='gray'></font><font color='gray'>天可获得更高奖励</font><br/></div><div id='qian' hidden='hidden' style='float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:70px;text-align:center;border-radius:10px;color:white;margin-top:40px'>签到</div><div id='qian1' style='float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:gray;width:70px;text-align:center;border-radius:10px;color:white;margin-top:40px'>已签到</div><div id='qian2' hidden='hidden' style='float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:gray;width:70px;text-align:center;border-radius:10px;color:white;margin-top:40px'>签到中</div></div></div>";


		msg += "<div style='width:100%;margin-top:20px;border: 2px solid #EDEDED;padding-bottom:10px'><b style='font-size:20px;padding-left:20px'>投票奖励</b><br/><div style='text-align:center;font-size:15px'>(每日参与投票奖励1神州币)</br></div><div style='text-align:center;font-size:20px'>"
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

		msg += "<div align='center' style='margin-top: 5%;margin-bottom:5%;border: 2px solid #EDEDED;'><b style='font-size:20px;padding-left:20px;float:left;'>神州币夺宝</b><a href='./test/lotteryIntroduce.jsp' style='float:right;padding-right:30px;padding-top:5px;'>玩法简介</a>"
		            +"<div style='border: 2px solid #EDEDED;border-top: none;'>"
		                +"<img src='./img/lottery1.jpg'  class='img-responsive center-block' style='padding-top: 8px;padding-bottom: 5px;width:95%;height:180px;'>"
		                +"<div style='border: 1px solid #EDEDED;border-top: none;'>"
		                    +"<font id='fontReword' style='text-align: center;'></font>"
		                    +"<div class='progress' style='margin-top: 8px;width:95%;'>"
		                        +"<div id='divProgress' class='progress-bar progress-bar-success' role='progressbar'"
		                            +"aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 100%;'>"
	                        +"</div>"
	                    +"</div>"
	                    +"<font style='text-align: center;color: gray;'>已累计 <strong id='strHaved'></strong>&nbsp;&nbsp;&nbsp;总需金额 <"
	                    +"strong id='strSum'></strong>&nbsp;&nbsp;&nbsp;剩余 <strong id='strRest'></strong></font>"
	                +"</div>"
	                +"<div id='divBottom' style='margin-top: 5px; margin-bottom: 5px;height: 30px;vertical-align: middle;'>"
	                +"</div>"
	            +"</div>"
	        +"</div>"
	        +"<div id='divWait' class='col-xs-12 col-md-12' align='center' style='position: fixed;left: 50%;top: 50%;transform: translateX(-50%)translateY(-50%);-webkit-transform:translateX(-50%) translateY(-50%);'>"
	            +"<img id='waitGif' src='./img/walletWait.gif' hidden='hidden'>"
	        +"</div>"
	        +"<div id='divRefresh' style='margin-top: 2px; bottom: 30px;'>"
	        	+"<button type='button' onClick='reloadPage()' class='btn btn-default btn-lg btn-block' style:'margin-bottom30px;'>刷新</button>" 
            +"</div>"

		$("body").append(msgTanchu + msg);

		$("#qian").click(function(){
			$("#qian").hide();
			$("#qian1").hide();
			$("#qian2").show();
			$.ajax({
				url:"/mobile/plugin/dch/smb/getSigninInfo.jsp",
				data:{itcode:itcode},
				dataType:"json",
				success:function(data){
					console.log(data);
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
						var luckyNum = data.lucky;
						if(!(luckyNum === "none")){
						// if(luckyNum === "none" && itcode === "fannl"){
							// $("#MyDiv").toggle();
							// console.log("luckyNum:" + luckyNum);
							$("#luckyImg").css("height",luckyHeight+"px");

							$("#luckyNumber").css("height",fontHeight+"px");
							$("#luckyNumber").css("width",fontWidth+"px");
							$("#luckyNumber").css("top",fontTop+"px");
							$("#luckyNumber").css("left",(fontLeft-7)+"px");
							$("#luckyNumber").css("line-height",fontHeight+"px");

							$("#luckyNumber").html(luckyNum);

							$("#luckyModal").modal('show');

							setTimeout(function() {
								location.reload();
							},5000);
						}else{
							location.reload();
						}
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

		function changeProgress(valueNow) {
            var valueMax = $("#divProgress").attr("aria-valuemax");
            $("#divProgress").attr("aria-valuenow",valueNow);
            $("#divProgress").attr("style","width: "+ valueNow/valueMax*100 +"%;");
        }

        //发送请求，获取此次夺宝信息，查看该用户是否参与此次夺宝，若参与，展示夺宝号码
        $.ajax({
            type: "GET",
            url: "/mobile/plugin/dch/smb/getLotteryInfo.jsp",
            data: {"jsonStr" : JSON.stringify({
                "itcode" : itcode,
                "id" : lotteryId
            })},
            dataType: "json",
            success: function(data) {
                if (data.success) {
                    infoData = data.infoData;
                    detailData = data.detailData;
                    boughtCount = detailData.length;
                    $("#fontReword").text(infoData.description);
                    $("#strHaved").text(infoData.nowSumAmount);
                    $("#strSum").text(infoData.winSumAmount);
                    $("#strRest").text(infoData.winSumAmount - infoData.nowSumAmount);
                    $("#divProgress").attr("aria-valuemax",infoData.winSumAmount);
                    changeProgress(infoData.nowSumAmount);
                    //已开奖
                    if(infoData.flag == 1) {
                        var htmlStr = "<a onClick='viewResult()'>查看结果</a>";
                        $("#divBottom").html(htmlStr);
                        return;
                    }
                    
                    //判断是否参与
                    var innerHtml = "";
                    if (boughtCount > 0) {
                        innerHtml = "<font style='float: left; margin-left: 15px;'>已购买&nbsp;<strong>" + boughtCount + "</strong>&nbsp;次</font>"
                                    +"<a onClick='viewTicket()'>查看夺宝号 </a>"
                                    +"<button id='btnBuy' type='button' onClick='buyClick()' class='btn btn-default btn-xs' style='float: right; margin-right: 15px;'>继续购买</button>";
                    } else {
                        innerHtml = "<button type='button' class='btn btn-info btn-sm' onClick='buyClick()'>立即抢购</button>";
                    }
                    $("#divBottom").html(innerHtml);
                }
            }
        });

        window.reloadPage = function() {
        	location.reload();
        }

        //点击购买按钮
        window.buyClick = function() {
            if (boughtCount >= infoData.limitEveryday) {
                alert("已达购买上限");
                return;
            }
            if($("#divProgress").attr("aria-valuenow") == $("#divProgress").attr("aria-valuemax")) {
                alert("已售罄，请等待开奖");
                return;
            }
            if(confirm("您确认花费 "+ infoData.unitPrice +"SZB 购买吗？") == true){
                $("#waitGif").show();
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/getBuyTicket.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode,
                        "unitPrice" : infoData.unitPrice,
                        "lotteryId" : infoData.id
                    })},
                    dataType: "json",
                    success: function(data) {
                        if (data.success) {
                            $("#waitGif").hide();
                            if(data.data == "balanceNotEnough") {
                                alert("您的余额不足!");
                                return;
                            }
                            if(data.data == "lotteryOver") {
                                alert("已结束，请等待开奖!");
                                return;
                            }
                            alert("正在生成夺宝码，请稍后查看");
                            boughtCount += 1;
                            var htmlStr = "<font style='float: left; margin-left: 15px;'>已购买&nbsp;<strong>" + boughtCount + "</strong>&nbsp;次</font>"
                                                    +"<a onClick='viewTicket()'>查看夺宝号 </a>"
                                                    +"<button id='btnBuy' type='button' class='btn btn-default btn-xs' style='float: right; margin-right: 15px;' onClick='buyClick()'>继续购买</button>";
                             $("#divBottom").html(htmlStr);

                            var nowAmount = parseInt($("#divProgress").attr("aria-valuenow"))+10;
                            changeProgress(nowAmount);
                            $("#strHaved").text(nowAmount);
                            $("#strRest").text(infoData.winSumAmount - nowAmount);
                        }
                    }
                });
            }
        }

        //点解查看夺宝码按钮
        window.viewTicket = function() {
            $.ajax({
                type: "GET",
                url: "/mobile/plugin/dch/smb/getLotteryInfo.jsp",
                data: {"jsonStr" : JSON.stringify({
                    "itcode" : itcode,
                    "id" : lotteryId
                })},
                dataType: "json",
                success: function(data) {
                    if (data.success) {
                        var detailTemp = data.detailData;
                        var htmlStr = "";
                        for(var index = 0; index < detailTemp.length; index++) {
                            var ticket = detailTemp[index].backup3 == 0 ? "生成中" : detailTemp[index].ticket;
                            htmlStr += "<tr><td id='tdTime' style='word-break: break-all;text-align: center;'>"+detailTemp[index].buyTime+"</td><td id='tdTicket' style='word-break: break-all;text-align: center;'>"+ticket+"</td></tr>";
                        }
                        $("#modalTbody").html(htmlStr);
                        $("#transactionModal").modal('show');
                    }
                }
            });
        }

        //查看结果
        window.viewResult =function() {	
        	console.log("查看结果");
            var numberArr = infoData.winTicket.split("&");
            var winnerArr = infoData.winner.split("&");
            var htmlStr1 = "";
            for(var index = 0; index < numberArr.length; index++) {
                htmlStr1 += "<tr><td style='word-break: break-all;text-align: center;'>"+numberArr[index]+"</td><td style='word-break: break-all;text-align: center;'>"+winnerArr[index]+"</td></tr>";
            }
            var htmlStr2 = "";
            var rewordArr = [];
            if(detailData.length == 0) {
                htmlStr2 += "<tr><td id='tdTime' style='word-break: break-all;text-align: center;'>抱歉，您未参与！</td></tr>";
                $("#modalResult").html(htmlStr1);
                $("#modalMine").html(htmlStr2);
                $("#resultModal").modal('show');
                return;
            }

            for(var index = 0; index < detailData.length; index++) {
                for(var j = 0; j < numberArr.length; j++) {
                    if (numberArr[j] == detailData[index].ticket) {
                        htmlStr2 += "<tr><td id='tdTime' style='word-break: break-all;text-align: center;color:red;'>"+detailData[index].ticket+"</td></tr>";
                        rewordArr.push(detailData[index].winReword);
                    } else {
                        htmlStr2 += "<tr><td id='tdTime' style='word-break: break-all;text-align: center;'>"+detailData[index].ticket+"</td></tr>";
                    }
                }
            }

            var htmlStr3 = "";
            if(rewordArr.length == 0) {
                htmlStr3 += "<tr><td id='tdTime' style='word-break: break-all;text-align: center;'>很抱歉，您未中奖</td></tr>";
            } else {
                var rewordStr = ""
                for (var i = 0; i < rewordArr.length; i++) {
                    rewordStr += rewordArr[i] + "，";
                }
                htmlStr3 += "<tr><td id='tdTime' style='word-break: break-all;text-align: center;'>恭喜您获奖，红包码为：<strong style='color:red;'>" + rewordStr +"</strong>请在支付宝中搜索领取。</td></tr>";
            }

            console.log("zheli");
            $("#modalResult").html(htmlStr1);
            $("#modalMine").html(htmlStr2);
            $("#modalHongbao").html(htmlStr3);
            $("#lotteryTab").show();
            $("#resultModal").modal('show');
        }
	});
</script>

</head>
<body style="font-family:微软雅黑" >
	<div class="modal" id="transactionModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div id="divKeystore" class="modal-body">
                    <table class="table table-condensed" style="table-layout: fixed;">
                        <caption id="tabCaption" style="word-break: break-all;text-align: center;">购买记录</caption>
                        <col style="width: 50%" />
                        <col style="width: 50%" />
                        <thead>
                            <tr>
                              <th style="text-align: center;color: gray;font-size: 80%;">购买时间</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">夺宝码</th>
                            </tr>
                        </thead>
                        <tbody id="modalTbody">
                        </tbody>
                    </table>
                </div>
                <!-- <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div> -->
            </div>
        </div>
    </div>  
    <div class="modal" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <table class="table table-condensed" style="table-layout: fixed;">
                        <caption id="tabCaption" style="word-break: break-all;text-align: center;">开奖结果</caption>
                        <col style="width: 50%" />
                        <col style="width: 50%" />
                        <thead>
                            <tr>
                              <th style="text-align: center;color: gray;font-size: 80%;">获奖码</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">获奖人Itcode</th>
                            </tr>
                        </thead>
                        <tbody id="modalResult">
                        </tbody>
                    </table>
                    <table class="table table-condensed" style="table-layout: fixed;">
                        <caption id="tabCaption" style="word-break: break-all;text-align: center;">我的夺宝码</caption>
                        <tbody id="modalMine">
                        </tbody>
                    </table>
                    <table id="lotteryTab" class="table table-condensed" style="table-layout: fixed;" hidden="hidden">
                        <caption id="tabCaption" style="word-break: break-all;text-align: center;color: red;">中奖提示</caption>
                        <tbody id="modalHongbao">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>