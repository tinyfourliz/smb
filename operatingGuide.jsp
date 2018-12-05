<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="author" content="Weaver E-Mobile Dev Group" />
        <meta name="description" content="Weaver E-mobile" />
        <meta name="keywords" content="weaver,e-mobile" />
        <meta name="viewport" content="width=device-width,minimum-scale=1.0, maximum-scale=1.0" />
        <title>钱包介绍页面</title>
        <link rel="stylesheet" href="./css/trav.css"/>
        <link rel="stylesheet" href="./css/bootstrap.min.css" type="text/css" />
        <script src="./js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="./js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="./css/weui.min.css" />
        <link rel="stylesheet" href="./css/jquery-weui.min.css" />
        <link rel="stylesheet" href="./css/icon.css" />
        <link rel="stylesheet" href="./css/task.css" />
        <script type='text/javascript' src='./js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='./js/jquery.form.js'></script>
        <script type='text/javascript' src="./js/jquery-weui.js"></script>
        <script type='text/javascript' src='./js/fastclick.min.js'></script>
        <script type='text/javascript' src='./js/web3.min.js'></script>
        <script type='text/javascript' src='./js/bignumber.js'></script>
        <script type="text/javascript">
            $(function() {
                var innerHtmlMain = "<div><p class='lead'>1、点击进入福利页面。</p><img src='./img/walletIntroduce_10.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>2、参与每日签到，即可获得SZB奖励，连续签到获得更高奖励。<code>每日会随机发放支付宝现金红包</code>，点击红包简介，查看具体活动内容。</p><img src='./img/walletIntroduce_14.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>3、参与每日投票，获得SZB奖励。</p><img src='./img/walletIntroduce_17.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>";
                $("#divContent").html(innerHtmlMain);

                $("#liWelfare").click(function() {
                    $("#aTitle").text($("#liWelfare").text());
                    $("#btnToggle").trigger("click");

                    $("#divContent").html(innerHtmlMain);
                });

                $("#liTrans").click(function() {
                    $("#aTitle").text($("#liTrans").text());
                    $("#btnToggle").trigger("click");
                    var innerHtml = "<div><p class='lead'>1、点击进入查询页面。</p><img src='./img/walletIntroduce_11.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>2、输入转账人员的信息进行查询，点击查询结果进入转账页面。</p><img src='./img/walletIntroduce_15.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>3、输入转账金额，也可对对方进行评价，点击确认转账完成转账。</p><img src='./img/walletIntroduce_18.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>";

                    $("#divContent").html(innerHtml);
                });

                $("#liConsume").click(function() {
                    $("#aTitle").text($("#liConsume").text());
                    $("#btnToggle").trigger("click");
                    var innerHtml = "<div><p class='lead'>1、点击进入消费页面。</p><img src='./img/walletIntroduce_12.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>2、目前可消费的方式为虚拟机申请，详情请到相关页面进行查看。</p><img src='./img/walletIntroduce_16.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>";

                    $("#divContent").html(innerHtml);
                });

                $("#liDetail").click(function() {
                    $("#aTitle").text($("#liDetail").text());
                    $("#btnToggle").trigger("click");
                    var innerHtml = "<div><p class='lead'>1、点击进入明细页面。</p><img src='./img/walletIntroduce_13.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>2、即可查看钱包账户的所有收支记录。</p><img src='./img/walletIntroduce_19.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>";

                    $("#divContent").html(innerHtml);
                });
                
                $("#liNew").click(function() {
                    $("#aTitle").text($("#liNew").text().substring(1));
                    $("#btnToggle").trigger("click");
                    var innerHtml = "<div><p class='lead'>1、创建密语与密语密码，为您生成账户地址，日后可用密语来导入地址。服务器不会保存，请您妥善保管！</p><img src='./img/walletIntroduce_03.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>2、为新建账户输入账户名，不能与您名下的其他账户名重复。此处的密码用于交易，<code>一旦丢失，将造成您的资产损失</code>，服务器同样不会保存该密码。</p><img src='./img/walletIntroduce_01.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>3、创建完成后，您可进入我的账户查看。</p><img src='./img/walletIntroduce_02.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"

                    $("#divContent").html(innerHtml);
                });

                $("#liMine").click(function() {
                    $("#aTitle").text($("#liMine").text().substring(1));
                    $("#btnToggle").trigger("click");
                    var innerHtml = "<div><p class='lead'>1、这里会显示您的所有账户地址及余额。</p><img src='./img/walletIntroduce_04.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>2、点击相应账户，可获取您的<code>私钥</code>，复制并保存到您本地。<code>私钥与交易密码</code>是您解锁账户，<code>发起交易的唯一途径</code>，丢失将造成资产损失。</p><img src='./img/walletIntroduce_09.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>";

                    $("#divContent").html(innerHtml);
                });
                $("#liCharge").click(function() {
                    $("#aTitle").text($("#liCharge").text().substring(1));
                    $("#btnToggle").trigger("click");
                    var innerHtml = "<div><p class='lead'>1、充值是由您创建的账户向默认钱包账户进行转账，密码为您创建账户时的交易密码。</p><img src='./img/walletIntroduce_05.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>";

                    $("#divContent").html(innerHtml);
                });
                $("#liWithdraw").click(function() {
                    $("#aTitle").text($("#liWithdraw").text().substring(1));
                    $("#btnToggle").trigger("click");
                    var innerHtml = "<div><p class='lead'>1、提现是由您的默认钱包账户向您创建的账户进行转账，默认钱包账户要求<code>转账后所剩余额最少为10SZB</code>。</p><img src='./img/walletIntroduce_06.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>";

                    $("#divContent").html(innerHtml);
                });
                $("#liRecords").click(function() {
                    $("#aTitle").text($("#liRecords").text().substring(1));
                    $("#btnToggle").trigger("click");
                    var innerHtml = "<div><p class='lead'>1、交易记录中可查看您充值提现的历史记录，若某笔交易为待确认，则表示该笔交易还未成功。</p><img src='./img/walletIntroduce_07.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>"
                        + "<div><p class='lead'>2、点击可查看某笔交易的详细信息，<code>确认区块</code>为您的交易写入的链上区块序号。</p><img src='./img/walletIntroduce_08.jpg' class='img-rounded img-responsive center-block' style='border: groove;'></div><br>";

                    $("#divContent").html(innerHtml);
                });
            });
        </script>
    </head>
    <body style="font-family:微软雅黑;">
         <div class="container" style="">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center">
                    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                        <div class="navbar-header">
                            <button id="btnToggle" type="button" class="navbar-toggle" data-toggle="collapse"
                                    data-target="#navbar-collapse">
                                <span class="sr-only"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a id="aTitle" class="navbar-brand">福利</a>
                        </div>
                        <div class="collapse navbar-collapse" id="navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li id="liWelfare"><a>福利</a></li>
                                <li id="liTrans"><a>转账</a></li>
                                <li id="liConsume"><a>消费</a></li>
                                <li id="liDetail"><a>明细</a></li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        钱包 <b class="caret"></b>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li id="liNew" style="text-align: center;"><a>◎ 创建账户</a></li>
                                        <li id="liMine" style="text-align: center;"><a>◎ 我的账户</a></li>
                                        <li id="liCharge" style="text-align: center;"><a>◎ 充值</a></li>
                                        <li id="liWithdraw" style="text-align: center;"><a>◎ 提现</a></li>
                                        <li id="liRecords" style="text-align: center;"><a>◎ 交易记录</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </nav>
                    <div id="divContent" style="margin-top: 60px;">
                    </div>
                </div>
            </div>
        </div>  
    </body>
</html>