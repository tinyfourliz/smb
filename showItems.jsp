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
        <title>神州币消费</title>
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
        	$(function(){
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/vm/getusedvm.jsp",
                    dataType: "text",
                    success: function(data) {
                        var res=$.trim(data).split("_");
                        $("#usedCount").text(res[0]);
                        $("#unuseCount").text(40-parseInt(res[0]) < 0 ? 0 : 40-parseInt(res[0]));
                    }
                });

                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/lesson/getLessonOrderCount.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "lesson01" : "从0开始学架构",
                        "lesson02" : "深入浅出区块链",
                        "lesson03" : "数据结构与算法之美",
                        "lesson04" : "趣谈网络协议",
                        "lesson05" : "左耳听风",
                        "lesson06" : "赵成的运维体系管理课",
                        "lesson07" : "邱岳的产品手记",
                        "lesson08" : "朱赟的技术管理课",
                        "lesson09" : "如何做好一场演讲",
                        "lesson10" : "技术管理实战36讲",
                        "lesson11" : "从0开始学大数据"
                    })},
                    dataType: "json",
                    success: function(data) {
                        if (data.success) {
                            $("#peopleCount01").text(data.lesson01);
                            $("#peopleCount02").text(data.lesson02);
                            $("#peopleCount03").text(data.lesson03);
                            $("#peopleCount04").text(data.lesson04);
                            $("#peopleCount05").text(data.lesson05);
                            $("#peopleCount06").text(data.lesson06);
                            $("#peopleCount07").text(data.lesson07);
                            $("#peopleCount08").text(data.lesson08);
                            $("#peopleCount09").text(data.lesson09);
                            $("#peopleCount10").text(data.lesson10);
                            $("#peopleCount11").text(data.lesson11);
                        }
                    }
                });
                
        		$("#enterGameCasino").click(function(){
        			window.location.href="/mobile/plugin/dch/smb/showGameCasinoTest.jsp?itcode="+itcode;
        		});
                $("#enterVmApply").click(function(){
                    // alert("即将开放，敬请期待！");
                    window.location.href="/mobile/plugin/dch/smb/vm/newvm.jsp";
                });
                $("#enterGameWorldCup").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/showGameWorldCup.jsp?itcode="+itcode;
                });
                $("#enterGameToupiao").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/showGameToupiao.jsp";
                });
                $("#lesson01").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson01.jsp?itcode="+itcode;
                });
                $("#lesson02").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson02.jsp?itcode="+itcode;
                });
                $("#lesson03").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson03.jsp?itcode="+itcode;
                });
                $("#lesson04").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson04.jsp?itcode="+itcode;
                });
                $("#lesson05").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson05.jsp?itcode="+itcode;
                });
                $("#lesson06").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson06.jsp?itcode="+itcode;
                });
                $("#lesson07").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson07.jsp?itcode="+itcode;
                });
                $("#lesson08").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson08.jsp?itcode="+itcode;
                });
                $("#lesson09").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson09.jsp?itcode="+itcode;
                });
                $("#lesson10").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson10.jsp?itcode="+itcode;
                });
                $("#lesson11").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/lesson/lesson11.jsp?itcode="+itcode;
                });
                $("#lotteryTest").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/test/showSigninTest.jsp?itcode="+itcode;
                });

                $("#technicalExperts").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/technicalExperts.jsp?itcode="+itcode;
                });

                $("#kaopu").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/kaopu.jsp?itcode="+itcode;
                });

                $("#koucai").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/koucai.jsp?itcode="+itcode;
                });

                $("#jiupin").click(function(){
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/jiupin.jsp?itcode="+itcode;
                });
        	})
        </script>
    </head>
    <body style="font-family:微软雅黑 " >
    	<div style="width:100%; "  hidden="hidden">
    		<div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
    			<div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
    				<b style="font-size:20px">2018俄罗斯世界杯</b><br/>
    				<font color="gray">四年一度的足球盛宴！</font>
    			</div>
    			<div id="enterGameWorldCup" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入专题
    			</div>
    		</div>
    	</div>
        <!-- 猜数字游戏 -->
        <div style="width:100%;" hidden="hidden">
            <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
                <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                    <b style="font-size:20px">猜数字</b><br/>
                    <font color="gray">想要神州币吗？那就来玩吧！</font>
                </div>
                <div id="enterGameCasino" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入游戏
                </div>
            </div>
        </div>
        <!-- 大学投票游戏 -->
        <div style="width:100%;" hidden="hidden">
            <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
                <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                    <b style="font-size:20px">大学投票</b><br/>
                    <font color="gray">来给你心目中优秀的大学投票吧！</font>
                </div>
                <div id="enterGameToupiao" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入投票
                </div>
            </div>
        </div>
        <!-- 虚拟机申请业务 -->
        <div style="width:100%;">
            <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
                <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                    <b style="font-size:20px">虚拟机申请</b><br/>
                    <font color="gray">IT虚拟机申请-</font><font color="red">限时五折</font><br>
                    <font color="gray">已申请 <strong id="usedCount"></strong> 台 剩余 <strong id="unuseCount"></strong> 台</font>
                </div>
                <div id="enterVmApply" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入申请
                </div>
            </div>
        </div>

        <!-- 精品课程11 -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">从0开始学大数据 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/newLesson.png" style="width: 50px;height: 35px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount11"></strong> 人参与学习</font>
            </div>
            <div id="lesson11" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程01 -->
        <div style="width:100%;height: 95px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">从0开始学架构 </b><br/>
                <font color="red">免费&nbsp;&nbsp;<img src="./img/yiwanjie.png" style="width: 30px;height: 30px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount01"></strong> 人参与学习</font>
            </div>
            <div id="lesson01" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程02 -->
        <div style="width:100%;height: 95px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">深入浅出区块链 </b><br/>
                <font color="red">免费&nbsp;&nbsp;<img src="./img/yiwanjie.png" style="width: 30px;height: 30px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount02"></strong> 人参与学习</font>
            </div>
            <div id="lesson02" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程03 -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">数据结构与算法之美 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/lianzai.png" style="width: 50px;height: 20px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount03"></strong> 人参与学习</font>
            </div>
            <div id="lesson03" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程04 -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">趣谈网络协议 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/yiwanjie.png" style="width: 30px;height: 30px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount04"></strong> 人参与学习</font>
            </div>
            <div id="lesson04" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程05 -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">左耳听风 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/lianzai.png" style="width: 50px;height: 20px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount05"></strong> 人参与学习</font>
            </div>
            <div id="lesson05" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程06 -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">赵成的运维体系管理课 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/lianzai.png" style="width: 50px;height: 20px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount06"></strong> 人参与学习</font>
            </div>
            <div id="lesson06" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程07 -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">邱岳的产品手记 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/lianzai.png" style="width: 50px;height: 20px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount07"></strong> 人参与学习</font>
            </div>
            <div id="lesson07" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程08 -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">朱赟的技术管理课 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/yiwanjie.png" style="width: 30px;height: 30px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount08"></strong> 人参与学习</font>
            </div>
            <div id="lesson08" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程09 --><!-- newLesson NEW -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">如何做好一场演讲 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/yiwanjie.png" style="width: 30px;height: 30px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount09"></strong> 人参与学习</font>
            </div>
            <div id="lesson09" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

        <!-- 精品课程10 -->
        <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">技术管理实战36讲 </b><br/>
                <font color="red">付费&nbsp;&nbsp;<img src="./img/lianzai.png" style="width: 50px;height: 20px;margin-top: -3px;"></font><br>
                <font color="gray">已有 <strong id="peopleCount10"></strong> 人参与学习</font>
            </div>
            <div id="lesson10" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入课程
            </div>
        </div>

     <!--    <div style="width:100%;height: 90px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:18px">神州币夺宝 </b><br/>
            </div>
            <div id="lotteryTest" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:15px">进入
            </div>
        </div> -->

        <!-- 酒品 -->
        <!-- <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:20px">谁的酒品最好？</b><br/>
                <font color="gray">你认为DCOne酒品最好的人</font>
            </div>
            <div id="jiupin" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入选择
            </div>
        </div> -->

        <!-- 口才 -->
        <!-- <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:20px">谁的口才最好？</b><br/>
                <font color="gray">你认为DCOne口才最好的人</font>
            </div>
            <div id="koucai" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入选择
            </div>
        </div> -->

        <!-- 技术大拿 -->
        <!-- <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:20px">身边的技术大拿</b><br/>
                <font color="gray">最让你感到安心的队友</font>
            </div>
            <div id="technicalExperts" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入选择
            </div>
        </div> -->

        <!-- 靠谱青年 -->
        <!-- <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:70%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:20px">身边最靠谱青年</b><br/>
                <font color="gray">谁会让你觉得最靠谱？</font>
            </div>
            <div id="kaopu" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:#2C84f8;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">进入选择
            </div>
        </div> -->

        <!-- 精品课程 -->
        <!-- <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:55%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:20px">午餐见面会(北京)</b><br/>
                <font color="gray">与区块链架构师交流</font>
            </div>
            <div>
                <img src="./img/jingjing.png" style="margin-left:1px;width:40px;height:40px;    margin-top: 7px;float:left">
            </div>
            <div id="jikeTest" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:gray;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">午餐拍卖
            </div>
        </div>
        精品课程
        <div style="width:100%;height: 72px;border-bottom:1px solid grey;margin:0 auto;padding: 10px;background: #C0C0BB;">
            <div style="width:55%;margin:0;padding-left:10px;height:100%;float:left">
                <b style="font-size:20px">午餐见面会(西安)</b><br/>
                <font color="gray">与区块链架构师交流</font>
            </div>
            <div>
                <img src="./img/fanfan.png" style="margin-left:1px;width:40px;height:40px;    margin-top: 7px;float:left">
            </div>
            <div id="jikeTest" style="float:right;height:40px;line-height:40px;font-size:18px;border:1px solid white;background:gray;width:100px;text-align:center;border-radius:10px;color:white;margin-top:7px">午餐拍卖
            </div>
        </div> -->
    </body>
</html>