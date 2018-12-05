<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu2 = new FileUpload(request);
	String account = Util.null2String((String) fu2.getParameter("account"));
	String typ = Util.null2String((String) fu2.getParameter("type"));
	
	HttpUrlService service2 = new HttpUrlService();
	String jsons = "";
	
	if(typ.equals("0")){
		jsons =  service2.doHttpUrlNet("http://10.0.5.217:8080/eth/findAll/"+account,null,"GET");
	}else if(typ.equals("1")){
		jsons =  service2.doHttpUrlNet("http://10.0.5.217:8080/eth/findByFromcount/"+account,null,"GET");
	}else if(typ.equals("2")){
		jsons =  service2.doHttpUrlNet("http://10.0.5.217:8080/eth/findByTocount/"+account,null,"GET");
	}
	
	out.print(jsons);
 %>
