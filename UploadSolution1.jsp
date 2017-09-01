<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<%
String KId = request.getParameter("KId");
%>
<HEAD>
	<script LANGUAGE="Javascript" SRC="validate.js"></script>
	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
<SCRIPT LANGUAGE="JavaScript">
<!--
	function validate(){
		var V = document.forms(0).FilePath.value;
		if(V=="" || V==null){
			alert("Please select a file to upload...");
			return false;
		}else{
			//alert(window.opener.document.forms(0).PhotoPath.value+"--");
			window.opener.document.forms(0).PhotoPath.value = V;
			window.opener.document.getElementById('infodiv').innerHTML = "Attached successfully";
			window.opener.document.forms(0).FUBtn.disabled=true;
			return true;
			
		}

	}
	
//-->
</SCRIPT>
</head>
<BODY class=SC>
<jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
<Fieldset class="custom">
            <LEGEND>Submit Solutions</LEGEND><BR><BR><BR><BR><BR><BR>
<BR>
<Form action="UploadSolution2.jsp?KId=<%=KId%>" ENCTYPE="multipart/form-data" method=POST name="frmUpload" onsubmit="return validate();">
<Input type=hidden value="<%=KId%>" name='KId' class= "TextField">
<TABLE align=center width="50%">
	<TR class=row_title>
		<TH align=center colspan=2>Attach Document</TH>
		
	</TR>
	<TR class=row_odd>
		<TH align=left>File<FONT COLOR="red">*</FONT></TH>
		<TD align=center><Input type=file name='FilePath' class= "Left Large TextField">
                    <INPUT TYPE="submit" value='Attach' class="Button">
                </TD>
	</TR>
</TABLE>
</FORM>
</Fieldset>
</body>


