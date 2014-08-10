<%@ page import="java.sql.*"%> 
<%@ page import="oracle.jdbc.pool.OracleDataSource"%> 
<%@ page import="javax.servlet.http.Cookie" %>


<!-- Database lookup --> 
<% 
 String input=request.getParameter("s");
 String type =request.getParameter("searchType");
 Connection conn = null; 
 ResultSet rset = null; 
 ResultSet rset1=null;
 ResultSet rset2=null;
 ResultSet rset3=null;
 ResultSet rset4=null;
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
 rset1 = stmt1.executeQuery("SELECT TID, NAME FROM TEAMS");
 rset2 = stmt2.executeQuery("SELECT PID, NAME FROM PLAYERS");
 rset3 = stmt3.executeQuery("SELECT BID, NAME FROM BOSS");
 rset4 = stmt4.executeQuery("SELECT SID, SNAME FROM STADIUM");
 } catch (SQLException e) { 
 error_msg = e.getMessage(); 

 } 
%> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<link href="default.css" rel="stylesheet" type="text/css"/>
<title>Search Results</title>
</head>

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
    <h2>Search Results</h2>
    
<% 
if(type.equals("team")){
	if(rset1 != null) {
	   while(rset1.next()) {
			//if(rset1.getString("name").equalsIgnoreCase(input)){
			 	
			 	String tname = (rset1.getString("name")).toLowerCase();
			 	if(tname.contains(input.toLowerCase())){
			 		String tid=rset1.getString("tid");%>
			 		<li><a href="clubpage.jsp?tid=<%=tid%>"> 
     				<%out.print(rset1.getString("name"));  %> </a></li>
     				<%
			 		
			 		//response.sendRedirect("clubpage.jsp?tid="+tid);
			 	}
			 	
		// }
 	} 
} 
}else if(type.equals("player")){
	 if(rset2 != null) {
		 while(rset2.next()) {
			 //if(rset2.getString("name").equalsIgnoreCase(input)){
			 	//String pid=rset2.getString("pid");
			 	//response.sendRedirect("Players.jsp?tid="+pid);
			 	String pname = (rset2.getString("name")).toLowerCase();
			 	if(pname.contains(input.toLowerCase())){
			 		String pid=rset2.getString("pid");%>
			 		<li><a href="Players.jsp?pid=<%=pid%>"> 
     				<%out.print(rset2.getString("name"));  %> </a></li>
     				<%
		   	}
		 }
	 } 
} else if(type.equals("boss")){
	 if(rset3 != null) {
		 while(rset3.next()) {
			 //if(rset3.getString("name").equalsIgnoreCase(input)){
			 	//String bid=rset3.getString("bid");
			 	//response.sendRedirect("boss.jsp?bid="+bid);
			String bname = (rset3.getString("name")).toLowerCase();
			 	if(bname.contains(input.toLowerCase())){
			 		String bid=rset3.getString("bid");%>
			 		<li><a href="boss.jsp?bid=<%=bid%>"> 
     				<%out.print(rset3.getString("name"));  %> </a></li>
     				<%
		   	}
		 }
	 } 	
} else if(type.equals("stadium")){
	 if(rset4 != null) {
		 while(rset4.next()) {
			 //if(rset4.getString("sname").equalsIgnoreCase(input)){
			 	//String sid=rset4.getString("sid");
			 	//response.sendRedirect("stadiumpage.jsp?sid="+sid);
			 String sname = (rset4.getString("sname")).toLowerCase();
			 	if(sname.contains(input.toLowerCase())){
			 		String sid=rset4.getString("sid");%>
			 		<li><a href="stadiumpage.jsp?sid=<%=sid%>"> 
     				<%out.print(rset4.getString("sname"));  %> </a></li>
     				<%
		   	}
		 }
	 } 
}

 if( conn != null ) { 
 conn.close(); 
 }
 

 %> 
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
 