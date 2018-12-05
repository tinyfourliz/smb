<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dch.HttpUrlService"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.file.FileUpload"%>
<%
	response.setCharacterEncoding("UTF-8");
	HttpUrlService hus = new HttpUrlService();
	String status = hus.doHttpUrlNet("http://10.0.5.218:8082/vote/todayTopicAndOptions", null, "GET");
	response.getWriter().print(status);
%>