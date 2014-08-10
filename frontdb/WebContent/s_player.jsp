<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%> 
<%@ page import="oracle.jdbc.pool.OracleDataSource"%> 

<!-- Database lookup --> 
<% 
 Connection conn = null; 
 ResultSet rset = null;
 ResultSet rset1 = null;
 ResultSet rset2 = null;
 ResultSet rset3 = null;
 ResultSet rset4 = null;
 String error_msg = ""; 
 try { 
 OracleDataSource ods = new OracleDataSource(); 
 
 ods.setURL("jdbc:oracle:thin:jl4143/liujie@//w4111c.cs.columbia.edu:1521/ADB"); 
 conn = ods.getConnection(); 
 Statement stmt = conn.createStatement(); 
 Statement stmt1 = conn.createStatement(); 
 Statement stmt2 = conn.createStatement();
 Statement stmt3 = conn.createStatement(); 
 Statement stmt4 = conn.createStatement();
 rset = stmt.executeQuery("SELECT T.TID, T.NAME AS TN, P.PID,  P.GOAL, P.NAME AS PN FROM TEAMS T, PLAYERS P WHERE T.TID=P.TID AND P.GOAL>0 ORDER BY P.GOAL DESC"); 
 rset1 = stmt1.executeQuery("SELECT T.TID, T.NAME AS TN, P.PID, P.HEIGHT, P.NAME AS PN FROM TEAMS T, PLAYERS P WHERE T.TID=P.TID ORDER BY P.HEIGHT DESC"); 
 rset2 = stmt2.executeQuery("SELECT T.TID, T.NAME AS TN, P.PID, P.WEIGHT, P.NAME AS PN FROM TEAMS T, PLAYERS P WHERE T.TID=P.TID ORDER BY P.WEIGHT DESC"); 
 rset3 = stmt3.executeQuery("SELECT T.TID, T.NAME AS TN, P.PID, P.AGE, P.NAME AS PN FROM TEAMS T, PLAYERS P WHERE T.TID=P.TID ORDER BY P.AGE DESC"); 
 rset4 = stmt4.executeQuery("SELECT P.COUNTRY, COUNT(*) AS NUM_COUNTRY FROM PLAYERS P GROUP BY P.COUNTRY ORDER BY COUNT(*) DESC"); 
 } catch (SQLException e) { 
 error_msg = e.getMessage(); 
 if( conn != null ) { 
 conn.close(); 
 } 
 } 
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="default.css" rel="stylesheet" type="text/css"/>
<title>Statistics about Players</title>
</head>
<body>
<!-- header -->
<div id="header">
	<h1 align="center">Statistics</h1>
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

 <h2>Goal Ranking</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Name</h3></td><td><h3>Team</h3></td><td><h3>Goal</h3></td> 
 </tr> 
 
<% 
 if(rset != null) { 
	 int i = 0;
 while(rset.next()) {
	 String pid = rset.getString("pid");
	 String tid = rset.getString("tid");
	 %>
	 <tr><td style="width:200px"><a href="Players.jsp?pid=<%=pid%>"> 
	 <%out.print(rset.getString("pn")); %> </a></td>
	 <td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset.getString("tn")); %> </a></td>
	 <td style="width:200px"><%out.print(rset.getInt("goal")); %> </td></tr>
	 <%  
	 i = i + 1;
	 if(i >= 10)
		 break;
 } 
 } else { 
 out.print(error_msg); 
 } 
%>
</TABLE>

 <h2>Height Ranking</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Name</h3></td><td><h3>Team</h3></td><td><h3>Height</h3></td> 
 </tr> 
 
<% 
 if(rset1 != null) { 
	 int i = 0;
 while(rset1.next()) {
	 
	 String pid = rset1.getString("pid");
	 String tid = rset1.getString("tid");
	 %>
	 <tr><td style="width:200px"><a href="Players.jsp?pid=<%=pid%>"> 
	 <%out.print(rset1.getString("pn")); %> </a></td>
	 <td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset1.getString("tn")); %> </a></td>
	 <td style="width:200px"><%out.print(rset1.getInt("height")); %> </td></tr>
	 <% 
	 i = i + 1;
	 if(i >= 10)
		 break;
 } 
 } else { 
 out.print(error_msg); 
 } 
%>
</TABLE>

 <h2>Weight Ranking</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Name</h3></td><td><h3>Team</h3></td><td><h3>Weight</h3></td> 
 </tr> 
 
<% 
 if(rset2 != null) { 
	 int i = 0;
 while(rset2.next()) {
	 String pid = rset2.getString("pid");
	 String tid = rset2.getString("tid");
	 %>
	 <tr><td style="width:200px"><a href="Players.jsp?pid=<%=pid%>"> 
	 <%out.print(rset2.getString("pn")); %> </a></td>
	 <td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset2.getString("tn")); %> </a></td>
	 <td style="width:200px"><%out.print(rset2.getInt("weight")); %> </td></tr>
	 <%  
	 i = i + 1;
	 if(i >= 10)
		 break;
 } 
 } else { 
 out.print(error_msg); 
 } 
%>
</TABLE>

<h2>Age Ranking</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Name</h3></td><td><h3>Team</h3></td><td><h3>Age</h3></td> 
 </tr> 
 
<% 
 if(rset3 != null) { 
	 int i = 0;
 while(rset3.next()) {
	 String pid = rset3.getString("pid");
	 String tid = rset3.getString("tid");
	 %>
	 <tr><td style="width:200px"><a href="Players.jsp?pid=<%=pid%>"> 
	 <%out.print(rset3.getString("pn")); %> </a></td>
	 <td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset3.getString("tn")); %> </a></td>
	 <td style="width:200px"><%out.print(rset3.getInt("age")); %> </td></tr>
	 <%  
	 i = i + 1;
	 if(i >= 10)
		 break;
 } 
 } else { 
 out.print(error_msg); 
 } 
%>
</TABLE>

<h2>Player's Country Ranking</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Country</h3></td><td><h3>Number of Players</h3></td>
 </tr> 
 
<% 
 if(rset4 != null) { 
 while(rset4.next()) {
	 %>
	 <tr><td style="width:200px"><%out.print(rset4.getString("country")); %> </td>
	 <td style="width:200px"><%out.print(rset4.getInt("num_country")); %> </td></tr>
	 <%  
 } 
 } else { 
 out.print(error_msg); 
 } 
%>
  <%
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
           password:<input type="text" name="password" class="search"><br/>    
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

