<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%@ page errorPage="errorPage.jsp" %>


<%@ page import="java.util.Vector"%>

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
			if(ChkMandatoryField(frm.UserId,'UserId')==false) return false;
			if(ChkEmailField(frm.UserId,'UserId')==false) return false;
			if(ChkMandatoryField(frm.Password,'Password')==false) return false;
			if(ChkMandatoryField(frm.Auth,'Auth')==false) return false;
			if(ChkAlphaField(frm.Auth,'Auth')==false) return false;
		}
	</script>
	</HEAD>
        <BODY class=SC>
        <BR><BR><BR>
        <P align=center><B>Add User</B></P>
        <%
        if(!(request.getMethod().equals("POST")))
        {%>
	<FORM ACTION=""  METHOD=POST onsubmit="return validate()">
	<TABLE align=center width="50%">
                <TR class="row_title">
				<TH align="center" colspan=2>Add User</TH>
		</TR>
		<TR class=row_odd>
				<TH align="left">UserId<FONT COLOR="red">*</FONT></TH>
				<TD><Input class="TextField" type=text name='UserId' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">Password<FONT COLOR="red">*</FONT></TH>
				<TD><Input class="TextField" type=password name='Password' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">Authentication<FONT COLOR="red">*</FONT></TH>
				<TD><select name=Auth class="ListBox">
                                        <option value=Admin>Admin</option>
                                        <option value=KTeam>K-Team</option>
                                        <option value=Reviewer>Reviewer</option>
                                        <option value=KUser>K-User</option>
                                     </select></TD>
		</TR>
		<TR class=row_odd><TH><INPUT CLASS= "Button Center" TYPE="submit" value='Submit'></TH><TH><INPUT CLASS= "Button Center" TYPE="reset" value='Clear'></TH></TR>
	</TABLE>
	<H6 align=center>Fields with <FONT SIZE="" COLOR="red">*</FONT> are mandatory </H6>
	</FORM>
	
<%}else{%>
<%

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	String UserId = request.getParameter("UserId");	String Password = request.getParameter("Password");	String Auth = request.getParameter("Auth");	
	try{
			
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
			stmt =  con.createStatement();
	
			
			String Query = "Insert into login (`UserId`,`Password`,`Auth`) values('"+UserId+"','"+Password+"','"+Auth+"')";
			int result = stmt.executeUpdate(Query);
			if( result > 0)	{
				%><P align=center>Inserted into database sucessfully</P><%
			}
			else{
				%><P align=center>Error in updating..please try again</P><% 
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
<%
}	
%>

