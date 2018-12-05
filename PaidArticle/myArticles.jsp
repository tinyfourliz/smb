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
        <script type='text/javascript' src='../js/ckeditor5/ckeditor.js'></script>
		<script type='text/javascript' src='../js/ckeditor5/translations/zh-cn.js'></script>
		<script type='text/javascript' src='../js/bootstrap-paginator.js'></script>
		<script type="text/javascript">
        	var itcode = '<%=it_code1 %>';
        	var jsonObj = {};
        	var pageCount;
            var dataCount;
            var eachPageCount = 2;
			$(function() {
				window.turnPage = function(id, index) {
					$("#waitGif").show();
					var str = "<div style='height:100px;'></div><nav class='navbar navbar-default navbar-fixed-bottom' role='navigation'><div class='container-fluid'><div class='navbar-header'>"
					+"<button type='button' class='navbar-toggle' data-toggle='collapse' data-target='#example-navbar-collapse'>"
					+"<span class='icon-bar'></span><span class='icon-bar'></span><span class='icon-bar'></span></button>"
					+"<a class='navbar-brand' onclick='returnPage()'>返回</a>"
					/*+"<a class='navbar-brand' onclick='withdraw("+id+")'>提现</a>"
					+"<a class='navbar-brand' onclick='charge("+id+")'>充值</a>"*/
					+"</div><div class='collapse navbar-collapse' id='example-navbar-collapse'>"
					+"<ul class='nav navbar-nav'><li><a onclick='withdraw(&apos;" + index + "&apos;,&apos;"+ id +"&apos;)'>提现</a></li><li><a onclick='charge("+index+")'>充值</a></li></ul></div></div></nav>";
                    $.ajax({
						url:"/mobile/plugin/dch/smb/PaidArticle/getArticleContent.jsp",
						data:{"id":id},
						dataType:"json",
						success:function(data){
							if (data.success) {
								$("#contentView").html(data.content + str);
								$("#baseView").hide();
								$("#example").hide();
								$("#contentView").show();
								$("#waitGif").hide();
							}
						}
					});
                }

                /*返回*/
                window.returnPage = function() {
                	$("#baseView").show();
					$("#contentView").hide();
                }

                /*提现请求*/
                window.withdraw = function(index, id) {
                	//余额<30，不允许提现
                	console.log(jsonObj[index]);
                	if (jsonObj[index].balance < 30) {
                		alert("余额不足！");
                		return;
                	}
                	/*$("#fontValue")
                	jsonObj[id].balance -= */
                	//发送提现请求
                	$.ajax({
						url:"/mobile/plugin/dch/smb/PaidArticle/getWithdrawFromArticle.jsp",
						data:{"id":id,
							"itcode":itcode},
						dataType:"json",
						success:function(data){
							console.log(JSON.stringify(data));
							if (data.success) {
								
							}
						}
					});
                }

                /*充值请求*/
                window.charge = function() {

                }

                //分页
                function pagination(page) {
                    var innerHtml = "";
                    var eachPageCount_ = eachPageCount;
                    for(var each = (page-1)*eachPageCount; eachPageCount_ > 0; each++) {
                        eachPageCount_--;
                        var value = jsonObj[each];
                        if (value == undefined) break;
                        var price = value.price > 0 ? value.price : "免费";
                        innerHtml += "<tr style='border-radius: 20%;' onclick='turnPage(&apos;" + value.id + "&apos;,&apos;"+ each +"&apos;)'>"
                            +"<td text-align:center; style='vertical-align: middle;word-break: break-all;'><font style='font-size: 18px;font-weight: bold;text-align:left;'>"+value.name
                            +"</font><br><font style='font-size: 14px; color:gray;text-align:center;'>阅读量："+value.available+"&emsp;&emsp;&emsp;&emsp;价格："+price+"</font></td></tr>";
                    }
                    $("#tBody").html(innerHtml);
                }

				$.ajax({
					url:"/mobile/plugin/dch/smb/PaidArticle/getMyArticles.jsp",
					async: false,
					data:{"itcode":itcode},
					dataType:"json",
					success:function(data){
						if (data.success) {
							if (data.data.length <= 2) {
								$("#tBody").append("<p style='color:gray;margin-top：50px;text-align:center;'>您还未提交过任何文章</p>");
								return;
							}
	                        $(data.data).each(function(index, value) {
	                            jsonObj[index] = value;
	                        });
	                        dataCount = data.data.length;
                        	pageCount = Math.ceil(dataCount/eachPageCount);
						}
					}
				});

				pagination(1);
                if (dataCount > eachPageCount) {
                    $('#pageLimit').bootstrapPaginator({
                        currentPage: 1,//当前的请求页面。
                        totalPages: pageCount,//一共多少页。
                        size:"mini",//页眉的大小。
                        bootstrapMajorVersion: 3,//bootstrap的版本要求。
                        alignment:"right",
                        numberOfPages:4,//页数。
                        /*itemTexts: function (type, page, current) {//如下的代码是将页眉显示的中文显示自定义的中文。
                            switch (type) {
                            case "first": return "首页";
                            case "prev": return "上一页";
                            case "next": return "下一页";
                            case "last": return "末页";
                            case "page": return page;
                            }
                        },*/
                        onPageClicked : function(event, originalEvent, type, page) {
                            pagination(page);
                        }
                    });
                }
			});
		</script>
    </head>
	<body>
		<div class="container" style="min-height: 94%;margin-bottom: -50px;">
			<div class="row">
				<div class="col-xs-12 col-md-12" align="center" style="margin-top: 10px;">
					<div id="baseView">
						<table class="table table-striped" style="table-layout: fixed;">
	                        <tbody id="tBody">
	                        </tbody>
	                    </table>		
					</div>
					<div id="contentView" hidden="hidden" style="text-align: left;">
					</div>
				</div>
				<div id="divWait" class="col-xs-12 col-md-12" align="center" style="position: fixed;left: 50%;top: 50%;transform: translateX(-50%)translateY(-50%);-webkit-transform:translateX(-50%) translateY(-50%);">
                    <img id="waitGif" src="../img/walletWait.gif" hidden="hidden">
                </div>
			</div>
		</div>
		<footer style="height: 50px;"><div id="example" style="text-align: center;"> <ul id="pageLimit"></ul> </div></footer>
	</body>
</html>