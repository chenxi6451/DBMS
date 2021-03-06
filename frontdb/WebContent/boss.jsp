<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%> 
<%@ page import="oracle.jdbc.pool.OracleDataSource"%> 

<!-- Database lookup --> 
<% 
 String bossid=request.getParameter("bid");
 String path = "images/boss/"+bossid+".jpg";
 Connection conn = null; 
 ResultSet rset = null; 
 String error_msg = ""; 
 try { 
 OracleDataSource ods = new OracleDataSource(); 
 
 ods.setURL("jdbc:oracle:thin:jl4143/liujie@//w4111c.cs.columbia.edu:1521/ADB"); 
 conn = ods.getConnection(); 
 Statement stmt = conn.createStatement(); 
 rset = stmt.executeQuery("SELECT T.TID, T.NAME AS TN, B.NAME AS BN, B.AGE, B.COUNTRY FROM BOSS B, TEAMS T WHERE B.BID=T.BID AND B.BID="+bossid); 
 } catch (SQLException e) { 
 error_msg = e.getMessage(); 

 } 
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="default.css" rel="stylesheet" type="text/css"/>
<title>Boss</title>
</head>

<body>
<!-- header -->
<div id="header">
	<h1 align="center">Boss</h1>
	</div>
	<!--end header --> 
	<div id="menu">
        <ul>
        <li><a href="index.jsp">home</a></li>
        <li><a href="Clubs.jsp">Team</a></li>
        <li><a href="stadium.jsp">Stadium</a></li>
        <li><a href="Statistics.jsp">Statistics</a></li>
        <li><a href="user.jsp">Your Follows</a></li>
        </ul>
    </div>
<div id="content">
    <div id="left">
    
	<h2>Portrait</h2>
    <img src=<%=path%> width="200" height="200" alt="No boss photo" />
    
    <h2>Teams</h2>
    <TABLE>
    <tr>
     <td><h3>NAME</h3></td><td><h3>AGE</h3></td><td><h3>COUNTRY</h3></td><td><h3>TEAM OWNNING</h3></td> </tr>

 
  <% 
 if(rset != null) { 
 while(rset.next()) {
	 String tid=rset.getString("tid");
	 %>
	 <tr><td><%out.print(rset.getString("bn"));%> </td>
	 <td><%out.print(rset.getInt("age"));%> </td>
	 <td><%out.print(rset.getString("country"));%> </td>
     <td><a href="clubpage.jsp?tid=<%=tid%>"> 
     <%out.print(rset.getString("tn"));  %> </a></td></tr>
<%
 } 
 } else { 
 out.print(error_msg); 
 } 
 if( conn != null ) { 
 conn.close(); 
 } 
 %>
 
</TABLE>
    </div>
  <div id="right">
    <h2>Login</h2>
<%
String user=null;
//Cookie[] cookies = null;
// Get an array of Cookies associated with this domain
//cookies = request.getCookies();
//out.print(cookies);
if( session.getAttribute("username") != null ){
%><b>Hi,<%=session.getAttribute("username")%></b>
	<br>
	
	<a href="logout.jsp">logout</a>
	<%    
	}else{
	   //out.println("<h2>No cookies founds</h2>");

%>
 <form action="user.jsp" method="get">  
    
           username:<input type="text" name="username" class="search"><br/>  
           password:<input type="password" name="password" class="search"><br/>  
   <input type="submit" value="submit" class="search"/>
  </form>  
<% } //}%>
<h2>Search</h2>
        <form id="searchform" method="get" action="search.jsp" style="margin-top: 0; margin-bottom: 0;">
           
            <input id="searchquery" type="text" size="25" name="s" value="" class="search"/>
            <select name="searchType">  
        		<option value="team">Team</option>  
        		<option value="player">Player</option>  
        		<option value="boss">Boss</option>    
        		<option value="stadium">Stadium</option>  
   			</select><br/> 
            <input id="searchsubmit" type="submit" value="Search" class="search"/>
      
         </form>
     </div>
     </div>
    
  

</body> 
</html>
 