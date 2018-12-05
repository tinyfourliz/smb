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
        <title>测试提现页面</title>
        <link rel="stylesheet" href="../css/trav.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css" />
        <script src="../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../css/weui.min.css" />
        <link rel="stylesheet" href="../css/jquery-weui.min.css" />
        <link rel="stylesheet" href="../css/icon.css" />
        <link rel="stylesheet" href="../css/task.css" />
        <link rel="stylesheet" href="../css/bootstrap-select.min.css" />
        <script type='text/javascript' src='../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../js/jquery.form.js'></script>
        <script type='text/javascript' src="../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../js/web3.min.js'></script>
        <script type='text/javascript' src='../js/bignumber.js'></script>
        <script type='text/javascript' src='../js/bootstrap-select.min.js'></script>

        <script type="text/javascript">
            var itcode = '<%=it_code1 %>';
            var dataJson = {};

            $(function() {
                function regTest(money) {
                    var reg = /^\d+(?=\.{0,1}\d+$|$)/
                    if(!reg.test(money)) {
                        alert("请输入合法的金额值");
                        return false;
                    }
                    return true;
                } 

                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/test/getWithdrawAccount.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode
                    })},
                    dataType: "json",
                    success: function(data) {
                        if (data.success) {
                            if(data.accountList.length <= 1) {
                                alert("请先创建账户！");
                                $("#btnConfirm").attr("disabled", "true");
                                return;
                            }
                            $(data.accountList).each(function(index, value) {
                                dataJson[value.alias] = {
                                    "account" : value.account,
                                    "balance" : value.balance
                                }
                                if (value.available === 3) {
                                     $("#laBalance").val(value.balance);
                                     $("#laDefault").val(value.account);
                                } else if (value.available != 0) {
                                    var innerHtml = "<option value='" + value.account + "'>" + value.alias + "</option>";
                                    $("#selectGroup").append(innerHtml);
                                }
                            });
                                $('.selectpicker').selectpicker('refresh');
                                $("#laAccount").val($("#selectGroup").children('option:selected').attr("value"));
                        } else {
                            alert("异常，请稍后再试");
                        }
                    }
                });

                $("#selectGroup").change(function() {
                    var selectedAlias = $("#selectGroup").children('option:selected').text();
                    var account = $(this).children('option:selected').attr("value");
                    var balance = dataJson[selectedAlias].balance;
                    $("#laAccount").val(account);
                });

                $("#txtMoney").focus(function() {
                    var defaultAccJson = dataJson.默认账户;
                    var balance =  defaultAccJson.balance;
                    var canWithdrawMoney = Number(balance) - Number(10);
                    $("#moneyAlert").text("提现过程会产生手续费，可提现金额为" + canWithdrawMoney);
                });

                $("#btnConfirm").click(function() {
                    var money = $("#txtMoney").val();
                    if(!regTest(money)){
                        return;
                    }
                    var account = $("#laAccount").val();
                    var defaultAccJson = dataJson.默认账户;
                    if (Number(defaultAccJson.balance) - Number(10) < money) {
                        alert("请输入正确的金额");
                        return;
                    }

                    $("#waitGif").show();
                    $("#btnConfirm").attr("disabled", "true");
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/test/getWithdrawConfirm.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "account" : account,
                            "money" : money,
                            "alias" : $("#selectGroup").children('option:selected').text(),
                            "defaultAcc" : defaultAccJson.account
                        })},
                        dataType: "json",
                        success: function(data) {
                            $("#waitGif").hide();
                            if(!data.success) {
                                if (data.errMsg = "invalidPassword") {
                                    alert("密码不能解锁账户，请确认");
                                    $("#btnConfirm").attr("disabled", "false");
                                }
                                return;
                            }
                            alert("提现成功，请稍后在我的账户查看");
                            window.location.href = "/mobile/plugin/dch/smb/test/accManager.jsp?itcode="+itcode;
                        }
                    });
                });
            });
        </script>
    </head>
    <body style="font-family:微软雅黑;" >
    	 <div class="container" style="">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center"><br>
                     <div>
                        <h4 style="float: left;">钱包账户</h4>
                        <!-- <label id="laDefault"></label> -->
                        <input id="laDefault" class="form-control required" readonly="readonly" />
                    </div><br>
                    <div>
                        <h4 style="float: left;">余额</h4>
                        <!-- <p id="laBalance"></p> -->
                        <input id="laBalance" class="form-control required" readonly="readonly" />
                    </div><br>
                    <div>
                        <h4 style="float: left; display: inline-block;">提出账户</h4>
                        <select id="selectGroup" class="selectpicker">
                            <!-- <option value='1'>账户1</option> -->
                        </select>
                    </div><br>
                    <div>
                        <h4 style="float: left;">账户地址</h4>
                        <!-- <label id="laAccount"></label> -->
                        <input id="laAccount" class="form-control required" readonly="readonly" />
                    </div><br>
                    <div>
                        <h4 style="float: left;">提现金额</h4>
                         <input id="txtMoney" class="form-control required"/>
                         <h5 id="moneyAlert" style="color: red;"></h5>
                    </div><br>
                    <button id="btnConfirm" type="button" class="btn btn-info btn-lg btn-block">
                        确认提现
                    </button>
                </div>
                 <div class="col-xs-12 col-md-12" align="center" style="position: absolute;margin-top: 60%;z-index: 100;">
                    <img id="waitGif" src="../img/walletWait.gif" hidden="hidden">
                </div>
            </div>
        </div>  
    </body>
</html>