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
	FileUpload fu45 = new FileUpload(request);
	String selectNum = Util.null2String((String) fu45.getParameter("remark"));
	String it_code = Util.null2String((String) fu45.getParameter("itcode"));
	
	HttpUrlService service44 = new HttpUrlService();

	service44.doHttpUrlNet("http://10.0.5.217:8080/eth/casino/test/bet/"+it_code+"/"+selectNum,null,"GET");
 %>
