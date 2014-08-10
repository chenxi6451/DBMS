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
 String error_msg = ""; 
 try { 
 OracleDataSource ods = new OracleDataSource(); 
 
 ods.setURL("jdbc:oracle:thin:jl4143/liujie@//w4111c.cs.columbia.edu:1521/ADB"); 
 conn = ods.getConnection(); 
 Statement stmt = conn.createStatement();
 Statement stmt1 = conn.createStatement();
 Statement stmt2 = conn.createStatement();
 Statement stmt3 = conn.createStatement();
 rset = stmt.executeQuery("SELECT T.TID, T.NAME, T.GOAL FROM TEAMS T ORDER BY T.GOAL DESC");
 rset1 = stmt1.executeQuery("SELECT T.TID, T.NAME, T.LOST FROM TEAMS T ORDER BY T.LOST");
 rset2 = stmt2.executeQuery("SELECT T.TID, T.NAME, T.GOAL_DIFFERENCE FROM TEAMS T ORDER BY T.GOAL_DIFFERENCE DESC"); 
 rset3 = stmt3.executeQuery("SELECT T.TID, T.NAME, T.MATCH_NUM, T.WIN_NUM, T.DRAW_NUM, T.LOST_NUM, T.POINTS, T.GOAL, T.LOST, T.GOAL_DIFFERENCE FROM TEAMS T ORDER BY T.POINTS DESC, T.GOAL_DIFFERENCE DESC, T.GOAL DESC"); 
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
<title>Statistics about teams</title>
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

 <h2>League Table</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Position</h3></td><td><h3>Team</h3></td><td><h3>Match</h3></td><td><h3>Win</h3></td>
 <td><h3>Draw</h3></td><td><h3>Lose</h3></td><td><h3>Goal</h3></td><td><h3>Lost</h3></td>
 <td><h3>Goal Difference</h3></td><td><h3>Points</h3></td> 
 </tr> 

<% 
 if(rset3 != null) {
	 int i = 0;
 while(rset3.next()) { 
	 String tid = rset3.getString("tid");
	 i = i + 1;
	 %>
	 <tr><td style="width:200px"><%out.print(i); %></td>
	 <td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset3.getString("name")); %> </a></td>
	 <td style="width:200px"><%out.print(rset3.getInt("match_num")); %></td>
	 <td style="width:200px"><%out.print(rset3.getInt("win_num")); %></td>
	 <td style="width:200px"><%out.print(rset3.getInt("draw_num")); %></td>
	 <td style="width:200px"><%out.print(rset3.getInt("lost_num")); %></td>
	 <td style="width:200px"><%out.print(rset3.getInt("goal")); %></td>
	 <td style="width:200px"><%out.print(rset3.getInt("lost")); %></td>
	 <td style="width:200px"><%out.print(rset3.getInt("goal_difference")); %> </td>
	 <td style="width:200px"><%out.print(rset3.getInt("points")); %></td></tr>
	<% 
 } 
 } else { 
 out.print(error_msg); 
 } 

 %> 
 </TABLE>

 <h2>Team Goal Ranking</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Team</h3></td><td><h3>Goal</h3></td> 
 </tr> 
 
<% 
 if(rset != null) { 
 while(rset.next()) {
	 String tid = rset.getString("tid");
	 %>
	 <tr><td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset.getString("name")); %> </a></td>
	 <td style="width:200px"><%out.print(rset.getInt("goal")); %> </td></tr>
	<%  
 } 
 } else { 
 out.print(error_msg); 
 } 
 %> 
 </TABLE>

<h2>Team Lost Ranking</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Team</h3></td><td><h3>Lost</h3></td> 
 </tr> 
  
<% 
 if(rset1 != null) { 
 while(rset1.next()) { 
	 String tid = rset1.getString("tid");
	 %>
	 <tr><td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset1.getString("name")); %> </a></td>
	 <td style="width:200px"><%out.print(rset1.getInt("lost")); %> </td></tr>
	<%  
 } 
 } else { 
 out.print(error_msg); 
 } 
%>
</TABLE>

 
 
  <h2>Team Goal Difference</h2> 
 <TABLE> 
 <tr> 
 <td><h3>Team</h3></td><td><h3>Goal Difference</h3></td> 
 </tr> 

<% 
 if(rset2 != null) { 
 while(rset2.next()) { 
	 String tid = rset2.getString("tid");
	 %>
	 <tr><td style="width:200px"><a href="clubpage.jsp?tid=<%=tid%>"> 
	 <%out.print(rset2.getString("name")); %> </a></td>
	 <td style="width:200px"><%out.print(rset2.getInt("goal_difference")); %> </td></tr>
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
 