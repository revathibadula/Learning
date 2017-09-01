<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<HEAD>
	<script LANGUAGE="Javascript" SRC="validate.js"></script>
	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
</HEAD>
<BODY class=SC>
<jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
<Fieldset class="custom">
            <LEGEND>View Experts</LEGEND><BR><BR><BR><BR><BR><BR>
<%          String SearchType = request.getParameter("SearchType");
            String SearchData = request.getParameter("SearchData");
            String Query = "Select * from experts where ";
            String[] SearchDataArr = null;
            if (SearchData != null || SearchData.indexOf(",") != -1) {
                SearchDataArr = SearchData.split(",");
            }
            System.out.println("LENGTH : " + SearchDataArr.length);
            if (SearchDataArr.length <= 1) {
                Query += " `" + SearchType + "` Like '%" + SearchData + "%' ";
            } else {
                for (int i = 0; i < SearchDataArr.length; i++) {
                    Query += " `" + SearchType + "` Like '%" + SearchDataArr[i] + "%' or";
                }
                Query = Query.substring(0, Query.lastIndexOf("or"));
            }
        System.out.println("[Expert Query]"+Query);
        Query = Query+" order by expertid ";
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	try{
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
                        stmt =  con.createStatement();
			//String Query = "Select * from experts order by `expertid`";
			rs = stmt.executeQuery(Query);
			%>
						<table align="center" width="90%">
							<tr class=row_title>
                                                             <th align="left">Expert Id</th><th align="left">Name</th><th align="left">Email Id</th><th align="left">Primary Skills</th><th align="left">Secondary Skills</th><th align="left">Experience</th><th align="left">Current Project</th><th align="left">Previous Project</th><th>Phone Number</th>
							</tr>
					<%
			int rCount=0;
			while(rs.next())
			{
                            String EmailId = rs.getString(3);
					%>
					<tr class= '<%=(rCount%2!=0)? "row_even" : "row_odd"%>'>
						<td><%=rs.getString(1)%></td>
                                                 <td><%=rs.getString(2)%></td>
                                                 <td><%=EmailId%></td>
                                                 <td><%=rs.getString(4)%></td>
                                                 <td><%=rs.getString(5)%></td>
                                                 <td><%=rs.getString(6)%></td>
                                                 <td><%=rs.getString(7)%></td>
                                                 <td><%=rs.getString(8)%></td>
                                                 <td><%=rs.getString(9)%></td>
					</tr>
					<%
				rCount++;
			}
			if( rCount == 0)	{%><tr class= "row_even"><td colspan=8>No match found...Please refine your search criteria</td></tr><% }
			rs.close();
			stmt.close();
			con.close();
		}catch(Exception e){
			//rs.close();
			stmt.close();
			con.close();
			throw new Exception(e);
		}
	
%>
</table>
<table align=center width="90%">
            <tr>
                <td align=center><input type=Button class="Button" value="Back" onclick="location.replace('FindExperts.jsp')"></td>
            </tr>
        </table>
</Fieldset>
</BODY>
