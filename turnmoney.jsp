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
	BaseBean bbb = new BaseBean();
	FileUpload f_u = new FileUpload(request);
	String fromaccount = Util.null2String((String) f_u.getParameter("fromaccount"));
	String toaccount = Util.null2String((String) f_u.getParameter("toaccount"));
	String money = Util.null2String((String) f_u.getParameter("money"));
	String remark = Util.null2String((String) f_u.getParameter("remark"));
	String fromitcode = Util.null2String((String) f_u.getParameter("fromitcode"));
	String toitcode = Util.null2String((String) f_u.getParameter("toitcode"));
	HttpUrlService httpService = new HttpUrlService();
	String url = "http://10.0.5.217:8080/eth/transition/";
	String data = fromaccount+"-"+toaccount+"-"+remark+"-"+money+"-"+fromitcode+"-"+toitcode;
	String string = "";
	try{
		String s = URLEncoder.encode(data,"utf-8");
		Encrypt encrypt = new EncryptImpl();
		String ecUrl = encrypt.encrypt(s);
		bbb.writeLog(fromitcode+"转账信息为:"+url+ecUrl);
		string =  httpService.doHttpUrlNet(url+ecUrl,null, "GET");
	}catch(Exception e){
		bbb.writeLog(fromitcode+"转账数据加密异常为:"+e.toString());
	}
	bbb.writeLog("转账的hash值为:"+string);
	out.print(url+data);
%>