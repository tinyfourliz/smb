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
        <title>排名</title>
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
                    url: "/mobile/plugin/dch/smb/test/getRandList.jsp",
                    dataType: "json",
                    success: function(data) {
                        $(data).each(function(index, value) {
                            $("#itcode" + (index + 1)).text(value.key);
                            $("#score" + (index + 1)).text(value.value);
                        });
                    }
                });
            });
        </script>
    </head>
    <style type="text/css">
        td {
            text-align: center;
            vertical-align: middle;
        }
    </style>
    <body style="font-family:微软雅黑;" >
    	 <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="">
                   <table class="table table-condensed" style="table-layout: fixed;">
                        <caption id="tabCaption" style="text-align: center;"><img src="../img/rankTitle.png" style="width: 150px;height: 50px;"></caption>
                        <col style="width: 30%" />
                        <col style="width: 35%" />
                        <col style="width: 35%" />
                        <thead>
                            <tr>
                              <th style="text-align: center;color: gray;font-size: 80%;">排名</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">ITCODE</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">辛勤指数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="background-image: url(../img/rankBack1.JPG);border-radius: 20%;">
                                <td style="text-align: center;"><img src="../img/rankList1.png" style="width: 55px;height: 55px;"></td>
                                <td id="itcode1" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score1" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                            <tr style="background-image: url(../img/rankBack2.JPG);border-radius: 20%;">
                                <td style="text-align: center;"><img src="../img/rankList2.png" style="width: 55px;height: 55px;"></td>
                                <td id="itcode2" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score2" style="text-align: center; vertical-align: middle;"></td>
                            <tr style="background-image: url(../img/rankBack3.JPG);border-radius: 20%;">
                                <td style="text-align: center;"><img src="../img/rankList3.png" style="width: 55px;height: 55px;"></td>
                                <td id="itcode3" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score3" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                            <tr style="height: 60px;">
                                <td style="text-align: center; vertical-align: middle;"><img src="../img/rankList4.png" style="width: 25px;height: 25px;"></td>
                                <td id="itcode4" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score4" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                            <tr style="height: 60px;">
                                <td style="text-align: center; vertical-align: middle;"><img src="../img/rankList5.png" style="width: 25px;height: 25px;">
                                <td id="itcode5" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score5" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                            <tr style="height: 60px;">
                                <td style="text-align: center; vertical-align: middle;"><img src="../img/rankList6.png" style="width: 25px;height: 25px;">
                                <td id="itcode6" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score6" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                            <tr style="height: 60px;">
                                <td style="text-align: center; vertical-align: middle;"><img src="../img/rankList7.png" style="width: 25px;height: 25px;">
                                <td id="itcode7" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score7" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                            <tr style="height: 60px;">
                                <td style="text-align: center; vertical-align: middle;"><img src="../img/rankList8.png" style="width: 25px;height: 25px;">
                                <td id="itcode8" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score8" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                            <tr style="height: 60px;">
                                <td style="text-align: center; vertical-align: middle;"><img src="../img/rankList9.png" style="width: 25px;height: 25px;">
                                <td id="itcode9" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score9" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                            <tr style="height: 60px;">
                                <td style="text-align: center; vertical-align: middle;"><img src="../img/rankList10.png" style="width: 25px;height: 25px;">
                                <td id="itcode10" style="text-align: center; vertical-align: middle;font-weight: bold;"></td>
                                <td id="score10" style="text-align: center; vertical-align: middle;"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>  
    </body>
</html>