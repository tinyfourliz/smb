<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%@ page import="com.dch.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	BaseBean bbbu = new BaseBean();
	FileUpload f_uu = new FileUpload(request);
	String jsonStr = Util.null2String((String) f_uu.getParameter("jsonStr"));
	HttpUrlService httpService = new HttpUrlService();
	String url = "http://10.0.5.218:8082/ethAccount/chargeConfirm?param=";
	try{
		String s = URLEncoder.encode(jsonStr,"utf-8");
		Encrypt encrypt = new EncryptImpl();
		String ecUrl = encrypt.encrypt(s);
		String result = httpService.doHttpUrlNet(url+ecUrl,null, "GET");
		out.print(result);
	}catch(Exception e){
		out.print("加密异常为:"+e.toString());
		//bbbu.writeLog("加密异常为:"+e.toString());
	}
	// out.print(url + jsonStr);
%>