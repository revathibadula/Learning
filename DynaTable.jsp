<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<HEAD>
	<script LANGUAGE="Javascript" SRC="validate.js"></script>
	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
</HEAD>
<BODY class=SC>
<BR><BR>
 <Fieldset class="custom">
            <LEGEND>My Settings</LEGEND><BR><BR><BR><BR><BR><BR>
             <% 
             String A[] = request.getParameterValues("FieldName");
             String B[] = request.getParameterValues("FieldType");
             String X = request.getParameter("FinalStr");
             System.out.println(X);
             for(int i=0;i<A.length;i++){
                 out.println(A[i]+"---"+B[i]);
             }
            %>
 </FIELDSET>
</BODY>
