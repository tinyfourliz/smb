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
        <title>交易记录页面</title>
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
            $(function() {
                var itcode = '<%=it_code1 %>';
                var jsonObj = {};
                window.transDetaile = function(transactionHash) {
                    var value = jsonObj[transactionHash];
                    $("#accountFrom").text(value.accountFrom);
                    $("#accountTo").text(value.accountTo);
                    $("#balanceFrom").text(value.balanceFrom/10000000000000000);
                    $("#balanceTo").text(value.balanceTo/10000000000000000);
                    $("#balance").text(value.balance/10000000000000000);
                    $("#aliasFrom").text(value.aliasFrom);
                    $("#aliasTo").text(value.aliasTo);
                    $("#confirmTime").text(value.confirmTime);
                    $("#confirmBlock").text(value.confirmBlock);
                    $("#tabCaption").text(value.transactionHash);

                    $("#transactionModal").modal('show');
                } 

                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/wallet/getTransRecords.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode
                    })},
                    dataType: "json",
                    success: function(data) {
                        if (data.success) {
                            if(data.records == "") {
                                $("#tableGroup").html("<p style='color:gray;margin-top：10%;'>当前暂无数据</p>");
                                return;
                            }
                            $(data.records).each(function(index, value) {
                                jsonObj[value.transactionHash] = value;
                                var confirm = value.status == 1 ? '已确认' : '待确认';
                                var pom = value.aliasFrom == '默认账户' ? "-" : "+";
                                var color = pom == "+" ? "#55C60A" : "#FE315D";
                                var fromTo = value.aliasFrom + "  ——>  " + value.aliasTo;
                                var innerHtml = "<table style='table-layout:fixed;border-bottom: groove;' class='table' onclick='transDetaile(&apos;"+value.transactionHash+"&apos;)'>"
                                    + "<caption style='overflow:hidden;white-space:nowrap;text-overflow:ellipsis;text-align:center;color:#4C4C4C;font-weight:bold;' align='center'>"+fromTo+"</caption>"
                                    + "<tbody><tr><td>交易时间</td><td style='overflow:hidden;white-space:nowrap;text-overflow:ellipsis;'>"+value.confirmTime+"</td></tr><tr><td>"+confirm+"</td><td style='color:"+color+";'>"
                                    + pom+""+value.balance/10000000000000000+"</td></tr></tbody></table>";

                                $("#tableGroup").prepend(innerHtml);
                            });
                        } else {
                            alert("异常，请稍后再试");
                            window.location.href = "/mobile/plugin/dch/smb/wallet/amBase.jsp?itcode="+itcode;
                        }
                    }
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div id="tableGroup" class="col-xs-12 col-md-12" align="center" style="margin-top: 35px;">
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
                                  <td style="text-align: center;"><mark>转出账户</mark></td>
                                  <td id="accountFrom" style="word-break: break-all;"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>名称</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="aliasFrom"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>余额</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="balanceFrom"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>转入账户</mark></td>
                                  <td id="accountTo" style="word-break: break-all;"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>名称</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="aliasTo"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>余额</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="balanceTo"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>交易金额</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="balance"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>交易时间</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="confirmTime"></td>
                                </tr>
                                <tr>
                                  <td style="text-align: center;"><mark>确认区块</mark></td>
                                  <td style="text-align: center;word-break: break-all;" id="confirmBlock"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div> -->
                </div>
            </div>
        </div>
    </body>
</html>