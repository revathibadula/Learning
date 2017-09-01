<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.util.*"%>
<%
	/*Declaration of variables*/
	Connection con=null;
	Statement stmt=null;
	ResultSet rs=null;
	String Users[] = new String[100];
	String DynaString = "";
	try
	{
	con = com.KBank.ConnectionPool.getConnection();
	stmt =  con.createStatement();
	String SelQry = "select userid from login order by userid";
	rs = stmt.executeQuery(SelQry);
	
	int count=0;
		while(rs.next()){
			Users[count] = rs.getString(1);
			count++;
		}
		for(int i=0;i<count;i++){			
			DynaString += Users[i]+",";
		}
                DynaString = DynaString.substring(0,DynaString.lastIndexOf(","));
	}
	catch(Exception e)
	{
		%>Error:Please try again + <%=e%><%
	}
%>

<HTML>
<HEAD>
<link rel="STYLESHEET" type="text/css" href="styles.css">

<script LANGUAGE="Javascript" SRC="Images/calender.js"></script>
		<script LANGUAGE="Javascript" SRC="Images/validate.js"></script>
		<script LANGUAGE="Javascript" SRC="Images/AjaxCall.js"></script>

<SCRIPT>
function AddRow(){
    var a = "<%=DynaString%>";
	var b = a.split(",");
	document.body.insertAdjacentHTML('beforeEnd',"&nbsp;&nbsp;");
    var newObject = document.createElement("<INPUT TYPE='TEXT' NAME='FieldName' VALUE=''>")
    document.body.insertBefore(newObject);
	document.body.insertAdjacentHTML('beforeEnd',"&nbsp;");
	oSelect = document.createElement("<SELECT Name='FieldType' Id='FieldType'>")
	document.body.insertBefore(oSelect);
         for(i=0;i<b.length;i++){
             var oOption = document.createElement("OPTION");
             oSelect.options.add(oOption);
             oOption.innerText = b[i];
             oOption.value = b[i];
	 }
	/*var oOption = document.createElement("OPTION");
	oSelect.options.add(oOption);
	oOption.innerText = "String";
	oOption.value = "varchar";
	oOption = document.createElement("OPTION");
	oSelect.options.add(oOption);
	oOption.innerText = "Integer";
	oOption.value = "integer";
	oOption = document.createElement("OPTION");
	oSelect.options.add(oOption);
	oOption.innerText = "Decimal";
	oOption.value = "float";
	oOption = document.createElement("OPTION");
	oSelect.options.add(oOption);
	oOption.innerText = "Date";
	oOption.value = "date";*/
	document.body.insertAdjacentHTML('beforeEnd',"<BR>");
}
function ChkMandatoryField(F,T){
			var val= F.value;
			if(val==""){alert("Asset Name is mandatory");return false;}
		}
function Save(){
	//validate();
	var FNStr = "";
	var FTStr = "";
	var SFlag = true;
	Category = document.forms(0).Category.value;
	Description = document.forms(0).Description.innerText;
	var FN = document.getElementsByName("FieldName");
	var FT = document.getElementsByName("FieldType");
	if(FN.length!=null){
		for(i=0;i<FN.length;i++){
			if(FN[i].value==null || FN[i].value=="" || FT[i].value==null || FT[i].value==""){
				SFlag = false;
				alert("Field Name & Type are mandatory");
				return false;
				break;
			}
			if(FN[i].value=="Sno" || FN[i].value=="Status"){
				SFlag = false;
				alert("Field Name & Type are already exists");
				return false;
				break;
			}
			FNStr+=FN[i].value+"^"+FT[i].value+"~";
		}
	}
	document.getElementById("FinalStr").value=FNStr;
	url = "DynaTable.jsp?FinalStr="+FNStr+"&Category="+Category+"&Description="+Description;
	document.forms(0).action = url;
         alert(url);
	if(SFlag==true){
		document.forms(0).submit();
	}else{
		document.forms(0).action="";
		return false;
	}
	/*
	for(i=0;i<FT.length;i++){
		FTStr+=FT[i].value;
	}
	alert(FTStr);*/
}
function validate()
{
var frm = document.forms(0);
	if(ChkMandatoryField(frm.Category,'Category')==false) return false;
				var divObj = document.getElementById("nameid");
				var Msg = divObj.innerHTML;
				if(Msg.indexOf("not available")>-1){
					alert("Asset name not available. Please choose another");
					frm.Category.value="";
				}
}
function fnCallChkAvailability(U)
	{
		var Category = U.value;
		var divObj = document.getElementById("nameid");
		URL = "ChkAssetName.jsp?Category="+Category;
		//ajaxFunction(URL,divObj);
	}
</SCRIPT>
</HEAD>

<BODY Class='Log'>
<!-- <OBJECT id=dlgHelper CLASSID="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" width="0px" height="0px"></OBJECT> -->
<HR>
<B><FONT COLOR="#B70226" face='verdana'>Define Assest Type</FONT></B>
<HR>
<INPUT TYPE="hidden" NAME="FinalStr" size='40'>

<FORM METHOD='POST'  OnSubmit="return validate()">
<TABLE width="40%" Id="MyTable">
<TR class="row_title">
	<TD colspan=3 align=center><B><CENTER>Define Assest Type</CENTER></B></TD>
</TR>

<TR class="row_even">
	<TD><B>Asset Name <FONT COLOR="red">*</FONT></B></TD>
	<TD><Input type=text class='TextField' name='Category' value='' onchange='fnCallChkAvailability(this)'>
	<div id='nameid'></div>
	<TD rowspan=2><INPUT TYPE="BUTTON"  onclick="Save()" VALUE="Save Data">
</TD>
</TR>
<TR class="row_even">
	<TD><B>Description </B></TD>
	<TD><TEXTAREA NAME="Description" ROWS="10" COLS="20" value=''></TEXTAREA></TD>
</TR>
<TR class="row_even">
	<TD><B>Field Name <FONT COLOR="red">*</FONT></B></TD>
	<TD><B>Field Type <FONT COLOR="red">*</FONT></B></TD>
	<TD><INPUT TYPE="BUTTON" ONCLICK="AddRow()" VALUE="Add Fields"></TD>
</TR>
<TR>
	<TD>&nbsp;<INPUT TYPE='TEXT' NAME='FieldName' VALUE=''></TD>
	<TD colspan=2><SELECT Name='FieldType' Id='FieldType'>
		<OPTION value='varchar'>String</OPTION>
		<OPTION value='integer'>Integer</OPTION>
		<OPTION value='float'>Decimal</OPTION>
		<OPTION value='date'>Date</OPTION>
	</SELECT>
	</TD>
</TR>
	
	
	
<!--		
	<INPUT TYPE="BUTTON" onclick="var val = dlgHelper.ChooseColorDlg(); this.value=val.toString(16);" value='choosecolor'><BR><BR>
-->
</FORM>
<BODY>
</HTML>

