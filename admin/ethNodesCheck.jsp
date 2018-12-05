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
        <title>排行榜</title>
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
        	$(function() {
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/admin/getEthNodesCheck.jsp",
                    dataType: "json",
                    success: function(data) {
                        var innerHtml = "";
                        $(data.data).each(function(index, value) {
                            var status = value.cfgStatus == 1 ? "正常" : "异常";
                            var color = value.cfgStatus == 1 ? "green" : "red";
                            innerHtml += "<tr style='height: 60px;'>"
                                +"<td style='text-align: center; vertical-align: middle;'>"+value.cfgValue+"</td>"
                                +"<td style='text-align: center; vertical-align: middle;color:" + color + ";'>"+status+"</td></tr>";
                        });
                        $("#tBody").append(innerHtml);
                    },
                });
            });
        </script>
    </head>
    <body style="font-family:微软雅黑;" >
    	 <div class="container" style="">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="margin-top: 5%;">
                     <table class="table table-condensed" style="table-layout: fixed;">
                        <!-- <caption id="tabCaption" style="text-align: center;font-size: 22px;font-weight: bold;"></caption> -->
                        <col style="width: 50%" />
                        <col style="width: 50%" />
                        <thead>
                            <tr>
                              <th style="text-align: center;color: gray;font-size: 80%;">节点</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">状态</th>
                            </tr>
                        </thead>
                        <tbody id="tBody" align="center">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>  
    </body>
</html>