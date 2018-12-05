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
        <title>管理员标签页面</title>
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
				var textNum = 1;

				window.addText = function() {
					var divId = "divChoice" + textNum;
					var textHtml = "<div class='form-group' id='" + divId +"'>"
						+"<input class='form-control required' type='text' name='textGroup'/>"
						+ "<img src='../img/minus.png' "
						+ " onclick='minusText(" + divId +")'></span></div>";

					$("#divTextGroup").append(textHtml);
					textNum++;
				}

				window.minusText = function(divId) {
					$(divId).remove();
				}

				function getInfo() {
					var topic = $("#txtAraTopic").val();
					var priority = $("#txtPriority").val();
					var options = [];
					$("input[name='textGroup']").each(function(){
						var option = $(this).val();
						if (option != "") {
							options.push(option);
						}
					});
					var infoJson = {
						"topic" : topic,
						"priority" : priority,
						"options" : options,
						"itcode" : itcode
					}

					return infoJson;
				}

				//TODO 向服务器发送请求
				$("#btnConfirm").click(function() {
					var jsonStr = JSON.stringify(getInfo());
					$.ajax({
						url:"/mobile/plugin/dch/smb/admin/addVoteTopicAction.jsp",
						data:{jsonStr:jsonStr},
						dataType:"text",
						success:function(data){
							if(data.trim() === "1"){
								alert("提交成功！");
								location.reload();
							}else if(data.trim() === "0"){
								alert("提交失败！");
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
						<label style="float: left;">主题</label>
						<input id="txtAraTopic" class="form-control required" type="text" style="width: 100%; height: 100%;" autofocus="autofocus"></input>
					</div>
					<div>
						<label style="float: left;">优先级</label>
						<input id="txtPriority" class="form-control required" type="text" style="width: 100%; height: 100%;" autofocus="autofocus"></input>
					</div>
					<div style="margin-top: 20px;">
						<label style="float: left;">选项</label>
					</div>
					<div id="divTextGroup">
						<div class="form-group">
		                    <input class="form-control required" type="text" name="textGroup"/>
	                    </div>
	                    <div class="form-group">
		                    <input class="form-control required" type="text" name="textGroup"/>
	                    </div>
	                </div>
					<div>
						<img src="../img/plus.png" id="iconPlus" onclick="addText()">
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