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
    String topicId_ = Util.null2String((String) fu4.getParameter("topicId"));
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
        <title>投票选择你身边的技术大拿</title>
        <link rel="stylesheet" id="" href="../../css/trav.css"/>
        <link rel="stylesheet" id="" href="../../css/bootstrap.min.css" type="text/css" />
        <script src="../../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" id="" href="../../css/weui.min.css" />
        <link rel="stylesheet" id="" href="../../css/jquery-weui.min.css" />
        <link rel="stylesheet" id="" href="../../css/icon.css" />
        <link rel="stylesheet" id="" href="../../css/task.css" />
        <script type='text/javascript' src='../../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../../js/jquery.form.js'></script>
        <script type='text/javascript' src="../../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../../js/web3.min.js'></script>
        <script type='text/javascript' src='../../js/bignumber.js'></script>
        <script type="text/javascript">
        	var itcode = '<%=it_code1 %>';
            var topicId = '<%=topicId_ %>';
            $(function() {
                var jsonObj = {};

                window.voteDetaile = function(transactionHash) {
                    var value = jsonObj[transactionHash];
                    $("#voteItcode").text(value.voteItcode);
                    $("#voteAddress").text(value.voteAddress);
                    $("#beVotedAdress").text(value.beVotedAdress);
                    $("#numberOfVotes").text(value.numberOfVotes);
                    $("#tabCaption").text(value.transactionHash);

                    $("#transactionModal").modal('show');
                } 
               
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/vote/paidVote/getViewMine.jsp",
                    data: {"itcode" : itcode,
                            "topicId" : topicId},
                    dataType: "json",
                    success: function(data) {
                        console.log(JSON.stringify(data));
                        var count = 0;
                        if (data.success == "dataNull") {
                            $("#noVote").show();
                        } else {
                            $(data.success).each(function(index, value) {
                                jsonObj[value.transactionHash] = value;
                                var fromTo = value.voteItcode + "  ——>  " + value.beVotedItcode;

                                var innerHtml = "<table style='table-layout:fixed;border-bottom: groove;' class='table' onclick='voteDetaile(&apos;"+value.transactionHash+"&apos;)'>"
                                    + "<caption style='overflow:hidden;white-space:nowrap;text-overflow:ellipsis;text-align:center;color:#4C4C4C;font-weight:bold;' align='center'>"+fromTo+"</caption>"
                                    + "<tbody><tr><td style='text-align:center;'>票数</td><td style='color:green;font-weight: bold;text-align:center;'>"+value.numberOfVotes+"</td></tr></tbody></table>";

                                count += parseInt(value.numberOfVotes);
                                $("#tableGroup").prepend(innerHtml);
                                /*<tr><td>交易时间</td><td style='overflow:hidden;white-space:nowrap;text-overflow:ellipsis;'>"+value.confirmTime+"</td></tr>*/
                            });
                            $("#voteNumber").text(count);
                        }
                    }
                });
            });
        </script>
    </head>
    <style type="text/css">

    </style>
    <body style="font-family:微软雅黑;" >
        <div class="container" style="z-index: 1;">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="">
                    <div style="margin-top: 15px;height: 50px; border-bottom: 1px solid gray;">
                        <font id="vote" style="text-align: center;font-size: 22px;font-weight: bold;color: green;">我的得票<font id="voteNumber" style="margin-left: 20px;color: green;">0</font></font>
                    </div>
                    <div id="tableGroup" class="col-xs-12 col-md-12" align="center" style="margin-top: 10px;">
                    </div>
                    <div id="noVote" align="center" hidden="true" style="margin-top: 30px;">
                        <img src="../../img/noVoteCry.png" class="img-responsive center-block">
                        <font style="text-align: center;color: gray;">您还未收到投票</font>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" id="transactionModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div id="divKeystore" class="modal-body">
                        <table class="table table-condensed" style="table-layout: fixed;">
                            <caption id="tabCaption" style="word-break: break-all;"></caption>
                            <col style="width: 30%" />
                            <col style="width: 70%" /> 
                            <tbody>
                                <tr>
                                  <td style="text-align: center;"><mark>投票人</mark></td>
                                  <td id="voteItcode" style="word-break: break-all;text-align: center;"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>投票人账户</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="voteAddress"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>我的账户</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="beVotedAdress"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>票数</mark></td>
                                  <td id="numberOfVotes" style="word-break: break-all;text-align: center;"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>确认区块</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="confirmBlock">施工中......</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>