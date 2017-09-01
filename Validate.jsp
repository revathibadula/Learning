<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*"%>
<%@ page isErrorPage="false" %>
<%@ page errorPage="errorPage.jsp" %>

<HEAD>
	<script LANGUAGE="Javascript" SRC="Images/validate.js"></script>
	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">

</HEAD>
<BODY class="SC">
<%

	Connection con=null;
	ResultSet rs=null,rs1=null;
	Statement stmt=null;
	String UserID = request.getParameter("UserID");	
	String Password = request.getParameter("Password");	

	int flag=0;
	try{
			
			con = com.KBank.ConnectionPool.getConnection();

			System.out.println("conn is: "+con);
			stmt =  con.createStatement();
			String Query = "select Auth from login where UserID = '"+UserID+"' and Password='"+Password+"'";
			System.out.println(Query);
                        rs = stmt.executeQuery(Query);
			if(rs.next())	
			{
                         String Auth = rs.getString(1);
                         System.out.println("Auth"+Auth);
  			 session.setAttribute("UserID",UserID);
			 session.setAttribute("Auth",Auth);
                         %>
                         <script>
                             window.location.href="Home.jsp";
                         </script>
                         <%
                         
	        	 flag=1;
                        }
			else{
                         %><script>
                             alert("Warning:Login failed...Please try again");
                             window.location.href="Login.jsp";
                         </script>
                         <%
                        }
			stmt.close();
			con.close();
		}catch(Exception e){
			stmt.close();
			con.close();
			throw new Exception(e);
		}
	
%>
</BODY>
