
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='styles/styles.css' rel="stylesheet"/>
        <title>Information Treasury</title>
    </head>
     <FRAMESET ROWS="100,*,5%" NORESIZE frameborder="no" border="0">
        <Frameset Rows="70,*" NORESIZE frameborder="no" border="0">
                    <Frame Name ="HeaderInfo" src="Header.jsp" FrameBorder=0 
                    Marginheight=0 Marginwidth=0  NORESIZE scrolling=no>
                    <Frame name = "MenuFrame" src="DynaTabbedMenu.jsp" FrameBorder=0
                    Marginheight=0 Marginwidth=0  NORESIZE scrolling=no>
        </Frameset>
        <Frameset Cols="154,*" NORESIZE frameborder="no" border="0">
               <Frame Name="LeftPane" src="LeftPane.jsp?MenuId=1&Title=" FrameBorder=0 
            Marginheight=0 Marginwidth=0 NORESIZE scrolling=no>
                <FRAME SRC="Body.jsp" NAME="MainFrame"  FrameBorder=0 Marginheight=0 Marginwidth=0 NORESIZE scrolling=auto>
        </Frameset>
    
	<FRAME SRC="FooterMenu.jsp" NAME="FootFrame"  FrameBorder=0 Marginheight=0
        Marginwidth=0 NORESIZE scrolling=no>
    </FRAMESET>
    
 
     
</html>
