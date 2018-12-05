<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dch.HttpUrlService"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.file.FileUpload"%>
<%
	response.setCharacterEncoding("UTF-8");
	FileUpload fu9 = new FileUpload(request);
	String it_code = Util.null2String((String) fu9.getParameter("itcode"));

	HttpUrlService hus = new HttpUrlService();
	String status = hus.doHttpUrlNet("http://10.0.5.217:8080/eth/transition/counter/" + it_code, null, "GET");
	response.getWriter().print(status);
%>