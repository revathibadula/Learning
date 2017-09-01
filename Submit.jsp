<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<HEAD>
    <script LANGUAGE="Javascript" SRC="validate.js"></script>
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
            if(ChkMandatoryField(frm.Title,'Title')==false) return false;
            if(ChkMandatoryField(frm.Author,'Author')==false) return false;
            //if(ChkEmailField(frm.Author,'Author')==false) return false;
            if(ChkMandatoryField(frm.DateOfCreation,'DateOfCreation')==false) return false;
            if(ChkDateField(frm.DateOfCreation,'DateOfCreation')==false) return false;
            if(ChkMandatoryField(frm.DateOfSubmission,'DateOfSubmission')==false) return false;
            if(ChkDateField(frm.DateOfSubmission,'DateOfSubmission')==false) return false;
            if(ChkMandatoryField(frm.Keywords,'Keywords')==false) return false;
            if(ChkMandatoryField(frm.Technology,'Technology')==false) return false;
            if(ChkMandatoryField(frm.Reference,'Reference')==false) return false;
            if(ChkMandatoryField(frm.Description,'Description')==false) return false;
            if(ChkMandatoryField(frm.ContentType,'ContentType')==false) return false;
            if(ChkMandatoryField(frm.TargetUsers,'TargetUsers')==false) return false;
            /*if(ChkDateField(frm.PublishedOn,'PublishedOn')==false) return false;
            if(ChkMandatoryField(frm.Status,'Status')==false) return false;
            if(ChkMandatoryField(frm.Remarks,'Remarks')==false) return false;
            if(ChkMandatoryField(frm.KTeamRating,'KTeamRating')==false) return false;
            if(ChkNumField(frm.KTeamRating,'KTeamRating')==false) return false;
            if(ChkMandatoryField(frm.ReviewerId,'ReviewerId')==false) return false;
            if(ChkEmailField(frm.ReviewerId,'ReviewerId')==false) return false;
            if(ChkMandatoryField(frm.ReviewerRating,'ReviewerRating')==false) return false;
            if(ChkNumField(frm.ReviewerRating,'ReviewerRating')==false) return false;
            if(ChkMandatoryField(frm.NoOfHits,'NoOfHits')==false) return false;
            if(ChkNumField(frm.NoOfHits,'NoOfHits')==false) return false;
            if(ChkMandatoryField(frm.FileName,'FileName')==false) return false;
            if(ChkAlphaNumericField(frm.FileName,'FileName')==false) return false;*/
        }
    </script>
