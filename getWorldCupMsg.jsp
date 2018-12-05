<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dch.HttpUrlService"%>
<%
	response.setCharacterEncoding("UTF-8");
	HttpUrlService hus = new HttpUrlService();
	Map<String,String> map = new HashMap<String,String>();
	String worldCupMsg = hus.doHttpUrlNet("http://10.0.5.217:8080/eth/theworldcup/findAllMatch", map, "GET");
	response.getWriter().print(worldCupMsg);
%>