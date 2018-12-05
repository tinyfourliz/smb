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
	HttpUrlService httpService = new HttpUrlService();
	String url = "http://10.0.5.218:8082/paidRead/selectArticle";
	String result = httpService.doHttpUrlNet(url,null, "GET");
	out.print(result);
%>