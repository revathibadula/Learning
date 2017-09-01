<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<%@ page import="com.KBank.MultipartRequest"%>
<%	
String KId = request.getParameter("KId");
String Location = application.getRealPath(request.getServletPath());
String dirpath = Location.substring(0,Location.lastIndexOf("\\"));
String FPath = dirpath+"\\Downloads\\";
%>
<HEAD>
	<script LANGUAGE="Javascript" SRC="validate.js"></script>
	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
     </HEAD>
<BODY class=SC>
<jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
<Fieldset class="custom">
            <LEGEND>Submit Solutions</LEGEND><BR><BR><BR><BR><BR><BR>
<%
		try{

			MultipartRequest multi = new MultipartRequest(request,FPath,5 * 1024 * 1024);
                        
                        Enumeration files = multi.getFileNames();
                        int iCnt = 0;
			while(files.hasMoreElements() ){
				String name = (String)files.nextElement();
				String filename = multi.getFilesystemName(name);
				String type = multi.getContentType(name);
                                System.out.println(name+"--"+(filename)+"--"+type+"--"+iCnt++);    
                                %>
                                <TABLE align=center width="50%">
                                <TR class=row_odd>
                                        <TH align=center colspan=2>Your solution has been successfully uploaded</TH>
                                </TR>
                                <TR class=row_odd>
                                        <TH align=center><a href="Submit.jsp">Submit Another..</a></TH>
                                </TR>
                                </TABLE>
                                    
                                <%
                                int result = com.KBank.MyFunctions.updateField("kbdata", "filename",filename, "where kid='"+KId+"'");
                                System.out.println(result+"[result]");
                        }
		}
		catch(IOException e){
			%>
			<pre>
			<script>
					window.alert('Error in Uploading. Please try again!');
			</script>	
			
			</PRE>
			<%
                        throw new Exception(e);
		}

%>
</Fieldset>    
</BODY>


