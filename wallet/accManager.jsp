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
        <title>测试标签页面</title>
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

                window.getKeystore = function(account) {
                    $.ajax({
                        type: "GET", 
                        url: "/mobile/plugin/dch/smb/wallet/getKeystore.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "account" : account
                        })},
                        dataType: "json",
                        success: function(data) {
                            if (data.success) {
                                var keystore = data.keystore;
                                $("#divKeystore").text(keystore);
                                $("#keystoreModal").modal('show');
                            } else {
                                alert("异常，请稍后再试");
                                window.location.href = "/mobile/plugin/dch/smb/wallet/amBase.jsp?itcode="+itcode;
                            }
                        }
                    });
                }

                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/wallet/getAccManager.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode
                    })},
                    dataType: "json",
                    success: function(data) {
                        if (data.success) {
                            var innerHtml1 = "";
                            var innerHtml2 = "";
                            $(data.accountList).each(function(index, value) {
                                if (value.available === 3) {
                                     innerHtml1 = "<div class='panel panel-info' onclick='getKeystore(&apos;" + value.account + "&apos;)'>"
                                        + "<div class='panel-heading'>"
                                        + "<h3 class='panel-title'>" + value.alias + "</h3></div>"
                                        + "<div class='panel-body'><h5 style='word-break: break-all;'>" + value.account + "</h5>"
                                        + "<h4>余额 <strong>" + value.balance + "</strong> SMB</h4></div></div>";
                                } else if (value.available === 1) {
                                    innerHtml2 += "<div class='panel panel-info'  onclick='getKeystore(&apos;" + value.account + "&apos;)'>"
                                        + "<div class='panel-heading'>"
                                        + "<h3 class='panel-title'>" + value.alias + "</h3></div>"
                                        + "<div class='panel-body'><h5 style='word-break: break-all;'>" + value.account + "</h5>"
                                        + "<h4>余额 <strong>" + value.balance + "</strong> SMB</h4></div></div>";
                                }
                            });
                            $("#panelGroup").append(innerHtml1 + innerHtml2);
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
                <div id="panelGroup" class="col-xs-12 col-md-12" align="center" style="margin-top: 35px;">
                </div>
            </div>
        </div>
        <div class="modal" id="keystoreModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;
                        </button>
                        <h5 class="modal-title" id="myModalLabel">keystore</h5>
                    </div>
                    <div id="divKeystore" class="modal-body" style='word-break: break-all;'></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>