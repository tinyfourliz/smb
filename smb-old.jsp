<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu = new FileUpload(request);
	String clienttype = Util.null2String((String) fu.getParameter("clienttype"));
	String clientlevel = Util.null2String((String) fu.getParameter("clientlevel"));
	String module = Util.null2String((String) fu.getParameter("module"));
	String scope = Util.null2String((String) fu.getParameter("scope"));
	String param = "clienttype=" + clienttype + "&clientlevel="+ clientlevel + "&module=" + module + "&scope=" + scope;
	
	User _user = HrmUserVarify.getUser(request, response);
	String _itcode = _user.getLoginid();
	RecordSet recordSet = new RecordSet();
	String sql = "SELECT accountkey FROM smb_dch WHERE itcode='"+_itcode+"'";
	recordSet.executeSql(sql);
	String accountKey = "";
	if(recordSet.next()){
		accountKey = Util.null2String(recordSet.getString("accountkey"));
	}
	HttpUrlService service = new HttpUrlService();
	String s =  service.doHttpUrlNet("http://10.7.10.126:8080/eth/getBalance/"+accountKey,null , "GET");
	
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
<title>神码币</title>
<link rel="stylesheet" href="css/trav.css"/>
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/weui.min.css" />
<link rel="stylesheet" href="css/jquery-weui.min.css" />
<link rel="stylesheet" href="css/icon.css" />
<link rel="stylesheet" href="css/task.css" />
<script type='text/javascript' src='js/jquery.textarea.autoheight.js'></script>
<script type='text/javascript' src='js/jquery.form.js'></script>
<script type='text/javascript' src="js/jquery-weui.js"></script>
<script type='text/javascript' src='js/fastclick.min.js'></script>
<script type='text/javascript' src='js/web3.min.js'></script>
<script type='text/javascript' src='js/bignumber.js'></script>

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
	var param = "<%=param%>";
	var title="通讯录";
	var pageNo = 1;
	var totalPage = 0;
	var LOADING = false;//滚动加载状态标记
	
	$(function(){
		var originalBalance = '<%=s %>';
		if(originalBalance == "0"){
			money = originalBalance;
		}else if(originalBalance.indexOf(".") == -1){
			money = originalBalance;
		}else{
			var yuan =  originalBalance.split(".")[0];
			var mao = originalBalance.split(".")[1].substring(0,2);
			money = yuan+"."+mao;
		}
   		$("#main").html(money);
   		
   		$("#zhanshi").click(function(){
   			var $src = $(this).attr("src");
   			if($src == "img/zheng.png"){
   				$(this).attr("src","img/bi.png");
   				$("#main").html("******");
   			}else{
   				$(this).attr("src","img/zheng.png");
   				$("#main").html(money);
   			}
   		});
		$("#zhuanzhang").click(function(){
			 document.activeElement.blur();//禁止键盘弹出
			 $ys = $(this).prop('id');
			 
			 // 弹出模态框
			 $('#myModal').modal({
        		keyboard: true
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
   							tempStr +=	"</div>";
						    
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
					var $dept = $(this).find("p").text();  // 部门
					window.location.href="turncount.jsp?count="+$("#main").text()+"&name="+$name+"&dept="+$dept;
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
<body style="font-family:微软雅黑 " >
	<div id="bod" style="height:100%;overflow-x:hidden;margin:10px">
		<div style="width:100%;height:200px;background-color:#0f364c;margin:0;padding-top:40px">
			<div style="float:right;width:50px;height:50px;margin-right:20px">
				<img id="zhanshi" src="img/zheng.png" style="width:100%;height:100%">
			</div>
			<div style="margin-left:10px;color:white;width:100%">
				账户余额(神码币)
			</div>
			<div id="main" style="margin-top:20px;margin-left:10px;color:white;width:100%;font-size:60px;margin-left:20px">
			</div>
		</div>
		<div style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/zuorenwu.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;做任务
			<img src="img/1.png" style="float:right;width:30px;height:30px;margin-top:10px" >
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/zhuangzhang.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;转账
			<img src="img/1.png" style="float:right;width:30px;height:30px;margin-top:10px" id="zhuanzhang" >
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/tixian.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;提现
			<img src="img/1.png" style="float:right;width:30px;height:30px;margin-top:10px" >
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
		<div style="margin:10px 0px 10px 0px;height:50px;line-height:50px;font-size:20px">
			<img src="img/mingxi.png" style="margin-left:10px;width:50px;height:50px;float:left" >&nbsp;&nbsp;&nbsp;明细
			<img src="img/1.png" style="float:right;width:30px;height:30px;margin-top:10px" >
		</div>
		<hr class="hh" style="font-size: 0px;padding: 0;margin: 0;">
	</div>
	
	<!--
    	作者：xueleic
    	时间：2017-11-13
    	描述：模态框 搜索人员信息
    -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <center><h4 class="modal-title" id="myModalLabel">转账人员查询</h4></center>
            </div>
            <div class="modal-body" style="height: 400px;">
     			
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
</body>
</html>