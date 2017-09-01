<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<%@ page import="java.util.Vector"%>
<jsp:include page="CheckSession.jsp"/> 
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
			if(ChkMandatoryField(frm.EmpNo,'EmpNo')==false) return false;
			if(ChkNumField(frm.EmpNo,'EmpNo')==false) return false;
			if(ChkMandatoryField(frm.Name,'Name')==false) return false;
			if(ChkAlphaField(frm.Name,'Name')==false) return false;
			if(ChkMandatoryField(frm.EmailId,'EmailId')==false) return false;
			//if(ChkEmailField(frm.EmailId,'EmailId')==false) return false;
			if(ChkMandatoryField(frm.ProjectCode,'ProjectCode')==false) return false;
			if(ChkMandatoryField(frm.ProjectManager,'ProjectManager')==false) return false;
			if(ChkEmailField(frm.ProjectManager,'ProjectManager')==false) return false;
			if(ChkMandatoryField(frm.StartDate,'StartDate')==false) return false;
			if(ChkDateField(frm.StartDate,'StartDate')==false) return false;
			if(ChkMandatoryField(frm.EndDate,'EndDate')==false) return false;
			if(ChkDateField(frm.EndDate,'EndDate')==false) return false;
			if(ChkMandatoryField(frm.CurrentLocation,'CurrentLocation')==false) return false;
			if(ChkAlphaField(frm.CurrentLocation,'CurrentLocation')==false) return false;
			if(ChkMandatoryField(frm.BaseLocation,'BaseLocation')==false) return false;
			if(ChkAlphaField(frm.BaseLocation,'BaseLocation')==false) return false;
			if(ChkMandatoryField(frm.JoiningDate,'JoiningDate')==false) return false;
			if(ChkDateField(frm.JoiningDate,'JoiningDate')==false) return false;
			if(ChkMandatoryField(frm.Role,'Role')==false) return false;
                        if(ChkMandatoryField(frm.Designation,'Designation')==false) return false;
			if(ChkAlphaField(frm.Role,'Role')==false) return false;
			if(ChkAlphaField(frm.Designation,'Designation')==false) return false;
		}
	</script>
	</HEAD>
        <BODY class=SC>
        <BR><BR><BR>
        <P align=center><B>Add Employee details</B></P>
        <%
        if(!(request.getMethod().equals("POST")))
        {%>
	<FORM ACTION=""  METHOD=POST onsubmit="return validate()">
	<TABLE align=center width="50%">
                <TR class="row_title">
				<TH align="center" colspan=2>Add Employee</TH>
		</TR>
		<TR class=row_odd>
				<TH align="left">EmpNo<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='EmpNo' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">Name<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='Name' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">EmailId<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='EmailId' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">ProjectCode<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='ProjectCode' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">ClientName</TH>
				<TD><Input class=TextField class=TextField type=text   name='ClientName' value='NA'></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">ProjectManager<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='ProjectManager' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">StartDate<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='StartDate' value=''><img onkeypress="fnCalendar(this)" id="imgDate" style="CURSOR: hand" onClick="fnCalendar(this)" height="16" src="Images/CalDis.gif" width="16" border="0" name="imgDate" onMouseOver="fnEnableCalLookup(this)" onMouseOut="fnDisableCalLookup(this)" ></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">EndDate<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='EndDate' value=''><img onkeypress="fnCalendar(this)" id="imgDate" style="CURSOR: hand" onClick="fnCalendar(this)" height="16" src="Images/CalDis.gif" width="16" border="0" name="imgDate" onMouseOver="fnEnableCalLookup(this)" onMouseOut="fnDisableCalLookup(this)" ></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">CurrentLocation<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='CurrentLocation' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">BaseLocation<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='BaseLocation' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">JoiningDate<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='JoiningDate' value=''><img onkeypress="fnCalendar(this)" id="imgDate" style="CURSOR: hand" onClick="fnCalendar(this)" height="16" src="Images/CalDis.gif" width="16" border="0" name="imgDate" onMouseOver="fnEnableCalLookup(this)" onMouseOut="fnDisableCalLookup(this)" ></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">Role<FONT COLOR="red">*</FONT></TH>
				<TD><Input class=TextField class=TextField type=text   name='Role' value=''></TD>
		</TR>
		<TR class=row_odd>
				<TH align="left">Designation</TH>
				<TD>
                                        <SELECT name=Designation  class="ListBox">
                                            <option value="TSE">Trainee Software Engineer</option>
                                            <option value="SE">Software Engineer</option>
                                            <option value="SSE">Sr Software Engineer</option>
                                            <option value="ANALYST">Analyst</option>
                                            <option value="ACON">Associate Consultant</option>
                                            <option value="CON">Consultant</option>
                                            <option value="PM">Project Manager</option>
                                            <option value="SPM">Sr Project Manager</option>
                                        </SELECT>
                                </TD>
           
		</TR>
		<TR class=row_odd><TH><INPUT TYPE="submit" value='Submit'></TH><TH><INPUT TYPE="reset" value='Clear'></TH></TR>
	</TABLE>
	<H6 align=center>Fields with <FONT SIZE="" COLOR="red">*</FONT> are mandatory </H6>
	</FORM>
	
<%}else{%>
<%

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	String EmpNo = request.getParameter("EmpNo");	
        String Name = request.getParameter("Name");	
        String EmailId = request.getParameter("EmailId");	
        String ProjectCode = request.getParameter("ProjectCode");	
        String ClientName = request.getParameter("ClientName");	
        String ProjectManager = request.getParameter("ProjectManager");	
        String StartDate = request.getParameter("StartDate");	
        String EndDate = request.getParameter("EndDate");	
        String CurrentLocation = request.getParameter("CurrentLocation");	
        String BaseLocation = request.getParameter("BaseLocation");	
        String JoiningDate = request.getParameter("JoiningDate");	
        String Role = request.getParameter("Role");	
        String Designation = request.getParameter("Designation");	
	try{
			
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
			stmt =  con.createStatement();
	
			
			String Query = "Insert into Masterdata (`EmpNo`,`Name`,`EmailId`,`ProjectCode`,`ClientName`,`ProjectManager`,`StartDate`,`EndDate`,`CurrentLocation`,`BaseLocation`,`JoiningDate`,`Role`,`Designation`) values("+EmpNo+",'"+Name+"','"+EmailId+"','"+ProjectCode+"','"+ClientName+"','"+ProjectManager+"','"+StartDate+"','"+EndDate+"','"+CurrentLocation+"','"+BaseLocation+"','"+JoiningDate+"','"+Role+"','"+Designation+"')";
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

