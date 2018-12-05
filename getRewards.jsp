<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu3 = new FileUpload(request);
	String it_code = Util.null2String((String) fu3.getParameter("itcode"));
	String reward = Util.null2String((String) fu3.getParameter("reward"));
	HttpUrlService service3 = new HttpUrlService();

	service3.doHttpUrlNet("http://10.0.5.217:8080/eth/signinReward/"+it_code + "/" +reward,null,"GET");
 %>
