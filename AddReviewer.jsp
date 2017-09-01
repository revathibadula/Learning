<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%@ page errorPage="errorPage.jsp" %>


<%@ page import="java.util.Vector"%>
<%!

	Connection con=null;
	ResultSet rs=null;
	ResultSet rs2=null;
	Statement stmt=null;
	Statement stmt2=null;
	String ss=null;
	%>
    <HEAD>

    <script LANGUAGE="Javascript" SRC="validate.js"></script>

    <LINK href="styles/styles.css" type="text/css" rel="stylesheet">
    <script LANGUAGE="Javascript" SRC="Images/calender.js"></script>
    <script LANGUAGE="Javascript" >
		function ChkMandatoryField(F,T){
			var val= F.value;
			if(val==""){alert(T+" is mandatory");return false;}
		}
		function ChkNumField(F,T){
			var val = F.value;
			if(isNaN(val)==true||val==""){alert("Please enter numbers for "+T);return false;}
		}
		function ChkAlphaNumericField(F,T){
			var val = F.value;
			var pattern = /^([a-zA-Z0-9]{1,250})$/;
			if(!(pattern.test(val)==true)){alert("Please enter alphabets or numbers for "+T);return false;}
		}
		function ChkAlphaField(F,T){
			var val = F.value;
			var pattern = /^([a-zA-Z ]{1,250})$/;
			if(!(pattern.test(val)==true)){alert("Please enter text for "+T);return false;}
		}
		function ChkEmailField(F,T){
			var val = F.value;
			var pattern = /^([a-zA-Z0-9\_\.]{4,25})$/;
			if(!(pattern.test(val)==true)){alert("Please enter valid email for "+T);return false;}
		}
		function ChkDateField(F,T)
		{
			var val = F.value;
		    var pattern = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
		    if(!(pattern.test(val)==true)){alert("Please enter valid date format (yyyy-mm-dd) for "+T);return false;}
		}
		function validate()
		{
			var frm = document.forms(0);
			//if(ChkMandatoryField(frm.Name,'Name')==false) return false;
			if(ChkMandatoryField(frm.EmailId,'EmailId')==false) return false;
			//if(ChkEmailField(frm.EmailId,'EmailId')==false) return false;
			if(ChkMandatoryField(frm.Skillset,'Skillset')==false) return false;
			if(ChkMandatoryField(frm.Experience,'Experience')==false) return false;
			if(ChkNumField(frm.Experience,'Experience')==false) return false;
		}
	</script>
	</HEAD>
        <BODY class=SC>
        <BR><BR><jsp:include page="CheckSession.jsp"/>  
        <BR><BR>
         <Fieldset class="custom">
                    <LEGEND>Add Reviewer</LEGEND><BR><BR><BR><BR><BR><BR>
       
        <%
        if(!(request.getMethod().equals("POST")))
        {%>
	<FORM ACTION=""  METHOD=POST onsubmit="return validate()">
	<TABLE align=center width="50%">
                <TR class=row_title>
				<TD colspan=2 align=center>Add Reviewer</TD>
		</TR>
				<TR>
				<TH align="left">Name<FONT COLOR="red">*</FONT></TH>
				<TD>
				<select name = "Name">
				<%
				try{
			
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
						stmt =  con.createStatement();
				        stmt2 =  con.createStatement();
						String Qry = "select 	UserId from kb.login where auth = 'Reviewer' and  UserId not in (select name from reviewerdetails)";


						rs2=stmt2.executeQuery(Qry);
						
						while(rs2.next())
						{
							ss=rs2.getString(1);
		
				 %>
				
				
				
				<option><%=ss%></option>
				
				<%} 
				
				}//try
				catch(Exception e)
				{
					e.printStackTrace();
				}
				%>
				</select>
				<!--  <Input type=text class="Left TextField Large" name='Name' value=''> --></TD>
		</TR>		<TR>
				<TH align="left">EmailId<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text class="Left TextField Large" name='EmailId' value=''></TD>
		</TR>		<TR>
				<TH align="left">Skillset<FONT COLOR="red">*</FONT></TH>
				<TD><textarea name=Skillset class="Left TextField Large" ></textarea></TD>
		</TR>		<TR>
				<TH align="left">Experience<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text class="Left TextField Large" name='Experience' value=''> (in months)</TD>
		</TR>		<TR><TH><INPUT TYPE="submit" value='Submit'class="Button"></TH><TH><INPUT TYPE="reset" value='Clear'class="Button"></TH></TR>
	</TABLE>
	<H6 align=center>Fields with <FONT SIZE="" COLOR="red">*</FONT> are mandatory </H6>
	</FORM>
	
<%}else{%>

	<%
	String Name = request.getParameter("Name");	String EmailId = request.getParameter("EmailId");	String Skillset = request.getParameter("Skillset");	String Experience = request.getParameter("Experience");	
	String ReviewerId = com.KBank.MyFunctions.genNextID("reviewerdetails","ReviewerId","R0" );
        try{
			
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
			stmt =  con.createStatement();
	      stmt2 =  con.createStatement();
			String Query2 = "select 	UserId from kb.login where auth = 'Reviewer' and  UserId not in (select name from reviewerdetails)";
			String Query = "Insert into reviewerdetails (`ReviewerId`,`Name`,`EmailId`,`Skillset`,`Experience`) values('"+ReviewerId+"','"+Name+"','"+EmailId+"','"+Skillset+"',"+Experience+")";
			rs2=stmt2.executeQuery(Query2);
			
			while(rs2.next())
				ss=rs2.getString(1);
			
			int result = stmt.executeUpdate(Query);
			if( result > 0)	{
				%>
                                 <P align=center>
                                     <font color=green> Reviewer details updated sucessfully<BR></font>
                                     <A href="AddReviewer.jsp">Add another...</A>
                                 </P><%
			}
			else{
                         %><P align=center><font color=red> Error in updating..please try again</font>
                                 <BR><A href="AddReviewer.jsp">Try again...</A>
                                 </P><% 
			}
			stmt.close();
			con.close();
		}catch(Exception e){
			stmt.close();
			con.close();
			throw new Exception(e);
		}
%>
</FieldSet>
</BODY>
<%
}	
%>
