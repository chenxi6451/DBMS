<%@ page language="java" contentType="text/html; ccharset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%> 
<%@ page import="oracle.jdbc.pool.OracleDataSource"%> 
<!-- Database lookup --> 
<% 
session.invalidate();
response.sendRedirect("index.jsp");
%> 
