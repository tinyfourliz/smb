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
        <title>投票话题展示页面</title>
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
                
            });
        </script>
    </head>
    <body style="font-family:微软雅黑;" >
    	 <div class="container" style="">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="margin-top: 15px;">
                    <!-- <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">为什么当下很多人都愿意做单身狗？</h3>
                        </div>
                        <table class="table">
                            <th>产品</th><th>价格 </th>
                            <tr><td>产品 A</td><td>200</td></tr>
                        </table>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">是不是越开放的时代，婚姻就越没价值？</div>
                        <table class="table">
                            <th>产品</th><th>价格 </th>
                            <tr><td>产品 A</td><td>200</td></tr>
                            <tr><td>产品 B</td><td>400</td></tr>
                        </table>
                    </div> -->
                    <table style="table-layout:fixed;" class="table table-striped">
                        <!-- <caption style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;text-align:center;color:#4C4C4C;font-weight:bold;" align="center"></caption> -->
                        <col style="width: 70%" />
                        <col style="width: 15%" />      
                        <col style="width: 15%" />      
                        <tbody>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">为什么当下很多人都愿意做单身狗？</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;">lizhe1</td>
                                <td style="color:gray;vertical-align: middle;text-align:center;"> > </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>  
    </body>
</html>