<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu91 = new FileUpload(request);
	String it_code = Util.null2String((String) fu91.getParameter("itcode"));
	HttpUrlService service31 = new HttpUrlService();
	String status =  service31.doHttpUrlNet("http://10.0.5.217:8080/eth/casino/test/checkStatus/"+it_code,null,"GET");

	if(status.equals("error")){
		out.print("error");
	}else{
		out.print(status);
	}
 %>
