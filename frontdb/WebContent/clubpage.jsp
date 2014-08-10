<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%> 
<%@ page import="oracle.jdbc.pool.OracleDataSource"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Database lookup --> 
<% 
 String teamid=request.getParameter("tid");
 String path = "images/team/"+teamid+".png";
 Connection conn = null; 
 ResultSet rset = null; 
 ResultSet rset2=null;
 ResultSet rset3=null;
 ResultSet rset4=null;
 ResultSet rset5=null;
 ResultSet rset6=null;
 String error_msg = ""; 
 try { 
 OracleDataSource ods = new OracleDataSource(); 
 
 ods.setURL("jdbc:oracle:thin:jl4143/liujie@//w4111c.cs.columbia.edu:1521/ADB"); 
 conn = ods.getConnection(); 
 Statement stmt = conn.createStatement(); 
 Statement stmt2=conn.createStatement();
 Statement stmt3=conn.createStatement();
 Statement stmt4=conn.createStatement();
 Statement stmt5=conn.createStatement();
 Statement stmt6=conn.createStatement();
 rset = stmt.executeQuery("SELECT S.SID, B.BID, T.NAME,T.NICKNAME,B.NAME AS BNAME,T.COACH,T.CITY,S.SNAME FROM TEAMS T,STADIUM S,BOSS B WHERE S.SID=T.SID AND B.BID=T.BID AND T.TID="+teamid); 
 rset2=stmt2.executeQuery("SELECT T1.TID AS HTID, T2.TID AS GTID, T1.NAME AS HNAME,T2.NAME AS GNAME,M.MDATE,M.WEATHER,M.GUEST_SCORE,M.HOME_SCORE FROM TEAMS T1, TEAMS T2, MATCH_WITH M WHERE M.HOME_TID=T1.TID AND M.GUEST_TID=T2.TID AND (T1.TID="+teamid+" OR T2.TID="+teamid+")");
 rset3=stmt3.executeQuery("SELECT P.JERSEYNUMBER, P.NAME, P.PID FROM PLAYERS P,GOALKEEPER G WHERE P.PID=G.PID AND P.TID="+teamid+"ORDER BY P.JERSEYNUMBER");
 rset4=stmt4.executeQuery("SELECT P.JERSEYNUMBER, P.NAME, P.PID FROM PLAYERS P,ATTACKER A WHERE P.PID=A.PID AND P.TID="+teamid+"ORDER BY P.JERSEYNUMBER");
 rset5=stmt5.executeQuery("SELECT P.JERSEYNUMBER, P.NAME, P.PID FROM PLAYERS P,MIDDLEFIELD M WHERE P.PID=M.PID AND P.TID="+teamid+"ORDER BY P.JERSEYNUMBER");
 rset6=stmt6.executeQuery("SELECT P.JERSEYNUMBER, P.NAME, P.PID FROM PLAYERS P,DEFENDER D WHERE P.PID=D.PID AND P.TID="+teamid+"ORDER BY P.JERSEYNUMBER");
 } catch (SQLException e) { 
 error_msg = e.getMessage(); 
 if( conn != null ) { 
 conn.close(); 
 } 
 } 
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" >
<link rel="stylesheet" type="text/css" href="<c:url value="/default.css"/>" />
<title>Teams detail</title>
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
    
    <h2>Team Logo</h2>
    <img src=<%=path%> width="130" height="130" alt="No team logo photo" />
    
    <h2>Team Information</h2>

				<TABLE> 
				
				<tr> 
				<td><h3>Name</h3></td><td><h3>NICKNAME</h3></td><td><h3>BOSS</h3></td><td><h3>CITY</h3></td><td><h3>COACH</h3></td><td><h3>STADIUM</h3></td> 
				</tr> 
  <%
			  if(rset != null) { 
			  	while(rset.next()) {
			  		String sid = rset.getString("sid");
			  		String bid = rset.getString("bid");
			  	%>
			  	<tr><td style="width:150px">
			      <%out.print(rset.getString("name"));  %></td> 
			      <td style="width:150px">
			      <%out.print(rset.getString("nickname"));  %></td> 
			      <td style="width:150px"><a href="boss.jsp?bid=<%=bid%>"> 
					<%out.print(rset.getString("bname")); %> </a></td> 
			      <td style="width:150px">
			      <%out.print(rset.getString("city"));  %></td> 
			      <td style="width:150px">
			      <%out.print(rset.getString("coach"));  %></td> 
			      <td style="width:150px"><a href="stadiumpage.jsp?sid=<%=sid%>"> 
					<%out.print(rset.getString("sname")); %> </a></td>
			      <%}
			  	} else { 
			  		out.print(error_msg); 
			  		}
                	%> 
                </TABLE>
                  <h2>Match</h2>
				<TABLE> 
				<tr> 
				<td><h3>DATE</h3></td><td><h3>HOMETEAM</h3></td><td><h3>GUESTTEAM</h3></td><td><h3>SCORE</h3></td><td><h3>WEATHER</h3></td> 
				</tr> 
                <%
                if(rset2 != null) { 
                	while(rset2.next()) {
                		String htid = rset2.getString("htid");
                		String gtid = rset2.getString("gtid");
                	%>
                	<tr><td style="width:150px">
                    <%out.print(rset2.getDate("mdate"));  %></td> 
                    <td style="width:150px"><a href="clubpage.jsp?tid=<%=htid%>"> 
	 				<%out.print(rset2.getString("hname")); %> </a></td>
                    <td style="width:150px"><a href="clubpage.jsp?tid=<%=gtid%>"> 
	 				<%out.print(rset2.getString("gname")); %> </a></td>
                    <td style="width:150px">
                    <%out.print(rset2.getString("home_score")+":"+rset2.getString("guest_score"));  %></td> 
                    <td style="width:150px">
                    <%out.print(rset2.getString("weather"));  %></td> 
                    <%}
                	} else { 
                		out.print(error_msg); 
                		}
                	%> 
                </TABLE>
			</div>
			<div id="right">
			    <h2>Player</h2>
			    <TABLE> 
				<tr> 
				<td><h3>Goalkeepers</h3></td>
				</tr> 
	            <tr> 
                <td>-------------------</td>
                </tr> 
               
                <%
                String pid=null;
                if(rset3 != null) { 
                	while(rset3.next()) {
                		pid=rset3.getString("pid");
                	%>
                	<tr><td style="width:150px"><%out.print(rset3.getInt("jerseynumber")+". "); %>
                	<a href="Players.jsp?pid=<%=pid%>">
                    <%out.print(rset3.getString("name"));  %></a>
                    <%if(session.getAttribute("username")!=null){
                    %><blockquote><a href="follow3.jsp?username=<%=session.getAttribute("username")%>&pid=<%=pid%>">Follow</a></blockquote></td> 
                    <%
                    }}
                	} else { 
                		out.print(error_msg); 
                		}
                
                	%> 
                </TABLE>
			
			 <TABLE> 
				<tr> 
				<td><h3>Defenders</h3></td>
				</tr>
	            <tr> 
                <td>-------------------</td>
                </tr>  
                <%
                if(rset6 != null) { 
                	while(rset6.next()) {
                		pid=rset6.getString("pid");
                	%>
                	<tr><td style="width:150px"><%out.print(rset6.getInt("jerseynumber")+". "); %>
                	<a href="Players.jsp?pid=<%=pid%>">
                    <%out.print(rset6.getString("name"));  %></a>
                    <%if(session.getAttribute("username")!=null){
                    %><blockquote><a href="follow3.jsp?username=<%=session.getAttribute("username")%>&pid=<%=pid%>">Follow</a></blockquote></td> 
                    <%}
                    }
                	} else { 
                		out.print(error_msg); 
                		}
                	%> 
                </TABLE>
			
			    
			    <TABLE> 
				<tr> 
				<td><h3>Middlefields</h3></td>
				</tr> 
			    <tr> 
                <td>-------------------</td>
                </tr> 
                <%
                if(rset5 != null) { 
                	while(rset5.next()) {
                		pid=rset5.getString("pid");
                	%>
                	<tr><td style="width:150px"><%out.print(rset5.getInt("jerseynumber")+". "); %>
                	<a href="Players.jsp?pid=<%=pid%>">
                    <%out.print(rset5.getString("name"));  %></a>
                    <%if(session.getAttribute("username")!=null){
                    %><blockquote><a href="follow3.jsp?username=<%=session.getAttribute("username")%>&pid=<%=pid%>">Follow</a></blockquote></td> 
                    <%}
                    }
                	} else { 
                		out.print(error_msg); 
                		}
                	%> 
                </TABLE>

<TABLE> 
				<tr> 
				<td><h3>Attackers</h3></td>
				</tr> 
	            <tr> 
                <td>-------------------</td>
                </tr> 
                <%
                if(rset4 != null) { 
                	while(rset4.next()) {
                		pid=rset4.getString("pid");
                	%>
                	<tr><td style="width:150px"><%out.print(rset4.getInt("jerseynumber")+". "); %>
                	<a href="Players.jsp?pid=<%=pid%>">
                    <%out.print(rset4.getString("name"));  %></a>
                    <%if(session.getAttribute("username")!=null){
                    %><blockquote><a href="follow3.jsp?username=<%=session.getAttribute("username")%>&pid=<%=pid%>">Follow</a></blockquote>
                    </td> 
                    <%}
                    }
                	} else { 
                		out.print(error_msg); 
                		}
                	if(conn != null ) { 
                		conn.close(); 
                		} 
                	%> 
                </TABLE>
			   
			
		</div>
		</div>
		

	
</body>
</html>