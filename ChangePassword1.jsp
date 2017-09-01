<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random"%>
<%@ page errorPage="errorPage.jsp" %>
<jsp:include page="CheckSession.jsp"/>  
<%
String UserID=(String)session.getAttribute("UserID");
        if(UserID == null || UserID.trim().equals("")) {
            session.invalidate();
            %>
            <script language=javascript>
		window.opener = top; window.opener.location.replace("sessiontimeout.jsp");
            </script>
            <% 
        }
System.out.println("UserID"+UserID);
%>
<HEAD>
	<script LANGUAGE="Javascript" SRC="Images/validate.js"></script>
	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
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
			if(ChkMandatoryField(frm.UserID,'UserID')==false) return false;
			if(ChkEmailField(frm.UserID,'UserID')==false) return false;
			if(ChkMandatoryField(frm.Password,'Old Password')==false) return false;
			if(ChkAlphaNumericField(frm.Password,'Old Password')==false) return false;
                        if(ChkMandatoryField(frm.newPassword,'New Password')==false) return false;
			if(ChkAlphaNumericField(frm.newPassword,'New Password')==false) return false;
			
		}
	</script>
</head>
<body Class="SC">

<center>

<BR><BR><br>




<FONT size="2" color="blue" FACE="Tahoma">

<FORM NAME="LOGIN" ACTION="ChangePassword.jsp" METHOD="POST" onsubmit="return validate()">


<TABLE align=center width="50%">
<TR class=row_title ALIGN="center">
	   <TH COLSPAN="2"> Enter new Password</TH>
</TR>

<TR class=row_even>
	<TD>User Id</TD>
	<TD><input TYPE=text name=UserID size="8" value="<%=UserID%>" readonly  class="TextField Medium"></TD>
</TR>
<TR class=row_odd>
	<TD>Old Password</TD>
	<TD><input TYPE=password name=Password  class="TextField Medium"></TD>
</TR>
<TR class=row_even>
	<TD>New Password </TD>
	<TD><input TYPE=password name=newPassword class="TextField Medium"></TD>
</TR>
<TR class=row_odd>
	<TD><INPUT TYPE=submit name=submit value="Submit" class=Button>
</TD>
	<TD><INPUT TYPE=reset name=resett value="Reset"  class=Button> 
</TD>
</TR>
</TABLE>
<br><br>
</FORM>

</BODY>




