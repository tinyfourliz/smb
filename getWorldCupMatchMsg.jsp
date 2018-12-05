<%@page import="weaver.general.Util"%>
<%@page import="weaver.file.FileUpload"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dch.HttpUrlService"%>
<%
	response.setCharacterEncoding("UTF-8");
	FileUpload fu9 = new FileUpload(request);
	String match_id = Util.null2String((String) fu9.getParameter("matchid"));
	HttpUrlService hus = new HttpUrlService();
	Map<String,String> map = new HashMap<String,String>();
	String worldCupMsg = hus.doHttpUrlNet("http://10.0.5.217:8080/eth/theworldcup/findMatch/" + match_id, map, "GET");
	response.getWriter().print(worldCupMsg);
%>