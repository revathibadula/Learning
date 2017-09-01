<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%@ page errorPage="errorPage.jsp" %>


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
			if(ChkMandatoryField(frm.Name,'Name')==false) return false;
			if(ChkMandatoryField(frm.EmailId,'EmailId')==false) return false;
			if(ChkEmailField(frm.EmailId,'EmailId')==false) return false;
			if(ChkMandatoryField(frm.PrimarySkills,'PrimarySkills')==false) return false;
			if(ChkMandatoryField(frm.SecondarySkills,'SecondarySkills')==false) return false;
			if(ChkMandatoryField(frm.Experience,'Experience')==false) return false;
			if(ChkNumField(frm.Experience,'Experience')==false) return false;
			if(ChkMandatoryField(frm.CurrentProject,'CurrentProject')==false) return false;
			if(ChkMandatoryField(frm.PreviousProject,'PreviousProject')==false) return false;
		}
	</script>
	</HEAD>
        <BODY class=SC>
        <BR><BR><BR>
        <P align=center><B>Experts</B></P>
        <%
        if(!(request.getMethod().equals("POST")))
        {%>
	<FORM ACTION=""  METHOD=POST onsubmit="return validate()">
	<TABLE align=center width="50%">
</PRE><PRE>		<TR>
				<TH align="left">Name<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text name='Name' value=''></TD>
		</TR></PRE><PRE>		<TR>
				<TH align="left">EmailId<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text name='EmailId' value=''></TD>
		</TR></PRE><PRE>		<TR>
				<TH align="left">PrimarySkills<FONT COLOR="red">*</FONT></TH>
				<TD><textarea name=PrimarySkills></textarea></TD>
		</TR></PRE><PRE>		<TR>
				<TH align="left">SecondarySkills<FONT COLOR="red">*</FONT></TH>
				<TD><textarea name=SecondarySkills></textarea></TD>
		</TR></PRE><PRE>		<TR>
				<TH align="left">Experience<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text name='Experience' value=''></TD>
		</TR></PRE><PRE>		<TR>
				<TH align="left">CurrentProject<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text name='CurrentProject' value=''></TD>
		</TR></PRE><PRE>		<TR>
				<TH align="left">PreviousProject<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text name='PreviousProject' value=''></TD>
		</TR></PRE><PRE>		<TR><TH><INPUT TYPE="submit" value='Submit'></TH><TH><INPUT TYPE="reset" value='Clear'></TH></TR>
	</TABLE>
	<H6 align=center>Fields with <FONT SIZE="" COLOR="red">*</FONT> are mandatory </H6>
	</FORM>
	
<%}else{%>
<%

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	String Name = request.getParameter("Name");<BR>	String EmailId = request.getParameter("EmailId");<BR>	String PrimarySkills = request.getParameter("PrimarySkills");<BR>	String SecondarySkills = request.getParameter("SecondarySkills");<BR>	String Experience = request.getParameter("Experience");<BR>	String CurrentProject = request.getParameter("CurrentProject");<BR>	String PreviousProject = request.getParameter("PreviousProject");<BR>	
	try{
			
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
			stmt =  con.createStatement();
	
			
			String Query = "Insert into experts (`Name`,`EmailId`,`PrimarySkills`,`SecondarySkills`,`Experience`,`CurrentProject`,`PreviousProject`) values('"+Name+"','"+EmailId+"','"+PrimarySkills+"','"+SecondarySkills+"',"+Experience+",'"+CurrentProject+"','"+PreviousProject+"')";
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

</PRE>