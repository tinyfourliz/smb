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
        <title>投票选择你身边的技术大拿</title>
        <link rel="stylesheet" id="" href="../../css/trav.css"/>
        <link rel="stylesheet" id="" href="../../css/bootstrap.min.css" type="text/css" />
        <script src="../../js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="../../js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" id="" href="../../css/weui.min.css" />
        <link rel="stylesheet" id="" href="../../css/jquery-weui.min.css" />
        <link rel="stylesheet" id="" href="../../css/icon.css" />
        <link rel="stylesheet" id="" href="../../css/task.css" />
        <script type='text/javascript' src='../../js/jquery.textarea.autoheight.js'></script>
        <script type='text/javascript' src='../../js/jquery.form.js'></script>
        <script type='text/javascript' src="../../js/jquery-weui.js"></script>
        <script type='text/javascript' src='../../js/fastclick.min.js'></script>
        <script type='text/javascript' src='../../js/web3.min.js'></script>
        <script type='text/javascript' src='../../js/bignumber.js'></script>
        
        <style type="text/css">
            #userChooseDiv {
                position: fixed;
                left: 100%;
                top: 0px;
                width: 100%;
                height: 100%;
                z-index: 99999;
            }
            body.hrmshow #userChooseDiv {
                left: 0;
            }
            #userChooseFrame {
                width: 100%;
                height: 100%;
            }
            .image1{
                width:50px; 
                height:50px; 
                border-radius:100px; 
            }
        </style>

        <script type="text/javascript">
        	var itcode = '<%=it_code1 %>';
            var topicId = 1;
            $(function () {
                window.voteToSomebody = function(itcode) {
                    if(confirm("您确定要给 ["+ itcode +"] 投票吗？") == true){
                        $.ajax({
                            type: "GET",
                            url: "/mobile/plugin/dch/comm/list.jsp",
                            data:{"pageNo":"","searchKey":itcode,"refType":"","catalog":"0"},
                            dataType: "json",
                            success: function(data) {
                                var infoList = data.list;
                                $(infoList).each(function(index, value) {
                                    if (value.loginid === itcode) {
                                        window.location.href="/mobile/plugin/dch/smb/vote/paidVote/technicalExpertsVote.jsp?count="+$("#main").text()+"&name="+value.lastname+"/"+itcode+"&dept="+value.depName;
                                    }
                                });
                            },
                        });
                    }
                } 

                $("#mine").click(function() {
                    window.location.href="/mobile/plugin/dch/smb/vote/paidVote/viewMine.jsp?itcode="+itcode+"&topicId="+topicId;
                });
                
                $.ajax({
                    type: "GET",
                    url: "/mobile/plugin/dch/smb/vote/getPaidVoteTop5.jsp",
                    data:{topicId:topicId},
                    dataType: "json",
                    success: function(data) {
                        $(data).each(function(index, value) {
                            var innerHtml = "";
                            if (index < 3) {
                                var backImgPath = "../../img/rankBack"+(index+1)+".JPG";
                                var rankImgPath = "../../img/rankList"+(index+1)+".png";
                                innerHtml = "<tr style='background-image: url("+backImgPath+");border-radius: 20%;' onclick='voteToSomebody(&apos;" + value.key + "&apos;)'>"
                                    +"<td style='text-align: center;'><img src='"+rankImgPath+"' style='width: 55px;height: 55px;'></td>"
                                    +"<td style='text-align: center; vertical-align: middle;font-weight: bold;'>"+value.key+"</td>"
                                    +"<td style='text-align: center; vertical-align: middle;'>"+value.value+"</td></tr>";
                            } else {
                                var rankImgPath = "../../img/rankList"+(index+1)+".png";
                                innerHtml = "<tr style='height: 60px;' onclick='voteToSomebody(&apos;" + value.key + "&apos;)'>"
                                    +"<td style='text-align: center; vertical-align: middle;'><img src='"+rankImgPath+"' style='width: 25px;height: 25px;'></td>"
                                    +"<td style='text-align: center; vertical-align: middle;font-weight: bold;'>"+value.key+"</td>"
                                    +"<td style='text-align: center; vertical-align: middle;'>"+value.value+"</td></tr>";
                            }
                            $("#tBody").append(innerHtml);
                        });
                    },
                });
            
                // 搜索投票人
                $("#vote").click(function(){
                    $.ajax({
                        url:"/mobile/plugin/dch/smb/turnnum.jsp",
                        data:{itcode1:itcode},
                        dataType:"text",
                        success:function(data){
                            if(data.search("1") != -1){
                                // 弹出模态框
                                $('#myModal').modal({
                                    keyboard: true
                                });
                            }else{
                                alert(data.trim());
                            }
                        }
                    }); 
                });

                $("#pageMain").infinite().on("infinite", function(){//滚动加载
                     if(LOADING){
                        return;
                     }
                     pageNo = pageNo+1;
                     if(pageNo>totalPage){
                         return;
                     }
                     LOADING = true;
                     getHrmList(2);//加载更多,append
                });
                initPageQuery("0");
            });

            function initPageQuery(temp){
                pageNo = 1;
                totalPage = 0;
                if(temp == "1"){
                    getHrmList(1);
                }else{
                    getHrmList(3);
                }
            }
            function getHrmList(type){
                var searchKey = $.trim($("#searchKey").val());
                if(searchKey == "" && type != 3){
                    return;
                }
                if(type==1){
                    $.showLoading();
                }else{
                    $('#loadmore').show();
                }
                // 查询并展示搜索的人员信息
                $("#form2").ajaxSubmit({
                    data:{"pageNo":pageNo,"searchKey":searchKey,"refType":type,"catalog":"0"},
                    dataType:"json",
                    success:function(data){
                        if(data.status==0){
                            totalPage = data.totalPage;
                            if(data.list.length>0){
                                var tempStr = "";
                                for(var i=0;i<data.list.length;i++){
                                    var user = data.list[i];
                                    tempStr += "<div class='weui-media-box weui-media-box_text' style='height: 70px;' > ";
                                    
                                    tempStr += "<div style='float: left;width:10%;margin-top: 5px;'>";
                                    tempStr += "<input type='radio' name='person' style='margin-top: 15px;' class='MyRadio'/>";
                                    tempStr +=  "</div>";
                                    
                                    tempStr += "<div style='float: left;width:18%;margin-top: 5px;' >";
                                    tempStr += "<img class='image1' id='"+i+"' src='"+user.imgsrc+"'>";
                                    tempStr += "</div>";
                                    
                                    tempStr += "<div style='float: left;width:72%;' >";
                                    tempStr += "<div class='weui-media-box__title' id='PerName"+i+"'>";
                                    tempStr += user.lastname;
                                    tempStr += "/"+user.loginid;
                                    tempStr += "</div>";
                                    tempStr += "<p class='weui-media-box__desc'>"+ user.depName +"</p>";
                                    tempStr += "</div>";
                                    
                                    tempStr += "</div>";
                                }
                                if(type==1){
                                    $("#pageList").html(tempStr);
                                }else{
                                    $("#pageList").append(tempStr);
                                }
                            }else if(type==1){
                                $("#pageList").html("<div class='weui-loadmore weui-loadmore_line'><span class='weui-loadmore__tips'>没有查出结果</span></div>");
                            }
                        }else{
                            $.alert(data.msg);
                        }
                        
                        // 选中人员后跳转到转账页面
                        $(".weui-media-box").click(function(i,n){
                            var $img = $(this).find("img").attr("src");  // 头像图片
                            var rownum = $(this).find("img").attr("id");
                            var $name = $(this).find("#PerName"+rownum).html(); // 姓名/itcode
                            if($name.search(itcode) != -1){
                                alert("不支持为自己投票的行为");
                            }else{
                                var $dept = $(this).find("p").text();  // 部门
                                $('#myModal').modal('hide');// 关闭模态框
                                window.location.href="/mobile/plugin/dch/smb/vote/paidVote/technicalExpertsVote.jsp?count="+$("#main").text()+"&name="+$name+"&dept="+$dept;
                            }   
                        });
             
                    },
                    error:function(data){
                        $.alert(data);
                    },
                    complete:function(){
                        if(type==1){
                            $.hideLoading();
                            $("#pageMain").pullToRefreshDone();
                        }else{
                            $('#loadmore').hide();
                            LOADING = false;
                        }
                    }
                });
            }
        </script>
    </head>
    <style type="text/css">

    </style>
    <body style="font-family:微软雅黑;" >
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <center><h4 class="modal-title" id="myModalLabel">人员查询</h4></center>
                    </div>
                    <div class="modal-body" style="height: 220px;">
                        
                        <form id="form1" action="" method="post" onsubmit="initPageQuery('1');return false;">
                            <div class="weui-search-bar" id="searchBar">
                                <div class="weui-search-bar__form">
                                    <div class="weui-search-bar__box">
                                        <i class="weui-icon-search"></i> 
                                        <input type="search" name="searchKey" class="weui-search-bar__input" id="searchKey" placeholder="姓名，ITCode，员工编号，电话" />
                                        <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                                    </div>
                                    <label class="weui-search-bar__label" id="searchText"> 
                                        <i class="weui-icon-search"></i> 
                                        <span>姓名，ITCode，员工编号，电话</span>
                                    </label>
                                </div>
                            </div>
                        </form> 
                        <form id="form2" action="/mobile/plugin/dch/comm/list.jsp" method="post" onsubmit="return false;"></form>
                        <div id="pageMain" style="top:45px;bottom:0; width:100%">
                            <div>
                                <div id="pageList"></div>
                                <div id="loadmore" class="weui-loadmore" style="display:none; ">
                                    <i class="weui-loading"></i>
                                    <span class="weui-loadmore__tips">正在加载</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- <div id="bod" style="overflow-x:hidden;margin:5px">
            <div id="vote" style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
                <img src="../../img/vote.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;进入投票
                <img src="../../img/1.png" style="float:right;width:30px;height:30px;margin-top:10px;" >
            </div>
            <hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
        </div> -->
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-12" align="center" style="">
                    <div style="margin-top: 15px;">
                        <font id="vote" style="float: left;"><img src="../../img/voteSearch.png" style="width: 20px;height: 20px;"> 进入投票</font>
                        <a id="mine" style="float: right;color: gray;">查看我的</a>
                    </div>
                   <table class="table table-condensed" style="table-layout: fixed;">
                        <caption id="tabCaption" style="text-align: center;font-size: 22px;font-weight: bold;">技术排行榜</caption>
                        <col style="width: 30%" />
                        <col style="width: 35%" />
                        <col style="width: 35%" />
                        <thead>
                            <tr>
                              <th style="text-align: center;color: gray;font-size: 80%;">排名</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">ITCODE</th>
                              <th style="text-align: center;color: gray;font-size: 80%;">得票</th>
                            </tr>
                        </thead>
                        <tbody id="tBody">
                        </tbody>
                    </table>
                    <font style="color: gray; text-align: center;">(点击为TA投票吧~)</font>
                </div>
            </div>
        </div>
    </body>
</html>