<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.io.*,java.util.*,weaver.monitor.cache.monitor.*,weaver.monitor.cache.Util.*,weaver.monitor.cache.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	FileUpload fu3 = new FileUpload(request);
	String itcode1 = Util.null2String((String) fu3.getParameter("itcode1"));
	
	RecordSet re_Set = new RecordSet();
	String timer = "";
	re_Set.executeSql("select * from uf_turncount where turnhash is not null and fromitcode='"+itcode1+"' and turndate=(select max(turndate) from uf_turncount where fromitcode='"+itcode1+"')");
	
	 String updatetablecache = "uf_turncount";
    CacheFactory sintance = CacheFactory.getInstance();
    String tkey = updatetablecache.trim().toLowerCase();
    String [] tables = new String[]{tkey};
    sintance.removeCache(tables);
	
	BaseBean base_Bean = new BaseBean();
	base_Bean.writeLog("验证能否转账的sql为:"+"select * from uf_turncount where turnhash is not null and fromitcode='"+itcode1+"' and turndate=(select max(turndate) from uf_turncount where fromitcode='"+itcode1+"')");
	if(re_Set.next()){
		timer = Util.null2String(re_Set.getString("timer"));
	}else{
		out.print("1");
		return;
	}
	if(timer.equals("2")){
		out.print("1");
	}else{
		out.print("上笔交易写入中,请稍后");
	}
	
 %>
