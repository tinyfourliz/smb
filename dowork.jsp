<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu3 = new FileUpload(request);
	String account_Key = Util.null2String((String) fu3.getParameter("accountKey"));
	String it_code = Util.null2String((String) fu3.getParameter("itcode"));
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	Date date = new Date();
	String dateStr = dateFormat.format(date);
	HttpUrlService service3 = new HttpUrlService();
	String status =  service3.doHttpUrlNet("http://10.0.5.217:8080/eth/getTodayWork/"+dateStr+"/"+account_Key,null,"GET");
	if(status.equals("do")){
		out.print("1");
		service3.doHttpUrlNet("http://10.0.5.217:8080/eth/saveTodayWork/"+it_code+"="+account_Key+"=0="+dateStr,null,"GET");
	}else{
		out.print("2");
	}
 %>
