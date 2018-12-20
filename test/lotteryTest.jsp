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
        <title>神州币夺宝</title>
        <link rel="stylesheet" href="../css/trav.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css" />
        <script src="../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../css/weui.min.css" />
        <link rel="stylesheet" href="../css/jquery-weui.min.css" />
        <link rel="stylesheet" href="../css/icon.css" />
        <link rel="stylesheet" href="../css/task.css" />
        <script type='text/javascript' src='../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../js/jquery.form.js'></script>
        <script type='text/javascript' src="../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../js/web3.min.js'></script>
        <script type='text/javascript' src='../js/bignumber.js'></script>

        <script type="text/javascript">
        	var itcode = '<%=it_code1 %>';
            var infoData;
            var detailData;
            var boughtCount;
            var id = 10;
        	$(function() {
                function changeProgress(valueNow) {
                    var valueMax = $("#divProgress").attr("aria-valuemax");
                    $("#divProgress").attr("aria-valuenow",valueNow);
                    $("#divProgress").attr("style","width: "+ valueNow/valueMax*100 +"%;");
                }

                //发送请求，获取此次夺宝信息，查看该用户是否参与此次夺宝，若参与，展示夺宝号码
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/test/getLotteryInfo.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode,
                        "id" : id
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
                            url: "/mobile/plugin/dch/smb/test/getBuyTicket.jsp",
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
                        url: "/mobile/plugin/dch/smb/test/getLotteryInfo.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "id" : id
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

                    $("#modalResult").html(htmlStr1);
                    $("#modalMine").html(htmlStr2);
                    $("#modalHongbao").html(htmlStr3);
                    $("#lotteryTab").show();
                    $("#resultModal").modal('show');
                }

            });
        </script>
    </head>
    <body style="font-family:微软雅黑;" >
    	 <div class="container" style="">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="margin-top: 5%;">
                    <div style="border: 1px solid #EDEDED;">
                        <img src="../img/rmb100.jpg"  class="img-responsive center-block" style="padding-top: 8px;padding-bottom: 5px;">
                        <div style="border: 1px solid #EDEDED;border-top: none;">
                            <font id="fontReword" style="text-align: center;"></font>
                            <div class="progress" style="margin-top: 8px;">
                                <div id="divProgress" class="progress-bar progress-bar-success" role="progressbar"
                                    aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                                </div>
                            </div>
                            <font style="text-align: center;color: gray;">已累计 <strong id="strHaved"></strong>&nbsp;&nbsp;&nbsp;总需金额 <strong id="strSum"></strong>&nbsp;&nbsp;&nbsp;剩余 <strong id="strRest"></strong></font>
                        </div>
                        <div id="divBottom" style="margin-top: 5px; margin-bottom: 5px;height: 30px;vertical-align: middle;">
                            <!-- <button id="btnBuy" type="button" class="btn btn-info btn-sm" hidden="hidden">立即抢购</button> -->
                            <!-- <font style="float: left; margin-left: 15px;">已购买&nbsp;<strong id="buyCount"></strong>&nbsp;次</font>
                            <a>查看夺宝号 </a>
                            <button id="btnBuy" type="button" class="btn btn-info btn-xs" style="float: right; margin-right: 15px;">继续购买</button> -->
                        </div>
                    </div>
                </div>
                <div id="divWait" class="col-xs-12 col-md-12" align="center" style="position: fixed;left: 50%;top: 50%;transform: translateX(-50%)translateY(-50%);-webkit-transform:translateX(-50%) translateY(-50%);">
                    <img id="waitGif" src="../img/walletWait.gif" hidden="hidden">
                </div>
            </div>
        </div>
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