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
        <link rel="stylesheet" href="../css/bootstrap-select.min.css" />
        <script type='text/javascript' src='../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../js/jquery.form.js'></script>
        <script type='text/javascript' src="../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../js/web3.min.js'></script>
        <script type='text/javascript' src='../js/bignumber.js'></script>
        <script type='text/javascript' src='../js/ckeditor5/ckeditor.js'></script>
		<script type='text/javascript' src='../js/ckeditor5/translations/zh-cn.js'></script>
		<script type='text/javascript' src='../js/bootstrap-select.min.js'></script>
		<script type="text/javascript">

        	var itcode = '<%=it_code1 %>';
			var myEditor = null;
			$(function() {
				$('.selectpicker').selectpicker('refresh');
				function getInfo() {
					var articleName = $("#ArticleName").val();
					var articleContent = myEditor.getData();
					var articleFreePart = $("#selectGroup").children('option:selected').attr("value");
					var articlePrice = $("#ArticlePrice").val();
					var articleBalance = $("#ArticleBalance").val();

					//URLEncoder.encode不能对%进行编码，此处手动进行转码处理
					articleName = articleName.replace(/\%/g, "%25");
					articleContent = articleContent.replace(/\%/g, "%25");
					articleFreePart = articleFreePart.replace(/\%/g, "%25");
					articlePrice = articlePrice.replace(/\%/g, "%25");
					articleBalance = articleBalance.replace(/\%/g, "%25");

					var infoJson = {
						"itcode" : itcode,
						"articleName" : articleName,
						"articleContent" : articleContent,
						"articleFreePart" : articleFreePart,
						"articlePrice" : articlePrice,
						"articleBalance" : articleBalance
					};
					return infoJson;
				}

				//TODO 向服务器发送请求
				$("#btnConfirm").click(function() {
					var jsonStr = JSON.stringify(getInfo());
					$.ajax({
						type:"POST",
						url:"/mobile/plugin/dch/smb/PaidArticle/addPaidArticleAction.jsp",
						data:{jsonStr:jsonStr},
						dataType:"json",
						success:function(data){
							if(data.success){
								alert("提交成功！");
								location.reload();
							}else if (data.errMsg == "insert failed") {
								alert("提交失败！");
							}
						}
					});
					// alert(JSON.stringify(json));
				});

			});
			window.onload = function(){
    			DecoupledEditor.create( document.querySelector( '#editor' )
    				, {
	                //工具栏，可选择添加或去除
	                toolbar: ['heading', '|', 'fontSize', 'fontFamily', '|', 'bold', 'italic', 'strikethrough', 'underline', 'highlight', '|', 'alignment', '|', 'numberedList', 'bulletedList', '|', 'link', 'blockQuote', 'insertTable', '|','undo', 'redo'],
	                //editor加载中文简体，默认是英文
	                language: 'zh-cn'
            	} 
            )
		        .then( editor => {
		        	//将局部变量editor赋予全局变量myEditor
		        	myEditor = editor;

		            const toolbarContainer = document.querySelector( '#toolbar-container' );

		            toolbarContainer.appendChild( editor.ui.view.toolbar.element );
		        } )
		        .catch( error => {
		            console.error( error );
		        } );
			}

		</script>
    </head>
	<body>
		<div class="container" style="height: 500px;">
			<div class="row" style="height: 500px;">
				<div class="col-xs-12 col-md-12" align="center" style="margin-top: 10px;height: 200px;">
					<div>
						<input id="ArticleName" class="form-control required" type="text" style="width: 100%; height: 100%;outline: none;border-top: 0;border-right: 0; border-left: 0;" placeholder="文章名称"></input>
					</div>
					<!-- <div>
						<label style="float: middle;">免费阅读部分</label>
						<input id="ArticleFreePart" class="form-control required" type="text" style="width: 100%; height: 100%;" autofocus="autofocus" placeholder="此处为下拉框，显示1.前20%2.前50%。对应value：2,5"></input>
					</div> -->
					<div style="padding-top: 20px;">
						<input id="ArticleBalance" class="form-control required" type="text" style="width: 100%; height: 100%;outline: none;border-top: 0;border-right: 0; border-left: 0;" placeholder="充值金额"></input>
					</div>
					<div style="padding-top: 20px;">
						<input id="ArticlePrice" class="form-control required" type="text" style="width: 100%; height: 100%;outline: none;border-top: 0;border-right: 0; border-left: 0;" placeholder="文章价格"></input>
					</div>
					<div style="padding-top: 20px;">
                        <h4 style="float: left;font-size: 14px;color: gray;vertical-align: middle;display: inline-block;">免费阅读部分</h4>
                        <select id="selectGroup" class="selectpicker">
                        	<option value='2'>20%</option>
                        	<option value='5'>50%</option>
                        	<option value='10'>100%</option>
                        </select>
                    </div>
				</div>
				<div class="col-xs-12 col-md-12" style="margin-top: 20px;height: 280px;">
					<!-- 加载富文本编辑器 -->
					<div style="height: 280px;">
					    <!-- The toolbar will be rendered in this container. -->
					    <div id="toolbar-container" style=""></div>

					    <!-- This container will become the editable. -->
					    <div id="editor" style="border:1px solid gray;height: 180px;">
					    </div>
					</div>
				</div>
				<div>
					<button id="btnConfirm" type="button" class="btn btn-default btn-lg btn-block" style="position: fixed;bottom: 0px;">
		                提交
		            </button>						
				</div>
			</div>
		</div>
	</body>
	<!-- <footer>
		<div align="center" style="position: fixed;bottom: 0px;">
			<button id="btnConfirm" type="button" class="btn btn-default btn-lg btn-block">
                提交
            </button>
		</div>
	</footer> -->
</html>