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
<title>世界杯竞猜一级页面</title>
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
    var ifFindfoucs = false;
    var foucsId = '';
       
    function addBetStatus() {
        $.ajax({
            url:"getWorldCupMatchBetByItcode.jsp",
            data:{itcode:itcode},
            dataType:"text",
            success:function(data){
                var obj = eval (data);
                $(obj).each(function(){
                    var temp = $("#" + this).find(".jingcaizhuangtai").html();
                    temp += ",您已竞猜";
                    $("#" + this).find(".jingcaizhuangtai").html(temp);
                })
            }
        });
    }

    function testScroll(){
        if (ifFindfoucs) {
            var tab = $('#fullTable'), 
            scrollTo = $('#' + foucsId); //获取指定行的元素

            // tab.scrollTop( 
            //     scrollTo.offset().top - tab.offset().top + tab.scrollTop() 
            // );
            // tab.animate({scrollTop:scrollTo.offsetTop},"slow");
            window.location.href='#' + foucsId;
        }
    }

    $(function(){
        var msg = "<table id='fullTable' border='0' cellpadding='0' cellspacing='0' style='width:100%;margin:0 auto;background:#DDDDDD'><img id='im' src='img/worldcup_bg.png' style='position:fixed'><div id='blank' style='height:10px'></div>";
        $.ajax({
            url:"getWorldCupMsg.jsp",
            data:{},
            async:false,
            dataType:"json",
            success:function(data){
                $(data).each(function(){
                    msg += "<tr id='"+this.id+"' style='padding-top:10px'><td style='width: 30%;border-bottom: 1px solid grey;margin:10px 0 10px 0'><div style='margin:0 auto;width:100%;text-align:center'><div style='height:25px;'></div>";
                    msg += "<img class='mg' src='img/"+this.teamaflag+"' style='display: inline-block;'/>";
                    msg += "</div><div style='text-align: center;color: black;margin-bottom: 10px;'>"+this.teamA+"</div></td>";
                    msg += "<td style='color: grey;width: 40%;text-align: center;border-bottom: 1px solid grey;'>";
                    if(this.result == "10"){
                        msg += "<font class='jingcaizhuangtai' color='green'>未开赛</font></br>";
                        if(!ifFindfoucs){
                            ifFindfoucs = true;
                            foucsId = parseInt(this.id) - 1;
                        }
                    }else if(this.result == "11"){
                        msg += "<font class='jingcaizhuangtai' color='red'>停止投注</font></br>";
                        if(!ifFindfoucs){
                            ifFindfoucs = true;
                            foucsId = parseInt(this.id) - 1;
                        }
                    }else {
                        msg += "<font class='jingcaizhuangtai' color='red'>已结束</font></br>";
                    }
                    msg += "<font>"+this.matchtime+"</font></br>";
                    msg += "<font>"+this.matchlevel+"</font>";
                    msg += "</td><td style='width: 30%;border-bottom: 1px solid grey;margin:10px 0 10px 0'><div style='margin:0 auto;width:100%;text-align:center'><div style='height:25px;'></div>";
                    msg += "<img class='mg' src='img/"+this.teambflag+"' style='display: inline-block;'/>";
                    msg += "</div><div style='text-align: center;color: black;margin-bottom: 10px;'>"+this.teamB+"</div></td></tr>";
                });
                msg += "</table>";
            }
        });
        var width = document.documentElement.clientWidth*0.96*0.3*0.8;
        var height = width*0.667;

        $("body").html(msg);

        $(".mg").css("width",width+"px");
        $(".mg").css("height",height+"px");

        var w = document.documentElement.clientWidth;
        var h = w/5.2;
        $("#im").css("width",w+"px");
        $("#im").css("height",h+"px");

        $("#blank").css("height",h+"px");

        addBetStatus();
        if (ifFindfoucs) {
            window.location.href='#' + foucsId;
        }

        $("tr").click(function(){
            window.location.href="/mobile/plugin/dch/smb/showGameWorldCupBet.jsp?itcode="+itcode+"&matchid="+$(this).prop("id");
        });
        // 查看玩法简介
        $("#im").click(function(){
            alert(" 1、每人每场比赛可参与一次比赛结果竞猜； \n 2、每场比赛开始前1-2小时停止竞猜； \n 3、每场比赛的奖池金额按小时更新,每一位参与用户会使奖池金额增加，最终竞猜正确的用户将平分奖池奖励，竞猜错误的用户没有奖励； \n 4、比赛结果按正常比赛全场90分钟加伤停补时统计，加时赛、点球赛等附加赛结果不纳入统计中； \n 5、在神州区块链上竞猜时会扣除一定量的手续费（约5~6神州币），为保证可正常参与竞猜，请确保账户余额不少于6神州币； \n 6、神州币可以通过 福利-签到 获取，世界杯期间，签到奖励翻倍发放； \n 7、如有任何问题，请与mojja或fannl联系。 \n");
        });
    });
</script>

</head>
<body style="font-family:微软雅黑;width:100%;margin:0" >
	
</body>
</html>