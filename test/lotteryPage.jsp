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
        <title>夺宝测试页面</title>
        <link rel="stylesheet" href="../css/trav.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css" />
        <script src="../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../css/weui.min.css" />
        <link rel="stylesheet" href="../css/jquery-weui.min.css" />
        <link rel="stylesheet" href="../css/icon.css" />
        <link rel="stylesheet" href="../css/task.css" />
        <link rel="stylesheet" href="../css/bootstrapValidator.min.css" />
        <link rel="stylesheet" href="../css/aui_css/aui.css" />
        <link rel="stylesheet" type="text/css" href="../css/aui_css/aui-pull-refresh.css" />
        <script type='text/javascript' src='../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../js/jquery.form.js'></script>
        <script type='text/javascript' src="../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../js/web3.min.js'></script>
        <script type='text/javascript' src='../js/bignumber.js'></script>
        <script type='text/javascript' src='../js/bootstrapValidator.min.js'></script>
        <script type="text/javascript" src="../js/aui_script/api.js" ></script>
        <script type="text/javascript" src="../js/aui_script/aui-tab.js" ></script>
        <script type="text/javascript" src="../js/aui_script/aui-pull-refresh.js"></script>
        <script type="text/javascript">
            var itcode = '<%=it_code1 %>';
            var hbData;
            var smbData;
            var otherData;
            var newOpen;

            $(function() {
                $("#shouye").show();
                apiready = function(){
                    api.parseTapmode();
                }

                var tab = new auiTab({
                    element:document.getElementById("footer")
                },function(ret){
                    if(ret.index == 1) {
                        $("#wode").hide();
                        $("#zuixinjiexiao").hide();
                        $("#shouye").show();
                    }
                    if(ret.index == 2) {
                        $("#wode").hide();
                        $("#shouye").hide();
                        $("#zuixinjiexiao").show();
                    }
                    if(ret.index == 3) {
                        $("#shouye").hide();
                        $("#zuixinjiexiao").hide();
                        $("#wode").show();
                    }
                });

                //下拉刷新
                var pullRefresh = new auiPullToRefresh({
                    container: document.querySelector('.aui-refresh-content'),
                    triggerDistance: 100
                },function(ret){
                    if(ret.status=="success"){
                        setTimeout(function(){
                            location.reload();
                            pullRefresh.cancelLoading(); //刷新成功后调用此方法隐藏
                        },1000)
                    }
                })

                //  var toast = new auiToast({});
                //  toast.loading({
                //     title:"加载中",
                //     duration:2000
                // },function(ret){
                //     console.log(ret);
                //     setTimeout(function(){
                //         toast.hide();
                //     }, 3000)
                // });

                

                window.clickToDetail = function(id) {
                    window.location.href="/mobile/plugin/dch/smb/test/lotteryBuyPage.jsp?itcode="+itcode+"&id="+id;
                }

                //发送请求，获取夺宝信息，查看该用户是否参与此次夺宝，若参与，展示夺宝号码
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/test/getLotteryData.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode
                    })},
                    dataType: "json",
                    success: function(data) {
                        if (data.success) {
                            hbData = data.hbData;
                            smbData = data.smbData;
                            otherData = data.otherData;
                            newOpen = data.newOpen;
                            var innerHtml = "";
                            var innerHtml2 = "";
                            for(var index = 0; index < hbData.length; index++) {
                                innerHtml += "<div class='aui-card-list' onClick='clickToDetail("+hbData[index].id+")'><div class='aui-card-list-header' style='font-size:140%;'>【第"+hbData[index].id+"期】"+hbData[index].description+"</div><div class='aui-card-list-content' align='center'><img src='../img/lottery_rmb_1.jpg' class='img-responsive center-block' style='height: 130px;width: 93%;'><div class='aui-content-padded'><div class='aui-progress aui-progress-xs'><div class='aui-progress-bar' style='width: "+hbData[index].nowSumAmount/hbData[index].winSumAmount*100+"%;'></div></div></div><font style='text-align: center;color: gray;'><strong id='strOnce'>"+hbData[index].unitPrice+"</strong>&nbsp;SZB/夺宝码&nbsp;&nbsp;每人限购 <strong id='strLimit'>"+hbData[index].limitEveryday+"</strong>&nbsp;次&nbsp;&nbsp;已累计 <strong id='strHaved'>"+hbData[index].nowSumAmount+"</strong>&nbsp;SZB</font></div><div class='aui-card-list-footer' align='center'><p><div>点击进入</div></p></div></div>";
                            }
                            innerHtml += "<div class='aui-card-list' onClick='clickToDetail("+smbData.id+")'><div class='aui-card-list-header' style='font-size:140%;'>【第"+smbData.id+"期】"+smbData.description+"</div><div class='aui-card-list-content' align='center'><img src='../img/lottery_szb_1.jpg' class='img-responsive center-block' style='height: 130px;width: 93%;'><div class='aui-content-padded'><div class='aui-progress aui-progress-xs'><div class='aui-progress-bar' style='width: "+smbData.nowSumAmount/smbData.winSumAmount*100+"%;'></div></div></div><font style='text-align: center;color: gray;'><strong id='strOnce'>"+smbData.unitPrice+"</strong>&nbsp;SZB/夺宝码&nbsp;&nbsp;每人限购 <strong id='strLimit'>"+smbData.limitEveryday+"</strong>&nbsp;次&nbsp;&nbsp;已累计 <strong id='strHaved'>"+smbData.nowSumAmount+"</strong>&nbsp;SZB</font></div><div class='aui-card-list-footer' align='center'><p><div>点击进入</div></p></div></div>"
                            for(var index = 0; index < otherData.length; index++) {
                                innerHtml += "<div class='aui-card-list' onClick='clickToDetail("+otherData[index].id+")'><div class='aui-card-list-header' style='font-size:140%;'>【第"+otherData[index].id+"期】"+otherData[index].description+"</div><div class='aui-card-list-content' align='center'><img src='../img/"+otherData[index].backup2+"' class='img-responsive center-block' style='height: 130px;width: 93%;'><div class='aui-content-padded'><div class='aui-progress aui-progress-xs'><div class='aui-progress-bar' style='width: "+otherData[index].nowSumAmount/otherData[index]. winSumAmount*100+"%;'></div></div></div><font style='text-align: center;color: gray;'><strong id='strOnce'>"+otherData[index].unitPrice+"</strong>&nbsp;SZB/夺宝码&nbsp;&nbsp;每人限购 <strong id='strLimit'>"+otherData[index].limitEveryday+"</strong>&nbsp;次&nbsp;&nbsp;已累计 <strong id='strHaved'>"+otherData[index].nowSumAmount+"</strong>&nbsp;SZB</font></div><div class='aui-card-list-footer' align='center'><p><div>点击进入</div></p></div></div>";
                            }
                            $("#divLotteryList").prepend(innerHtml);

                            
                            for(var index = 0; index < newOpen.length; index++) {
                                var reg = new RegExp("&","g");
                                var winnerStr = newOpen[index].winner.replace(reg,",");
                                var ticketStr = newOpen[index].winTicket.replace(reg,",");

                                var bkImgStr = newOpen[index].backup2;
                                if (newOpen[index].typeCode == 0) {
                                    bkImgStr = "lottery_rmb_1.jpg";
                                } else if (newOpen[index].typeCode == 1) {
                                    bkImgStr = "lottery_szb_1.jpg";
                                }

                                innerHtml2 += "<div class='aui-card-list' style='background-color:#F7F0EA;'><div class='aui-card-list-header' style='font-size:140%;'>【第"+newOpen[index].id+"期】 "+newOpen[index].name+"</div><div class='aui-card-list-content'><img src='../img/"+bkImgStr+"' class='img-responsive center-block' style='height: 130px;width: 93%;'></div><div class='aui-card-list-footer'>获奖者："+winnerStr+"<br>幸运号码："+ticketStr+"<br>开奖时间："+newOpen[index].backup1;

                                if (winnerStr.indexOf(itcode) > -1) {
                                    innerHtml2 += "<br>中奖提示：您已中奖！</div></div>";
                                } else {
                                    innerHtml2 += "<br>中奖提示：您未中奖！</div></div>";
                                }
                            }
                            $("#divNewOpenList").prepend(innerHtml2);
                        }
                    }
                });

                $("#introduce").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/test/lotteryIntroduce.jsp";
                });
                $("#myRecores").click(function() {
                    // window.location.href="/mobile/plugin/dch/smb/test/lotteryIntroduce.jsp";
                    alert("敬请期待！");
                });
                $("#myAchieve").click(function() {
                    // window.location.href="/mobile/plugin/dch/smb/test/lotteryIntroduce.jsp";
                    alert("敬请期待！");
                });
                $("#contactUs").click(function() {
                    // window.location.href="/mobile/plugin/dch/smb/test/lotteryIntroduce.jsp";
                    alert("如有任何疑问，请与fannl@digitalchina.com联系！");
                });
            });
        </script>
    </head>
    <body>
        <div id="shouye" hidden="hidden">
            <section class="aui-refresh-content">
                <div class="aui-content">
                    <div id="divLotteryList">
                        <div style="height: 50px;"> 
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div id="zuixinjiexiao" hidden="hidden">
            <section class="aui-refresh-content">
                <div class="aui-content">
                    <div id="divNewOpenList">
                        <div style="height: 50px;">
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div id="wode" hidden="hidden">
            <section class="aui-content">
                <ul class="aui-list aui-list-in aui-margin-b-15">
                    <li id="introduce" class="aui-list-item">
                        <div class="aui-list-item-label-icon">
                            <i><img src="../img/wanfajianjie.png"  class="img-responsive center-block" style="width: 25px; height: 25px;"></i>
                        </div>
                        <div class="aui-list-item-inner aui-list-item-arrow">
                            <div class="aui-list-item-title">玩法简介</div>
                        </div>
                    </li>
                    <li id="myRecores" class="aui-list-item">
                        <div class="aui-list-item-label-icon">
                            <i><img src="../img/duobaojilu.png"  class="img-responsive center-block" style="width: 25px; height: 25px;"></i>
                        </div>
                        <div class="aui-list-item-inner aui-list-item-arrow">
                            <div class="aui-list-item-title">夺宝记录</div>
                        </div>
                    </li>
                    <li id="myAchieve" class="aui-list-item">
                        <div class="aui-list-item-label-icon">
                            <i><img src="../img/wodechengjiu.png"  class="img-responsive center-block" style="width: 25px; height: 25px;"></i>
                        </div>
                        <div class="aui-list-item-inner aui-list-item-arrow">
                            <div class="aui-list-item-title">我的成就</div>
                        </div>
                    </li>
                    <li id="contactUs" class="aui-list-item">
                        <div class="aui-list-item-label-icon">
                            <i><img src="../img/lianxiwomen.png"  class="img-responsive center-block" style="width: 25px; height: 25px;"></i>
                        </div>
                        <div class="aui-list-item-inner aui-list-item-arrow">
                            <div class="aui-list-item-title">联系我们</div>
                        </div>
                    </li>
                </ul>
            </section>
        </div>
        <footer class="aui-bar aui-bar-tab" id="footer">
            <div class="aui-bar-tab-item aui-active" tapmode>
                <i><img src="../img/shouye.png"  class="img-responsive center-block" style="width: 25px; height: 25px;"></i>
                <div class="aui-bar-tab-label">进行中</div>
            </div>
            <div class="aui-bar-tab-item" tapmode>
                <i><img src="../img/zuixinjiexiao.png"  class="img-responsive center-block" style="width: 25px; height: 25px;"></i>
                <div class="aui-bar-tab-label">最新揭晓</div>
            </div>
            <div class="aui-bar-tab-item" tapmode>
                <i><img src="../img/wode.png"  class="img-responsive center-block" style="width: 25px; height: 25px;"></i>
                <div class="aui-bar-tab-label">我的</div>
            </div>
        </footer>
    </body>
</html>