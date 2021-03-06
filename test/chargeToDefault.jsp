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
        <title>测试充值页面</title>
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

                function regAddress(account) {
                    var reg = /^.{42}$/
                    if(!reg.test(account)) {
                        alert("请输入合法的地址");
                        return false;
                    }
                    return true;
                }

                function regKeystore(keystore) {
                    var reg = /^.{485,495}$/
                    if(!reg.test(keystore)) {
                        alert("请输入合法的私钥");
                        return false;
                    }
                    return true;
                } 

                $("#liLocal").attr("class","active");
                $("#aLocal").css("color","black");

                $("#liLocal").click(function() {
                    $("#liInput").removeClass("active");
                    $("#aInput").css("color","white");
                    $("#liLocal").attr("class","active");
                    $("#aLocal").css("color","black");

                    $("#divContentInput").hide();
                    $("#divContentLocal").show();

                });

                $("#liInput").click(function() {
                    $("#liLocal").removeClass("active");
                    $("#aLocal").css("color","white");
                    $("#liInput").attr("class","active");
                    $("#aInput").css("color","black");

                    $("#divContentLocal").hide();
                    $("#divContentInput").show();
                });

                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/test/getChargeDefault.jsp",
                    data: {"jsonStr" : JSON.stringify({
                        "itcode" : itcode
                    })},
                    dataType: "json",
                    success: function(data) {
                        if (data.success) {
                            if(data.accountList.length <= 1) {
                                alert("请先创建账户！");
                                $("#btnConfirm").attr("disabled", "true");
                            }
                            $(data.accountList).each(function(index, value) {
                                dataJson[value.alias] = {
                                    "account" : value.account,
                                    "balance" : value.balance,
                                    "available" : value.available,
                                    "alias" : value.alias
                                }
                                if (value.available != 0 && value.available != 3) {
                                    var innerHtml = "<option value='" + value.account + "'>" + value.alias + "</option>";
                                    $("#selectGroup").append(innerHtml);
                                }
                            });
                                $('.selectpicker').selectpicker('refresh');
                                $("#laAccount").val($("#selectGroup").children('option:selected').attr("value"));
                                $("#laBalance").val(dataJson[$("#selectGroup").children('option:selected').text()].balance  + " SZB");
                        } else {
                            alert("异常，请稍后再试");
                        }
                    }
                });

                $("#btnQuery").click(function() {
                    var account = $("#inAccount").val();
                    if(!regAddress(account)) {
                        return;
                    }
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/test/getBalanceQuery.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "account" : account
                        })},
                        dataType: "json",
                        success: function(data) {
                            if(data.success) {
                                $("#fontBalance").text(data.balance/10000000000000000);
                            } else {
                                alert("异常，请稍后再试");
                            }
                        }
                    })
                });

                $("#selectGroup").change(function() {
                    var selectedAlias = $("#selectGroup").children('option:selected').text();
                    var account = $(this).children('option:selected').attr("value");
                    var balance = dataJson[selectedAlias].balance;
                    $("#laAccount").val(account);
                    $("#laBalance").val(balance + " SZB");
                });

                $("#txtMoney").focus(function() {
                    var balance =  dataJson[$("#selectGroup").children('option:selected').text()].balance;
                    var canChargeMoney = Number(balance) - Number(0.5);
                    $("#moneyAlert").text("充值过程会产生手续费，可充值金额为" + canChargeMoney);
                });

                $("#btnConfirm").click(function() {
                    var money = $("#txtMoney").val();
                    var password = $("#txtPassword").val();
                    if(!regTest(money)){
                        return;
                    }
                    if(password == "") {
                        alert("请输入密码");
                        return;
                    }
                    var account = $("#laAccount").val();
                    var alias = $("#selectGroup").children('option:selected').text();
                    var defaultAccJson = dataJson.默认账户;
                    var balance = dataJson[alias].balance;
                    if (Number(balance) - Number(0.5) < money) {
                        alert("请输入正确的金额");
                        return;
                    }

                    $("#btnConfirm").attr("disabled", true);
                    $("#waitGif").show();
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/test/getChargeConfirm.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "account" : account,
                            "password" : password,
                            "money" : money,
                            "alias" : alias,
                            "defaultAcc" : defaultAccJson.account
                        })},
                        dataType: "json",
                        success: function(data) {
                            $("#waitGif").hide();
                            if(!data.success) {
                                if (data.errMsg == "invalidPassword") {
                                    alert("密码不能解锁账户，请确认");
                                    $("#btnConfirm").attr("disabled", false);
                                }
                                return;
                            }
                            alert("充值成功，请稍后在我的账户查看");
                            window.location.href = "/mobile/plugin/dch/smb/test/accManager.jsp?itcode="+itcode;
                        }
                    });
                });

                $("#btnInputConfirm").click(function() {
                    var account = $("#inAccount").val();
                    var keystore = $("#inKeystore").val();
                    var password = $("#inPassword").val();
                    if(account == "" || keystore == "" || password == "") {
                        alert("请将信息补充完整");
                        return;
                    }
                    if(!regAddress(account)) {
                        return;
                    }
                    if(!regKeystore(keystore)) {
                        return;
                    }
                    if(account.substring(2) != JSON.parse(keystore).address) {
                        alert("地址与私钥不匹配");
                        return;
                    }
                    var defaultAccJson = dataJson.默认账户;

                    $("#divWait").css("margin-top", "60%");
                    $("#waitGif").show();
                    $("#btnInputConfirm").attr("disabled", true);
                    $.ajax({
                        type: "GET",
                        url: "/mobile/plugin/dch/smb/test/getChargeFromInputAccount.jsp",
                        data: {"jsonStr" : JSON.stringify({
                            "itcode" : itcode,
                            "account" : account,
                            "password" : password,
                            "keystore" : keystore,
                            "defaultAcc" : defaultAccJson.account
                        })},
                        dataType: "json",
                        success: function(data) {
                            $("#waitGif").hide();
                             if(!data.success) {
                                if (data.errMsg == "invalidPassword") {
                                    alert("密码不能解锁账户，请确认");
                                    $("#btnInputConfirm").attr("disabled", false);
                                } else if(data.errMsg == "balanceNotEnough") {
                                    alert("账户余额不足");
                                    $("#btnInputConfirm").attr("disabled", false);
                                }
                                return;
                            }
                            alert("充值成功，请稍后在我的账户查看");
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
                <div class="col-xs-12 col-md-12" align="center">
                    <ul class="nav nav-tabs navbar-fixed-top navbar-inverse">
                      <li id="liLocal" style="width: 50%;"><a id="aLocal" style="color: white;">本地账户</a></li>
                      <li id="liInput" style="width: 50%;"><a id="aInput" style="color: white;">输入账户</a></li>
                    </ul>
                </div>
                <div class="col-xs-12 col-md-12" align="center" style="margin-top: 50px;">
                    <div id="divContentLocal">
                        <div>
                            <h4 style="float: left; display: inline-block;">来源账户</h4>
                            <select id="selectGroup" class="selectpicker">
                            </select>
                        </div><br>
                        <div>
                            <h4 style="float: left;">账户</h4>
                            <input id="laAccount" class="form-control required" readonly="readonly" />
                        </div><br>
                        <div>
                            <h4 style="float: left;">余额</h4>
                            <input id="laBalance" class="form-control required" readonly="readonly" />
                        </div><br>
                        <div>
                            <h4 style="float: left;">充值金额</h4>
                             <input id="txtMoney" class="form-control required"/>
                             <h5 id="moneyAlert" style="color: red;"></h5>
                        </div><br>
                        <div>
                            <h4 style="float: left;">账户密码</h4>
                            <input id="txtPassword" type="password" class="form-control required"/><br>
                            <h5 style="color: red;">充值是由您的来源账户向默认钱包进行转账</h5>
                        </div><br>
                        <button id="btnConfirm" type="button" class="btn btn-info btn-lg btn-block">
                            确认充值
                        </button>
                    </div>
                    <div id="divContentInput" hidden="true">
                        <div>
                            <h4 style="float: left;">账户</h4>
                            <input id="inAccount" class="form-control required" placeholder="请输入地址"/>
                        </div><br>
                        <div align="left">
                            <button id="btnQuery" type="button" class="btn btn-default btn-sm">
                            查询余额
                            </button>
                            <font id="fontBalance" style="margin-left: 60px;color: gray;"></font>
                        </div><br>
                        <div>
                            <h4 style="float: left;">私钥</h4>
                            <textarea id="inKeystore" class="form-control required" placeholder="请输入Keystore"></textarea><br>
                        </div><br>
                        <div>
                            <h4 style="float: left;">账户密码</h4>
                            <input id="inPassword" type="password" class="form-control required" placeholder="请输入密码" /><br>
                        </div><br>
                        <button id="btnInputConfirm" type="button" class="btn btn-info btn-lg btn-block">
                            确认充值
                        </button>
                    </div>
                </div>
                <div id="divWait" class="col-xs-12 col-md-12" align="center" style="position: absolute;margin-top: 75%;z-index: 100;">
                    <img id="waitGif" src="../img/walletWait.gif" hidden="hidden">
                </div>
            </div>
        </div>  
    </body>
</html> olute;margin-top: 75%;z-index: 100;">
                    <img id="waitGif" src="../img/walletWait.gif" hidden="hidden">
                </div>
            </div>
        </div>  
    </body>
</html> 