<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="weaver.conn.RecordSet"%>

<%@ page import="weaver.file.FileUpload"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="com.dch.HttpUrlService" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.io.*,java.util.*,weaver.monitor.cache.monitor.*,weaver.monitor.cache.Util.*,weaver.monitor.cache.*" %>
<jsp:useBean id="baseBean" class="weaver.general.BaseBean" scope="page"/>

<%
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	Date date = new Date();
	String dateStr = dateFormat.format(date);
    
	RecordSet recordSet = new RecordSet();
	try{
	String sql = "SELECT count(itcode) dangriqiandaorenshu FROM dowork WHERE do_date='"+dateStr+"'";
	recordSet.executeSql(sql);
	String dangriqiandaorenshu = "";
	if(recordSet.next()){
		dangriqiandaorenshu = Util.null2String(recordSet.getString("dangriqiandaorenshu"));
		out.print(dangriqiandaorenshu);
	}
	String updatetablecache = "dowork";
	CacheFactory sintance = CacheFactory.getInstance();
	String tkey = updatetablecache.trim().toLowerCase();
	String [] tables = new String[]{tkey};
	sintance.removeCache(tables);
	}catch(Exception e){
		baseBean.writeLog(e);
	}
 %>