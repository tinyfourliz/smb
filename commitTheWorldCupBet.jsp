<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu49 = new FileUpload(request);
	String selectNum1 = Util.null2String((String) fu49.getParameter("remark"));
	String it_code1 = Util.null2String((String) fu49.getParameter("itcode"));
	String matchid1 = Util.null2String((String) fu49.getParameter("matchid"));
	
	HttpUrlService service44 = new HttpUrlService();

	service44.doHttpUrlNet("http://10.0.5.217:8080/eth/theworldcup/bet/"+matchid1+"/"+it_code1+"/"+selectNum1,null,"GET");
%>