</HEAD>
<BODY class=Main>
    <jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
    <Fieldset class="custom">
        <LEGEND>Submit Solutions</LEGEND><BR><BR><BR><BR><BR><BR>
        <%
            if (!(request.getMethod().equals("POST"))) {%>
        <FORM ACTION=""  METHOD=POST onsubmit="return validate()">
            <TABLE align=center width="60%">
                <TR class=row_title>
                    <TH colspan=6>Submit Solutions</TH>
                </TR>
                <TR>
                    <TH align="left">Title<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='Title' value=''></TD>
                    
                    <TH align="left">Author<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='Author' value=''></TD>
                    
                    <TH align="left">DateOfCreation<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='DateOfCreation' value=''><img onkeypress="fnCalendar(this)" id="imgDate" style="CURSOR: hand" onClick="fnCalendar(this)" height="16" src="Images/CalDis.gif" width="16" border="0" name="imgDate" onMouseOver="fnEnableCalLookup(this)" onMouseOut="fnDisableCalLookup(this)" ></TD>
                </TR>		
                <TR>
                    <TH align="left">ContentType<FONT COLOR="red">*</FONT></TH>
                    <TD><select class="ListBox" name=ContentType><option value=K-Document>K-Document</option><option value=ReusableCode>ReusableCode</option><option value=CodeSnippet>CodeSnippet</option><option value=Review>Review</option><option value=Software>Software</option></select class="ListBox"></TD>
                    
                    <TH align="left">Keywords<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='Keywords' value=''></TD>
                    
                    <TH align="left">Technology<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='Technology' value=''></TD>
                </TR>		
                <TR>
                    <TH align="left">Reference<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='Reference' value=''></TD>

                    <TH align="left">TargetUsers<FONT COLOR="red">*</FONT></TH>
                    <TD><select class="ListBox" name=TargetUsers><option value=All>All</option><option value=Developers>Developers</option><option value=Managers>Managers</option></select class="ListBox"></TD>

                    <TH align="left">Description<FONT COLOR="red">*</FONT></TH>
                    <TD><textarea name=Description class="TextField MLarge Left "></textarea></TD>
                </TR>
<!--                    
                    <TH align="left">PublishedOn</TH>
                    <TD><Input type=text class="TextField MLarge Left" name='PublishedOn' value=''><img onkeypress="fnCalendar(this)" id="imgDate" style="CURSOR: hand" onClick="fnCalendar(this)" height="16" src="Images/CalDis.gif" width="16" border="0" name="imgDate" onMouseOver="fnEnableCalLookup(this)" onMouseOut="fnDisableCalLookup(this)" ></TD>
                    
                    <TH align="left">Status<FONT COLOR="red">*</FONT></TH>
                    <TD><select class="ListBox" name=Status><option value=Submitted>Submitted</option><option value=Published>Published</option><option value=Rejected>Rejected</option><option value=InReview>InReview</option><option value=KTeam>KTeam</option></select class="ListBox"></TD>
                </TR>	

                <TR>
                    <TH align="left">Remarks<FONT COLOR="red">*</FONT></TH>
                    <TD><textarea name=Remarks class=TextArea></textarea></TD>
                    
                    <TH align="left">KTeamRating<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='KTeamRating' value=''></TD>
                    
                    <TH align="left">ReviewerId<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='ReviewerId' value=''></TD>
                </TR>		
                <TR>
                    <TH align="left">ReviewerRating<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='ReviewerRating' value=''></TD>
                    
                    <TH align="left">NoOfHits<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='NoOfHits' value=''></TD>
                    
                    <TH align="left">FileName<FONT COLOR="red">*</FONT></TH>
                    <TD><Input type=text class="TextField MLarge Left" name='FileName' value=''></TD>
                </TR>	
-->
                <TR>
                    <TH colspan=3 align=right><INPUT TYPE="submit" class= "Button" value='Submit'></TH><TH  colspan=3 align=left><INPUT TYPE="reset"  class= "Button" value='Clear'></TH>
                </TR>
            </TABLE>
            <H6 align=center>Fields with <FONT SIZE="" COLOR="red">*</FONT> are mandatory </H6>
        </FORM>
        <%} else {%>
        <%

            Connection con = null;
            ResultSet rs = null;
            Statement stmt = null;
            String Title = request.getParameter("Title");
            String Author = request.getParameter("Author");
            String DateOfCreation = request.getParameter("DateOfCreation");
            String DateOfSubmission = "";
            Calendar today = Calendar.getInstance();
            DateOfSubmission = com.KBank.MyFunctions.formatDate(today, "yyyy-MM-dd");
            String Keywords = request.getParameter("Keywords");
            String Technology = request.getParameter("Technology");
            String Reference = request.getParameter("Reference");
            String Description = request.getParameter("Description");
            String ContentType = request.getParameter("ContentType");
            String TargetUsers = request.getParameter("TargetUsers");
            String KId = com.KBank.MyFunctions.genNextID("kbdata", "KId", "K00");
            
            /*String PublishedOn = request.getParameter("PublishedOn");
            String Status = request.getParameter("Status");
            String Remarks = request.getParameter("Remarks");
            String KTeamRating = request.getParameter("KTeamRating");
            String ReviewerId = request.getParameter("ReviewerId");
            String ReviewerRating = request.getParameter("ReviewerRating");
            String NoOfHits = request.getParameter("NoOfHits");
            String FileName = request.getParameter("FileName");*/
            try {
                con = com.KBank.ConnectionPool.getConnection();
                stmt = con.createStatement();
                //String Query = "Insert into kbdata (`Title`,`Author`,`DateOfCreation`,`DateOfSubmission`,`Keywords`,`Technology`,`Reference`,`Description`,`ContentType`,`TargetUsers`,`PublishedOn`,`Status`,`Remarks`,`KTeamRating`,`ReviewerId`,`ReviewerRating`,`NoOfHits`,`FileName`) values('" + Title + "','" + Author + "','" + DateOfCreation + "','" + DateOfSubmission + "','" + Keywords + "','" + Technology + "','" + Reference + "','" + Description + "','" + ContentType + "','" + TargetUsers + "','" + PublishedOn + "','" + Status + "','" + Remarks + "'," + KTeamRating + ",'" + ReviewerId + "'," + ReviewerRating + "," + NoOfHits + ",'" + FileName + "')";
                String Query = "Insert into kbdata (`KId`,`Title`,`Author`,`DateOfCreation`,`DateOfSubmission`,`Keywords`,`Technology`,`Reference`,`Description`,`ContentType`,`TargetUsers`) values('" + KId + "','" + Title + "','" + Author + "','" + DateOfCreation + "','" + DateOfSubmission + "','" + Keywords + "','" + Technology + "','" + Reference + "','" + Description + "','" + ContentType + "','" + TargetUsers + "')";
                System.out.println("[QUERY]"+Query);
                int result = stmt.executeUpdate(Query);
                if (result > 0) {
                        %>
                        <input type="hidden" name="KId" value="<%=KId%>">
                        <script language="javascript">
                        alert('Data saved successfully ');
                        location.replace('UploadSolution1.jsp?KId=<%=KId%>');
                        </script>
                        <%
                } else {
                        %>
                        <script language="javascript">
                        alert('Error in saving data...Please try again ');
                        location.replace('Submit.jsp');
                        </script>
                        <%
                }
                stmt.close();
                con.close();
            } catch (Exception e) {
                stmt.close();
                con.close();
                throw new Exception(e);
            }
        %>
    </FIELDSET>
</BODY>
<%
            }	
%>
