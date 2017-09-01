<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<HEAD>
    <script LANGUAGE="Javascript">
        function validate(){
            var frm = document.SearchForm;
            var Val = frm.SearchData.value;
            var typeObj = frm.SearchType;
            for(i=0;i<typeObj.length;i++){
                if(typeObj[i].checked == true){
                    type = typeObj[i].value;
                }
            }
            if(Val==""){
                alert("[DATA ERROR] \nPlease provide "+type+" to continue...");
                return false;
            }else{
                return true;
            }
            
        }
    </script>
    <LINK href="styles/styles.css" type="text/css" rel="stylesheet">
    
</HEAD>
<BODY class=Main>
    <jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
    <Fieldset class="custom">
        <LEGEND>Find Experts</LEGEND><BR><BR><BR><BR><BR><BR>
        <form name="SearchForm" action="ViewExperts.jsp" method="POST" onsubmit="return validate()">
            <table align=center  width="60%">
                <thead>
                    <tr class="row_title">
                        <th colspan=3>Find K-Database for Experts</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                    <td width="60%">  <B>Search By </B> </td>
                    <td align=left>
                      
                       <input type="radio" name="SearchType" value="EmailId" />&nbsp;Email Id <BR>
                       <input type="radio" name="SearchType" value="ExpertId" checked="checked" />&nbsp;Expert Id <BR>
                       <input type="radio" name="SearchType" value="PrimarySkills" />&nbsp;Primary Skills <BR>
                       <input type="radio" name="SearchType" value="SecondarySkills" />&nbsp;Secondary Skills <BR>
                    </td>
                    </tr>
                    <tr>
                    <td width="60%"><input type="text" name="SearchData" value="" class="TextField Left XtraLarge"/></td>
                    <td ><input type="submit" value="Search" name="SearchBtn" class="Bold Button Center"/></td>
                    </tr>
                </tbody>
            </table>
            <p class="Center Normal Italic">Note: Use comma &quot;,&quot; to seperate multiple words</p>
            <p class="Center Normal Italic">Note: Usage of  &quot;%&quot; as wildcard is allowed</p>
            
        </form>

    </FIELDSET>
</BODY>

