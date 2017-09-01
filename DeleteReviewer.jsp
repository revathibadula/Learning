<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%@ page errorPage="errorPage.jsp" %>


<%@ page import="java.util.Vector"%>

<HEAD>


	<script LANGUAGE="Javascript" SRC="validate.js"></script>


	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">

</HEAD>
<BODY class=SC>
<BR><BR><jsp:include page="CheckSession.jsp"/>  
<BR><BR>
 <Fieldset class="custom">
            <LEGEND>Delete Reviewer</LEGEND><BR><BR><BR><BR><BR><BR>
<%
if(!(request.getMethod().equals("POST")))
{

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	String Condition = "EmailId";
	String[] ConValues = new String[2000];
	int ConCount=0,i=0;
	String Query1="";
%>
<FORM Name='DelForm' METHOD=POST ACTION="">
		<TABLE align=center width="25%" bordercolor=#D8D8D8 border=1>
		<TR>
		<TH class='row_title' colspan=2>Delete EmailId</TH>
		</TR>
                <TR>
			<TH><%=Condition.replace('`',' ').toUpperCase()%></TH>
			<TD><SELECT NAME="<%=Condition%>" class="ListBox">
			<OPTION Value="">Select</OPTION>

<%
	try{
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
			stmt =  con.createStatement();

			if(Condition.trim().equalsIgnoreCase("undefined")){
				System.out.println("in if");
				Query1 = "Select * from reviewerdetails";
			}
			else{
				System.out.println("in else");
				Query1 = "Select "+Condition+" from reviewerdetails group by "+Condition;
			}
			String str="";
			System.out.println(Query1);
			rs = stmt.executeQuery(Query1);
			int rCount=0;
				while(rs.next()){
					String x = rs.getString(1);
					ConValues[i]=x;
					%><OPTION Value=<%=ConValues[i]%>><%=ConValues[i]%></OPTION><%
					i++;
				}
			stmt.close();
			con.close();
		}catch(Exception e){
			stmt.close();
			con.close();
			throw new Exception(e);
		}
%>
		</SELECT></TD>
		</TR>
		<TR><TD align=center Colspan=2><Input type='Submit' name='submit' value='Delete' Class="Button"></TD></TR>
		</TABLE>
</FORM>
<H6 align=center> Select Reviewer </H6>
<%}else{%>
<%
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	String Value = request.getParameter("EmailId");
	try{
                        
                        con = com.KBank.ConnectionPool.getConnection();
                        			stmt =  con.createStatement();
	
			
			String Query = "Delete from reviewerdetails where EmailId='"+Value+"'";
			int result = stmt.executeUpdate(Query);
			if( result > 0)	{
				%><P align=center>
                                     <B style="color:green">Reviewer deleted sucessfully</B>
                                     <BR><A href="DeleteReviewer.jsp">Delete another</A>
                                  </P><%
			}
			else{
				%><P align=center><B style="color:red">Error in deletion..please try again</B>
                                     <BR><A href="DeleteReviewer.jsp" >Try again</A></P><% 
			}
			stmt.close();
			con.close();
		}catch(Exception e){
			stmt.close();
			con.close();
			throw new Exception(e);
		}
}
%>
</FieldSet>
</BODY>
