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
        <LEGEND>Search Solution</LEGEND><BR><BR><BR><BR><BR><BR>
        <form name="SearchForm" action="SearchData.jsp" method="POST" onsubmit="return validate()">
            <table align=center  width="60%">
                <thead>
                    <tr class="row_title">
                        <th colspan=3>Search K-Database for solutions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                    <td width="60%">  <B>Search By </B> </td>
                    <td align=left>
                      
                       <input type="radio" name="SearchType" value="Author" />&nbsp;Author <BR>
                       <input type="radio" name="SearchType" value="Keywords" checked="checked" />&nbsp;Keywords <BR>
                       <input type="radio" name="SearchType" value="Technology" />&nbsp;Technology <BR>
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
