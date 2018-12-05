<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dch.HttpUrlService"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.file.FileUpload"%>
<%
	response.setCharacterEncoding("UTF-8");
	FileUpload fu9 = new FileUpload(request);
	String voteID = Util.null2String((String) fu9.getParameter("voteID"));
	HttpUrlService hus = new HttpUrlService();
	String status = hus.doHttpUrlNet("http://10.0.5.218:8082/vote/topic/" + voteID, null, "GET");
	response.getWriter().print(status);
%>