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
        <title>添加红包页面</title>
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
				function getInfo() {
					var luckyNum = $("#txtAraLuckyNum").val();
					var luckyGuys = $("#txtAraLuckyGuys").val();
					var luckyGuysCount = $("#txtAraLuckyGuysCount").val();

					var infoJson = {
						"luckyNum" : luckyNum,
						"luckyGuys" : luckyGuys,
						"luckyGuysCount" : luckyGuysCount
					}

					return infoJson;
				}

				//TODO 向服务器发送请求
				$("#btnConfirm").click(function() {

					var jsonStr = JSON.stringify(getInfo());
					console.log(jsonStr);
					$.ajax({
						url:"/mobile/plugin/dch/smb/admin/addLuckyNumberAction.jsp",
						data:{jsonStr:jsonStr},
						dataType:"json",
						success:function(data){
							if(data.success){
								alert("保存成功！");
								location.reload();
							}
						}
					});
					// alert(JSON.stringify(json));
				});
			});
		</script>
    </head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-12" align="center">
					<div>
						<label style="float: left;">红包码</label>
						<input id="txtAraLuckyNum" class="form-control required" type="text" style="width: 100%; height: 100%;" autofocus="autofocus"></input>
					</div>
					<div>
						<label style="float: left;">中奖位次（逗号分隔）</label>
						<input id="txtAraLuckyGuys" class="form-control required" type="text" style="width: 100%; height: 100%;"></input>
					</div>
					<div>
						<label style="float: left;">中奖人数</label>
						<input id="txtAraLuckyGuysCount" class="form-control required" type="text" style="width: 100%; height: 100%;"></input>
					</div>
					<div align="center">
						<button id="btnConfirm" class="btn btn-info btn-lg" style="margin-top: 20px;">
                            提交
                        </button>
					</div>
				</div>
			</div>
		</div>	
	</body>
</html>