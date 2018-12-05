<%@page import="java.net.URLEncoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.*" %>
<%@ page import="com.dch.workflow.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	BaseBean bbbu = new BaseBean();
	FileUpload f_uu = new FileUpload(request);
	String jsonStr = Util.null2String((String) f_uu.getParameter("jsonStr"));
	HttpRequest httpRequest = new HttpRequest();
	String url = "http://10.0.5.218:8082/paidRead/insertArticle";
	try{
		String s = URLEncoder.encode(jsonStr,"utf-8");
		String result = httpRequest.sendPost(url, "param=" + s);
		out.println(result);
	}catch(Exception e){
		out.print("加密异常为:"+e.toString());
	}
%>