<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.dch.dues.DuesBean"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="weaver.file.multipart.Part"%>
<%@page import="javax.servlet.http.*" %>
<%@page import="weaver.file.FileUpload"%>
<%@page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%@page import="weaver.general.Util"%>
<%
           request.setCharacterEncoding("UTF-8");
             FileUpload fu = new FileUpload(request);	
	User user = HrmUserVarify.getUser(request, response);
	String code = user.getLoginid();
               String usetime =Util.null2String(fu.getParameter("usetime").trim());
                  String os =Util.null2String(fu.getParameter("os").trim());
                  
                  String memory =Util.null2String(fu.getParameter("memory").trim());
                  String cpu =Util.null2String(fu.getParameter("cpu").trim());
                  String harddisk =Util.null2String(fu.getParameter("harddisk").trim());
               String email=user.getEmail();

           String hasnet =Util.null2String(fu.getParameter("hasnet").trim());
                  
              HttpUrlService service3 = new HttpUrlService();
	String status =  service3.doHttpUrlNet("http://10.7.10.124:8080/vm/apply?usetime="+usetime+"&itcode="+code+"&os="
	+os+"&memory="+memory+"&cpu="+cpu+"&harddisk="+harddisk+"&email="+email+"&hasnet="+hasnet,null,"GET");
              out.print(status);
	
 %>
