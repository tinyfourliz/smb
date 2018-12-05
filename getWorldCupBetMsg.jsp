<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dch.HttpUrlService"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.file.FileUpload"%>
<%
	response.setCharacterEncoding("UTF-8");
	FileUpload fu9 = new FileUpload(request);
	String it_code = Util.null2String((String) fu9.getParameter("itcode"));
	String match_id = Util.null2String((String) fu9.getParameter("matchid"));

	HttpUrlService hus = new HttpUrlService();
	Map<String,String> map = new HashMap<String,String>();
	String worldCupMsg = hus.doHttpUrlNet("http://10.0.5.217:8080/eth/theworldcup/findBet/" + match_id + "/" + it_code, map, "GET");
	response.getWriter().print(worldCupMsg);
%>