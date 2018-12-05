<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload f_u = new FileUpload(request);
	String fromitcode = Util.null2String((String) f_u.getParameter("fromitcode"));
	String toitcode = Util.null2String((String) f_u.getParameter("tocode"));
	String money = Util.null2String((String) f_u.getParameter("money"));
	HttpUrlService httpService = new HttpUrlService();
	String string =  httpService.doHttpUrlNet("http://10.7.10.126:8080/eth/transition/"+fromitcode+"-"+toitcode+"-"+money,null , "GET");
	out.print(string);
%>