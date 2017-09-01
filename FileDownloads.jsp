<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.util.Enumeration"%>
<%@ page import="com.KBank.MultipartRequest"%>
<%	String AccessCodes = "FD"; %>

<BODY  Class=SC>
<%if(AccessCodes.indexOf("FD")>-1){%>
<%
/* Code for download */
String fileName=request.getParameter("fileName")==null ? "xyz.txt" :request.getParameter("fileName") ;
String fileType = fileName.substring(fileName.indexOf(".")+1,fileName.length());
System.out.println(fileType+"(****)"+fileName);
File file = new File(fileName);
response.setHeader("Content-Disposition","\"attachment;filename="+file.getName()+"\"");
response.setHeader("cache-control", "no-cache");
response.setHeader("cache-control", "must-revalidate");

if (fileType.trim().equalsIgnoreCase("txt"))
{
response.setContentType( "text/plain" );
}
else if (fileType.trim().equalsIgnoreCase("doc"))
{
response.setContentType( "application/msword" );
}
else if (fileType.trim().equalsIgnoreCase("xls"))
{
response.setContentType( "application/vnd.ms-excel" );
}
else if (fileType.trim().equalsIgnoreCase("pdf"))
{
response.setContentType( "application/pdf" );
}
else if (fileType.trim().equalsIgnoreCase("zip"))
{
response.setContentType( "application/zip" );
}
else if (fileType.trim().equalsIgnoreCase("ppt"))
{
response.setContentType( "application/vnd.ms-powerpoint" );
}

else
{
response.setContentType( "application/octet-stream" );
}


//byte[] fileBytes=dir.getFileBytes();
/*****/
// Returns the contents of the file in a byte array.
        InputStream is = new FileInputStream(file);
    
        // Get the size of the file
        long length = file.length();
    
        // You cannot create an array using a long type.
        // It needs to be an int type.
        // Before converting to an int type, check
        // to ensure that file is not larger than Integer.MAX_VALUE.
        if (length > Integer.MAX_VALUE) {
            // File is too large
        }
    
        // Create the byte array to hold the data
        byte[] bytes = new byte[(int)length];
    
        // Read in the bytes
        int offset = 0;
        int numRead = 0;
        while (offset < bytes.length
               && (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) {
            offset += numRead;
        }
    
        // Ensure all the bytes have been read in
        if (offset < bytes.length) {
            throw new IOException("Could not completely read file "+file.getName());
        }
    
        // Close the input stream and return bytes
        is.close();

/*****/
ServletOutputStream outs = response.getOutputStream();
outs.write(bytes);
outs.flush();
outs.close();
%>
<%
}
else{
	%><H5 align=center><IMG SRC="Images/error.gif" WIDTH="17" HEIGHT="13" BORDER=0 ALT="">You are not authorized to access this page.</H5><%
}
%>