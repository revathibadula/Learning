<%@ page import="java.util.*,javax.mail.*, javax.mail.internet.*,java.sql.*,com.KBank.GetMenuItems" %>
<%@ page language="java" %>
<%@ page session="true" %>
<%@ page errorPage="errorPage.jsp" %>


<html>
    <%
        GetMenuItems gm = new GetMenuItems();
        int i=0;
        int iCnt=0;
        String AuthGroup = (String)session.getAttribute("Auth");
        String MenuId = request.getParameter("MenuId");
        System.out.println("-->"+MenuId);
        String Title = request.getParameter("Title");
        if(AuthGroup==null){
                 session.invalidate();
		%><script language=javascript>window.opener = top; window.opener.location.replace("sessiontimeout.jsp");</script><%
        }
             
        Vector v = gm.processRequest(MenuId, AuthGroup);
        String[]  menuid =null;
        String[]  label =null;
        String[]  targetFrame =null;
        String[]  executable =null;
        String ICnt = "0";
       
        if(v!=null && v.isEmpty()==false){
             menuid =(String[]) v.get(0);
             label = (String[])v.get(1);
             targetFrame = (String[])v.get(2);
             executable = (String[])v.get(3);
             ICnt = ((String)v.get(4));
             iCnt = Integer.parseInt(ICnt);
        }
        
     
    
       //System.out.println("iCnt---"+iCnt);
       Vector subMenus = new Vector();
       for(int x=0;x<iCnt;x++){
           //System.out.println("menuid[x]"+menuid[x]);
           Vector vTemp = gm.processRequest(menuid[x], AuthGroup);
           subMenus.add(vTemp);
       }
        System.out.println("subMenus-->"+subMenus);
    %>
    
    <HEAD>
        <link href='styles/styles.css' rel="stylesheet"/>
        <script language=javascript>
                function fnInitiate(){
                    <%
                            if(label==null){}
                            else{
                                %>fnToggleStyle(<%=label[0]%>);<%
                            }
                    %>
                }
                function fnToggleStyle(obj){
                    var menuName=obj.id;
                    <%
                     for(i=0;i<iCnt;i++)
                            {
                                %>
                                if(menuName!='<%=label[i]%>')
                                 {
                                     document.getElementById('<%=label[i]%>').style.color='Blue';
                                     document.getElementById('<%=label[i]%>').style.fontStyle="Normal";
                                     document.getElementById('<%=label[i]%>').style.fontFamily='Georgia,Verdana';
                                     
                                 }else{
                                    document.getElementById('<%=label[i]%>').style.color='#000000';
                                     document.getElementById('<%=label[i]%>').style.fontStyle="Italic";
                                      document.getElementById('<%=label[i]%>').style.fontFamily='Georgia,Verdana';
                                 }
                                <%
                            }
                     %>
                 }
                 function fnToggleSubMenuStyle(obj,siCnt,j){
                    var menuName=obj.id;
                    j = parseInt(j);
                     for(i=0;i<siCnt;i++)
                            {
                                if(i==j)
                                 {
                                      document.getElementById(menuName).style.color='#000000';
                                     document.getElementById(menuName).style.fontStyle="Italic";
                                      document.getElementById(menuName).style.fontFamily='Georgia,Verdana';
                                 }
                             }
                       for(i=0;i<siCnt;i++)   
                           {
                                 if(i!=j)
                                 {
                                     document.getElementById(menuName).style.color='Blue';
                                     document.getElementById(menuName).style.fontStyle="Normal";
                                     document.getElementById(menuName).style.fontFamily='Georgia,Verdana';
                                 }
                            }
                     
                 }
        </script>
          
    </HEAD>
    <BODY class="LeftPane" onload='fnInitiate()'>
        <BR><BR>
        <font class="message"> &nbsp; &nbsp;<%=Title%></font>
        
               <%
               
                for(i=0;i<iCnt;i++)
                {
               %>
               <BR></BR>
               <a href="<%=executable[i] %>" target="<%=targetFrame[i]%>" class="subMenu" onclick="fnToggleStyle(this)" id="<%=label[i]%>">
               <%=label[i]%>
               </a>
               <%
                    
                    Vector vsTemp = (Vector)subMenus.get(i);
                    if(vsTemp.isEmpty()==false){
                          String[]  smenuid =(String[]) vsTemp.get(0);
                          
                          String[]  slabel = (String[])vsTemp.get(1);
                          String[]  stargetFrame = (String[])vsTemp.get(2);
                          String[]  sexecutable = (String[])vsTemp.get(3);
                          String sICnt = ((String)vsTemp.get(4));
                          int siCnt = Integer.parseInt(sICnt);
                          
                           for(int j=0;j<siCnt;j++)
                             {
                                    %><BR><BR> &nbsp; &nbsp;
                                    <a href="<%=sexecutable[j] %>" target="<%=stargetFrame[j]%>"  class="subMenu" onclick="fnToggleSubMenuStyle(this,'<%=sICnt+""%>','<%=j+""%>')" id="<%=slabel[j]%>">
                                    &nbsp;-&gt;&nbsp;<%=slabel[j]%>
                                    </a>
                                    <%
                                    
                             }
                    }
                   
                }                    
                %>
         
    </BODY>
    
    
<html>

