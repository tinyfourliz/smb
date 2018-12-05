<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dch.HttpUrlService"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.file.FileUpload"%>
<%
	response.setCharacterEncoding("UTF-8");
	FileUpload fu9 = new FileUpload(request);
	String topicID = Util.null2String((String) fu9.getParameter("topicID"));
	String optionID = Util.null2String((String) fu9.getParameter("optionID"));
	String account = Util.null2String((String) fu9.getParameter("account"));

	HttpUrlService hus = new HttpUrlService();
	String status = hus.doHttpUrlNet("http://10.0.5.218:8082/vote/add?topicID=" + topicID + "&optionID=" + optionID + "&account=" + account, null, "GET");
	response.getWriter().print(status);
%>