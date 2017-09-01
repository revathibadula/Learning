
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">

    <title>Information Treasury</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script LANGUAGE="Javascript" SRC="Images/validate.js"></script>
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
			if(ChkMandatoryField(frm.UserID,'UserID')==false) return false;
			//if(ChkEmailField(frm.UserID,'UserID')==false) return false;
			if(ChkMandatoryField(frm.Password,'Password')==false) return false;
			//if(ChkAlphaNumericField(frm.Password,'Password')==false) return false;
			
		}
                function setPostion(){
                    w = screen.availWidth;
                    h = screen.availHeight;
                    Lframe.style.posLeft=w/4;
                    Lframe.style.posTop=h/5;
                    document.getElementById('UserId').focus();
                }
	</script>
  </head>
	<%! String ErrCode="0",LoginCode="A";%>
        
 	<Body onload="setPostion()">
	<FORM ACTION="Validate.jsp" method = "POST" onsubmit="return validate()">
	<%
		ErrCode = request.getParameter("ErrCode");
		LoginCode = request.getParameter("LoginCode");	
		if(ErrCode!=null){
			if(ErrCode.equals("1")){
			  %><script>alert("Login failed..please try again");</script><%
			}
		}
	%>
	<div id="Lframe" class="MainDiv">
             <center><img src="Images/IT.gif"/>
            
             <BR><BR><BR>
		<TABLE align=center>
			<TR class="row_title">
			  <TH align="center" colspan=3>Login</TH>
			</TR>
			<TR>
			  <TD align="left">User ID<FONT COLOR="red">*</TD>
			  <TD><Input type=text class='TextField Left' id='UserID' name='UserID' value=''  size=20></TD></tr>
			  <TR><TD align="left">Password<FONT COLOR="red">*</TD>
			  <TD><Input type=password name='Password'  class='TextField Left'  value='' size=20></TD>
			  <TR><TD colspan=2 align=center><INPUT TYPE="submit" value='Login'></TD></TR>
		</TABLE>
                 </center>
                 <BR><BR><BR>
                 <HR><HR>
        </div>
	
</FORM>
</BODY>
</html>
