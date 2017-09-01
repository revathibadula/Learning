<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
 
<%
            String KId = request.getParameter("KId");
 
%>
<HEAD>
    <script LANGUAGE="Javascript" SRC="Images/AjaxCall.js"></script>
    <LINK href="styles/styles.css" type="text/css" rel="stylesheet">
    <script>
        function validate(){
           
            var frm = document.forms(0);
            var KID = frm.KID.value;
            var UserRating = frm.UserRating.value;
            var flag=false;
            URL = "RateAction.jsp?KID="+KID+"&UserRating="+UserRating;
            frm.action = URL;
            frm.method = "POST";
            frm.submit();
            
        }
        
    </script>
</HEAD>
<BODY class=Main>
    <jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
    <Fieldset class="custom">
        <LEGEND>Rate Submission</LEGEND><BR>
        <FORM Action="" name="EForm">
        <table align=center width="40%">
            <thead>
                <tr class="row_title">
                    <th colspan=2>Submissions</th>
                </tr>
                <tr class=row_title>
                    
                <th>K-Id</th>
                <th>User Rating</th>
            </tr>
            <tr class=row_odd>
                <td><input type="hidden" name="KID" value="<%=KId%>"> <%=KId%></td>
                <th><select name="UserRating" class="ListBox">
                        <option value=0>0</option>
                        <option value=1>1</option><option value=2>2</option><option value=3>3</option>
                        <option value=4>4</option><option value=5>5</option><option value=6>6</option>
                        <option value=7>7</option><option value=8>8</option><option value=9>9</option>
                        <option value=10>10</option>
                </select></th>
            </tr>
            <tr>
                <td align=center colspan=2><input type="button" class="Button" value="Rate" onclick="validate()"><input type="Reset" class="Button" value="Reset"></td>
            <tr>
        </table>
    </FORM>
    </FIELDSET>
</BODY>
