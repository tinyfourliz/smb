<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dch.HttpUrlService"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.file.FileUpload"%>
<%
	response.setCharacterEncoding("UTF-8");
	FileUpload fu9 = new FileUpload(request);
	String account = Util.null2String((String) fu9.getParameter("account"));
	String topicID = Util.null2String((String) fu9.getParameter("topicID"));
	HttpUrlService hus = new HttpUrlService();
	String status = hus.doHttpUrlNet("http://10.0.3.113:8082/vote/todayStatus?account=" + account + "&topicID=" + topicID, null, "GET");
	response.getWriter().print(status);
%>