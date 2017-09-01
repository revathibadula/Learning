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
			//if(ChkEmailField(frm.EmailId,'EmailId')==false) return false;
			if(ChkMandatoryField(frm.PrimarySkills,'PrimarySkills')==false) return false;
			if(ChkMandatoryField(frm.SecondarySkills,'SecondarySkills')==false) return false;
			if(ChkMandatoryField(frm.Experience,'Experience')==false) return false;
			if(ChkNumField(frm.Experience,'Experience')==false) return false;
			if(ChkMandatoryField(frm.CurrentProject,'CurrentProject')==false) return false;
			if(ChkMandatoryField(frm.PreviousProject,'PreviousProject')==false) return false;
		}
	</script>
</HEAD>
<BODY class=Main>
<jsp:include page="CheckSession.jsp"/>  
<BR><BR>
 <Fieldset class="custom">
            <LEGEND>Register As Expert</LEGEND><BR><BR><BR><BR><BR><BR>
        <%
        if(!(request.getMethod().equals("POST")))
        {%>
	<FORM ACTION=""  METHOD=POST onsubmit="return validate()">
	<TABLE align=center width="60%">
                <TR class=row_title>
				<TH colspan=2 align=center>Register as Expert</TH>
		</TR>
		<TR>
				<TH align="left">Name<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text class="TextField Large Left"  name='Name' value=''></TD>
		</TR>		<TR>
				<TH align="left">EmailId<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text class="TextField Large Left"  name='EmailId' value=''></TD>
		</TR>		<TR>
				<TH align="left">PrimarySkills<FONT COLOR="red">*</FONT></TH>
				<TD><textarea name=PrimarySkills  class="TextField Large Left" ></textarea> ( Comma seperated values )</TD>
		</TR>		<TR>
				<TH align="left">SecondarySkills<FONT COLOR="red">*</FONT></TH>
				<TD><textarea name=SecondarySkills  class="TextField Large Left" ></textarea> ( Comma seperated values )</TD>
		</TR>		<TR>
				<TH align="left">Experience<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text class="TextField Large Left"  name='Experience' value=''> ( In Months )</TD>
		</TR>		<TR>
				<TH align="left">Current Project<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text class="TextField Large Left"  name='CurrentProject' value=''></TD>
		</TR>		<TR>
				<TH align="left">Previous Project<FONT COLOR="red">*</FONT></TH>
				<TD><Input type=text class="TextField Large Left"  name='PreviousProject' value=''></TD>
		</TR>           <TR>
				<TH align="left">Phone Number</TH>
				<TD><Input type=text class="TextField Large Left"  name='PhoneNumber' value='0'></TD>
		</TR>
                <TR><TH><INPUT TYPE="submit" value='Submit' class=Button></TH><TH><INPUT TYPE="reset" value='Clear' class=Button></TH></TR>
	</TABLE>
	<H6 align=center>Fields with <FONT SIZE="" COLOR="red">*</FONT> are mandatory </H6>
	</FORM>
	
<%}else{%>
<%

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	String Name = request.getParameter("Name");	
        String EmailId = request.getParameter("EmailId");
        String PrimarySkills = request.getParameter("PrimarySkills");
        String SecondarySkills = request.getParameter("SecondarySkills");
        String Experience = request.getParameter("Experience");
        String CurrentProject = request.getParameter("CurrentProject");
        String PreviousProject = request.getParameter("PreviousProject");
        String PhoneNumber = request.getParameter("PhoneNumber");
	String ExpertId = com.KBank.MyFunctions.genNextID("Experts", "ExpertId", "EX0");
        try{
			
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
			stmt =  con.createStatement();
                        String Eid = com.KBank.MyFunctions.getField("experts", "ExpertId", "where EmailId = '"+EmailId+"'");
			if(Eid==null || Eid.equalsIgnoreCase("NA")==true)
                        {
                            String Query = "Insert into experts (`ExpertId`,`Name`,`EmailId`,`PrimarySkills`,`SecondarySkills`,`Experience`,`CurrentProject`,`PreviousProject`,`PhoneNumber`) values('"+ExpertId+"','"+Name+"','"+EmailId+"','"+PrimarySkills+"','"+SecondarySkills+"',"+Experience+",'"+CurrentProject+"','"+PreviousProject+"','"+PhoneNumber+"')";
                            int result = stmt.executeUpdate(Query);
                            if( result > 0)	{
%><P align=center>Your registration is successful. Your registration id is <font color=green><%=ExpertId%></font></P><%
                            }
                            else{
                                    %>
                                        <P align=center>
                                            Error in updating your details...please try again <BR>
                                            <a href="RegisterAsExpert.jsp">Back</a>
                                        </P>
                                     <% 
                            }  
                        }
                        else{
                          
                                     %>
                                        <P align=center style="color:red">
                                            [ERROR]: You are already registerd as an expert. You are not allowed to register again.<BR>
                                            <a href="RegisterAsExpert.jsp">Back</a>
                                        </P>
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

 </FIELDSET>
</BODY>
<%
}	
%>
