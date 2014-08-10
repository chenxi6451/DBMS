<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%> 
<%@ page import="oracle.jdbc.pool.OracleDataSource"%> 
<!-- Database lookup --> 
<% 
 String user=request.getParameter("username");

String teamid=request.getParameter("tid");
 Connection conn = null; 
 ResultSet rset = null; 
 String error_msg = ""; 
 try { 
 OracleDataSource ods = new OracleDataSource(); 
 ods.setURL("jdbc:oracle:thin:jl4143/liujie@//w4111c.cs.columbia.edu:1521/ADB"); 
 conn = ods.getConnection(); 
 Statement stmt = conn.createStatement(); 
 //follow team

	 stmt.executeUpdate("INSERT INTO FOLLOWT (TID,USERNAME) VALUES ('"+teamid+"','"+user+"')");
 
//response.sendRedirect("user.jsp");
 } catch (SQLException e) { 
 error_msg = e.getMessage(); 
if( conn != null ) { 
 conn.close(); 
 } 
 } 
 response.sendRedirect("user.jsp");
%> 