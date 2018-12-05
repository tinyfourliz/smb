<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%@ page import="com.dch.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	BaseBean bbbu = new BaseBean();
	FileUpload f_uu = new FileUpload(request);
	String itcode = Util.null2String((String) f_uu.getParameter("itcode"));
	HttpUrlService httpService = new HttpUrlService();
	String url = "http://10.0.5.218:8082/paidRead/queryMine";
	String result = httpService.doHttpUrlNet(url+"?itcode="+itcode,null, "GET");
	out.print(result);
%>