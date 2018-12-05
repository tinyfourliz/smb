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
	FileUpload fu49 = new FileUpload(request);
	String machineid = Util.null2String((String) fu49.getParameter("machineid"));
	String it_code1 = Util.null2String((String) fu49.getParameter("itcode"));
	Map<String,String> sdata=new HashMap<String,String>();
	sdata.put("machineid",machineid);
	sdata.put("itcode",it_code1);

	String root="http://10.7.10.124:8080/vm/apply";
	// BaseBean bb=new BaseBean();
	// bb.writelog
	HttpUrlService service44 = new HttpUrlService();

	String result = service44.doHttpUrlNet(root, sdata,"GET");
	out.print(result);
%>
