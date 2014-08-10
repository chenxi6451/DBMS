<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%> 
<%@ page import="oracle.jdbc.pool.OracleDataSource"%> 


<!-- Database lookup --> 
<% 
 String stadiumid=request.getParameter("sid");
 String path = "images/stadium/"+stadiumid+".jpg";
 Connection conn = null; 
 ResultSet rset = null; 
 String error_msg = ""; 
 try { 
 OracleDataSource ods = new OracleDataSource(); 
 
 ods.setURL("jdbc:oracle:thin:jl4143/liujie@//w4111c.cs.columbia.edu:1521/ADB"); 
 conn = ods.getConnection(); 
 Statement stmt = conn.createStatement(); 
 rset = stmt.executeQuery("SELECT T.TID, S.SNAME AS SNAME, S.CITY AS CITY, S.CAPACITY AS CAPACITY, T.NAME AS TNAME FROM STADIUM S, TEAMS T WHERE S.SID=T.SID AND S.SID="+stadiumid); 

 } catch (SQLException e) { 
 error_msg = e.getMessage(); 
 if( conn != null ) { 
 conn.close(); 
 } 
 } 
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<link href="default.css" rel="stylesheet" type="text/css"/>
<title>Stadium Detail</title>
</head>
<body>
<!-- header -->
<div id="header">
	<h1 align="center">Clubs</h1>
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

 <h2>Stadium</h2>
 <TABLE> 
 <tr> 
 <td><h3>Name</h3></td><td><h3>Capacity</h3></td><td><h3>City</h3></td><td><h3>Team</h3></td>  
 </tr> 

<% 
 if(rset != null) { 
 while(rset.next()) {
	 String tid = rset.getString("tid");
	 %>
	 <tr><td style="width:200px"><%out.print(rset.getString("sname")); %></td>
	 <td style="width:200px"><%out.print(rset.getInt("capacity")); %></td>
	 <td style="width:200px"><%out.print(rset.getString("city")); %></td>
	 <td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset.getString("tname")); %> </a></td></tr>
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
 
  <h2>Stadium Scenery</h2>
 <img src=<%=path%> width="400" height="400" alt="No stadium photo" />
 
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
 