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
        <title>测试钱包页面</title>
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
                $("#btnNew").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/test/mnemonic.jsp?itcode="+itcode;
                });

                $("#btnCharge").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/test/chargeToDefault.jsp?itcode="+itcode;
                });

                $("#btnWithdraw").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/test/withdrawToAccount.jsp?itcode="+itcode;
                });

                $("#btnManage").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/test/accManager.jsp?itcode="+itcode;
                });
                
                $("#btnRecords").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/test/transRecords.jsp?itcode="+itcode;
                });
            });
        </script>
    </head>
    <body style="font-family:微软雅黑;" >
    	 <div class="container" style="">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="margin-top: 45%;">
                    <p>
                      <button id="btnNew" type="button" class="btn btn-info btn-lg btn-block">
                      创建账户</button>
                      <button id="btnManage" type="button" class="btn btn-info btn-lg btn-block">
                      我的账户</button>
                      <button id="btnCharge" type="button" class="btn btn-info btn-lg btn-block">
                      充值</button>
                      <button id="btnWithdraw" type="button" class="btn btn-info btn-lg btn-block">
                      提现</button>
                      <button id="btnRecords" type="button" class="btn btn-info btn-lg btn-block">
                      交易记录</button>
                    </p>
                </div>
            </div>
        </div>  
    </body>
    <footer>
        <div align="center" style="position: absolute; bottom: 20px; height: 5%; width: 100%;">
            <a href="/mobile/plugin/dch/smb/test/walletIntroduce.jsp">使用指南</a>
        </div>
    </footer>
</html>