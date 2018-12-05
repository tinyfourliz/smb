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
        <title>文章标题展示</title>
        <link rel="stylesheet" id="" href="../css/trav.css"/>
        <link rel="stylesheet" id="" href="../css/bootstrap.min.css" type="text/css" />
        <script src="../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" id="" href="../css/weui.min.css" />
        <link rel="stylesheet" id="" href="../css/jquery-weui.min.css" />
        <link rel="stylesheet" id="" href="../css/icon.css" />
        <link rel="stylesheet" id="" href="../css/task.css" />
        <script type='text/javascript' src='../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../js/jquery.form.js'></script>
        <script type='text/javascript' src="../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../js/web3.min.js'></script>
        <script type='text/javascript' src='../js/bignumber.js'></script>
        <script type='text/javascript' src='../js/bootstrap-paginator.js'></script>
        <script type="text/javascript">
        	var itcode = '<%=it_code1 %>';
            var jsonObj = {};
            var jsonObjHot = {};
            var pageCount;
            var dataCount;
            var eachPageCount = 2;

            var hotDataCount;
            var timeDataCount;
            $(function () {
                //点击，跳转投票界面
                window.turnPage = function(id) {
                    $("#waitGif").show();
                    var str = "<div style='height:100px;'></div><nav class='navbar navbar-default navbar-fixed-bottom' role='navigation'><div class='container-fluid'><div class='navbar-header'>"
                    +"<button type='button' class='navbar-toggle' data-toggle='collapse' data-target='#example-navbar-collapse'>"
                    +"<span class='icon-bar'></span><span class='icon-bar'></span><span class='icon-bar'></span></button>"
                    +"<a class='navbar-brand' onclick='returnPage()'>返回</a>"
                    /*+"<a class='navbar-brand' onclick='withdraw("+id+")'>提现</a>"
                    +"<a class='navbar-brand' onclick='charge("+id+")'>充值</a>"*/
                    +"</div><div class='collapse navbar-collapse' id='example-navbar-collapse'>"
                    +"<ul class='nav navbar-nav'><li><a>敬请期待</a></li></ul></div></div></nav>";
                    $.ajax({
                        url:"/mobile/plugin/dch/smb/PaidArticle/getArticleContent.jsp",
                        data:{"id":id},
                        dataType:"json",
                        success:function(data){
                            if (data.success) {
                                console.log(data.content);
                                $("#contentView").html(data.content + str);
                                $("#baseView").hide();
                                $("#example").hide();
                                $("#guide").hide();
                                $("#contentView").show();
                                $("#waitGif").hide();
                            }
                        }
                    });
                }

                /*返回*/
                window.returnPage = function() {
                    $("#baseView").show();
                    $("#example").show();
                    $("#guide").show();
                    $("#contentView").hide();
                }               

                $("#mine").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/viewMine.jsp?itcode="+itcode+"&topicId="+topicId;
                });

                //分页
                function pagination(page, jsonObjType) {
                    var innerHtml = "";
                    var eachPageCount_ = eachPageCount;
                    for(var each = (page-1)*eachPageCount; eachPageCount_ > 0; each++) {
                        eachPageCount_--;
                        var value = jsonObjType[each];
                        if (value == undefined) break;
                        var price = value.price > 0 ? value.price : "免费";
                        innerHtml += "<tr style='border-radius: 20%;' onclick='turnPage(&apos;" + value.id + "&apos;)'>"
                            +"<td text-align:center; style='vertical-align: middle;word-break: break-all;'><font style='font-size: 18px;font-weight: bold;text-align:left;'>"+value.name
                            +"</font><br><font style='font-size: 14px; color:gray;text-align:center;'>阅读量："+value.available+"&emsp;&emsp;&emsp;&emsp;价格："+price+"</font></td></tr>";
                    }
                    $("#tBody").html(innerHtml);
                }

                //分页显示
                function paginationShow(jsonObjType) {
                    pagination(1, jsonObjType);
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
                                pagination(page, jsonObjType);
                            }
                        });
                        $('#pageLimit').show();
                    } else {
                        $('#pageLimit').hide();
                    }
                }

                //安热度显示 TODO
                $("#hot").click(function() {
                    $("#switchMode").text("按热度");
                    if (JSON.stringify(jsonObjHot) == "{}") {
                        $("#tBody").html("<p style='color:gray;margin-top：10%;text-align:center;'>当前暂无数据</p>");
                        return;
                    }
                    dataCount = hotDataCount;
                    pageCount = Math.ceil(dataCount/eachPageCount);
                    paginationShow(jsonObjHot);
                });

                //按时间显示 TODO
                $("#time").click(function() {
                    $("#switchMode").text("按时间");
                    if (JSON.stringify(jsonObj) == "{}") {
                        $("#tBody").html("<p style='color:gray;margin-top：10%;text-align:center;'>当前暂无数据</p>");
                        return;
                    }
                    dataCount = timeDataCount;
                    pageCount = Math.ceil(dataCount/eachPageCount);
                    paginationShow(jsonObj);
                });

                $("#btnSearch").click(function() {
                    var searchStr = $("#txtSearch").val();
                    var modeNow = $("#switchMode").text();
                    var jsonObjTemp = {};
                    var index = 0;
                    if ($("#btnSearch").text() == "取消") {
                        $("#btnSearch").text("搜索");
                        $("#txtSearch").val("");
                        if (modeNow == "按时间") {
                            dataCount = timeDataCount;
                            pageCount = Math.ceil(dataCount/eachPageCount);
                            paginationShow(jsonObj);
                        } else {
                            dataCount = hotDataCount;
                            pageCount = Math.ceil(dataCount/eachPageCount);
                            paginationShow(jsonObjHot);
                        }
                        return;
                    }   
                    if (searchStr == "") {
                        $("#txtSearch").attr("placeholder", "请输入文章名");
                        return;
                    }
                    if (modeNow == "按时间") {
                        for(var each in jsonObj) {
                            if (jsonObj[each].name.indexOf(searchStr) != -1) {
                                jsonObjTemp[index] = jsonObj[each];
                                index++;
                            }
                        }
                    } else {
                         for(var each in jsonObjHot) {
                            if (jsonObj[each].name.indexOf(searchStr) != -1) {
                                jsonObjTemp[index] = jsonObj[each];
                                index++;
                            }
                        }
                    }
                    if (JSON.stringify(jsonObjTemp) == "{}") {
                        $("#txtSearch").val("");
                        alert("抱歉，未搜索到与【"+ searchStr +"】相关的内容！");
                        /*$("#tBody").html("<p style='color:gray;margin-top：10%;text-align:center;'>抱歉，未搜索到与【"+ searchStr +"】相关的内容！</p>");
                        $('#pageLimit').hide(); */
                    } else {
                        dataCount = index;
                        pageCount = Math.ceil(dataCount/eachPageCount);
                        paginationShow(jsonObjTemp);
                        $("#btnSearch").text("取消");
                    }
                });

                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/PaidArticle/getQueryArticle.jsp",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        if (JSON.stringify(data) == "[]") {
                            $("#tBody").append("<p style='color:gray;margin-top：10%;text-align:center;'>当前暂无数据</p>");
                            return;
                        }
                        $(data).each(function(index, value) {
                            jsonObj[index] = value;
                        });
                        dataCount = data.length;
                        timeDataCount = dataCount;
                        pageCount = Math.ceil(dataCount/eachPageCount);
                    },
                });
                paginationShow(jsonObj);

                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/PaidArticle/getQueryArticleByHot.jsp",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        $(data).each(function(index, value) {
                            jsonObjHot[index] = value;
                        });
                        hotDataCount = data.length;
                    },
                });
            });
        </script>
    </head>
    <body style="font-family:微软雅黑;" >
        <div class="container" style="z-index: 1;min-height: 94%;margin-bottom: -50px;">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="margin-top: 10px;">
                    <div id="guide">
                        <div class="btn-group" style="float: left;">
                            <button type="button" class="btn btn-default dropdown-toggle" 
                                    data-toggle="dropdown">&nbsp;<font id="switchMode">按时间</font>&nbsp;<span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li id="time"><a>按时间</a></li>
                                <li class="divider"></li>
                                <li id="hot"><a>按热度</a></li>
                            </ul>
                        </div>
                        <div style="float: right;">
                            <input id="txtSearch" type="text" class="form-control" placeholder="文章名" style="display: inline;width: 120px;">
                            <button id="btnSearch" type="button" class="btn btn-default">搜索</button>
                        </div>
                    </div>
                    <div id="baseView" style="margin-top: 50px;">
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