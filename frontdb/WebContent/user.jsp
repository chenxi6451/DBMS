<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%> 
<%@ page import="oracle.jdbc.pool.OracleDataSource"%> 
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" >
<link href="default.css" rel="stylesheet" type="text/css"/>
<title>Users</title>
</head>


<!-- Database lookup --> 
<% 

 String user=null;
 String pass=null;
 Connection conn = null; 
 ResultSet rset = null; 
 ResultSet rset2=null;
 ResultSet rset3=null;
 ResultSet rset4=null;
 int flag=0;
 String error_msg = ""; 
 try { 
 OracleDataSource ods = new OracleDataSource(); 
 
 ods.setURL("jdbc:oracle:thin:jl4143/liujie@//w4111c.cs.columbia.edu:1521/ADB"); 
 conn = ods.getConnection(); 
 Statement stmt = conn.createStatement();
 Statement stmt2 = conn.createStatement();
 Statement stmt3 = conn.createStatement();
if( session.getAttribute("username") != null ){
	flag=1;%>
	<b>Hi,<%= session.getAttribute("username")%></b>
	
<%
user=session.getAttribute("username").toString();
}
else if(session.getAttribute("username")==null){
	
	
	user=request.getParameter("username");
	pass=request.getParameter("password");
 rset = stmt.executeQuery("SELECT *FROM USERS WHERE USERNAME='"+user+"' AND PASSWORD='"+pass+"'");
 if(rset.next()) { 
 
	if((rset.getString("username").equals(user))&&(rset.getString("password").equals(pass))){
		 session.setAttribute("username",user);
         response.sendRedirect("index.jsp");
		 //out.print("<b>Hi,"+user+"</b>");
		 
		 flag=1;
		 
	 
 } 
 } else { 
 out.print(error_msg); 
 }
}
 if(flag==1){
	 rset2=stmt2.executeQuery("SELECT T.TID,T.NAME FROM TEAMS T,FOLLOWT FT WHERE T.TID=FT.TID AND FT.USERNAME='"+user+"'");
	 rset3=stmt3.executeQuery("SELECT P.PID,P.NAME FROM PLAYERS P,FOLLOWP FP WHERE P.PID=FP.PID AND FP.USERNAME='"+user+"'");
 }
 else if(flag==0){
	 out.print("wrong");
	 response.sendRedirect("index.jsp");
 }
 
 } catch (SQLException e) { 
 error_msg = e.getMessage(); 
 //if( conn != null ) { 
 //conn.close(); 
 //} 
 } 

%> 
<body>
<!-- header -->
<div id="header">
	<h1 align="center">Welcome!</h1>
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
                <h2>Following Teams</h2>
                 <TABLE> 
                 <%
                if(rset2 != null) { 
                	while(rset2.next()) {
                		String tid = rset2.getString("tid"); 
                		
                	%>
                	<tr><td style="width:100px"><a href="clubpage.jsp?tid=<%=tid%>"> 
                    <%out.print(rset2.getString("name")); %></a><blockquote><a href="follow.jsp?username=<%=user%>&tid=<%=rset2.getString("tid") %>">Unfollow</a></blockquote></td> 
                    <%}
                	} else { 
                		out.print(error_msg); 
                		}
                	%> 
 </TABLE>
              
         
                <h2>Following Players</h2>
                <TABLE> 
 <%
                if(rset3 != null) { 
                	while(rset3.next()) {
                		String pid = rset3.getString("pid");
                	%>
                	<tr><td style="width:100px"><a href="Players.jsp?pid=<%=pid%>"> 
                    <%out.print(rset3.getString("name"));  %></a><blockquote><a href="follow1.jsp?username=<%=user%>&pid=<%=rset3.getString("pid")%>">Unfollow</a></blockquote></td> 
                    <%}
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
//String user=null;
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
 