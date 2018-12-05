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
                    url: "/mobile/plugin/dch/smb/test/getStudyRankList.jsp",
                    dataType: "json",
                    success: function(data) {
                        $(data).each(function(index, value) {
                            var innerHtml = "";
                            if (index < 3) {
                                var backImgPath = "../img/rankBack"+(index+1)+".JPG";
                                var rankImgPath = "../img/rankList"+(index+1)+".png";
                                innerHtml = "<tr style='background-image: url("+backImgPath+");border-radius: 20%;'>"
                                    +"<td style='text-align: center;'><img src='"+rankImgPath+"' style='width: 55px;height: 55px;'></td>"
                                    +"<td style='text-align: center; vertical-align: middle;font-weight: bold;'>"+value.key+"</td>"
                                    +"<td style='text-align: center; vertical-align: middle;'>"+value.value+"</td></tr>";
                            } else {
                                var rankImgPath = "../img/rankList"+(index+1)+".png";
                                innerHtml = "<tr style='height: 60px;'>"
                                    +"<td style='text-align: center; vertical-align: middle;'><img src='"+rankImgPath+"' style='width: 25px;height: 25px;'></td>"
                                    +"<td style='text-align: center; vertical-align: middle;font-weight: bold;'>"+value.key+"</td>"
                                    +"<td style='text-align: center; vertical-align: middle;'>"+value.value+"</td></tr>";
                            }
                            $("#tBody").append(innerHtml);
                        });
                    },
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
                        <caption id="tabCaption" style="text-align: center;"><img src="../img/studyRankTitle.png" style="width: 150px;height: 50px;"></caption>
                        <col style="width: 30%" />
                        <col style="width: 35%" />
                        <col style="width: 35%" />
                        <thead>
                            <tr>
                              <th style="text-align: center;color: gray;font-size: 80%;">排名</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">ITCODE</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">学习指数</th>
                            </tr>
                        </thead>
                        <tbody id="tBody">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>  
    </body>
</html>