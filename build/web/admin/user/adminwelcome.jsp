    <%@ page import="org.apache.log4j.*"%>
    <%@ page import="java.util.Calendar"%>
    <%@ page import="java.util.GregorianCalendar,com.eminent.timesheet.CreateTimeSheet"%>
<%

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<script>

window.history.forward(1);

</script>
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>
<!--
(Please keep all copyright notices.)
This frameset document includes the Treeview script.
Script found in: http://www.treeview.net
Author: Marcelino Alves Martins

You may make other changes, see online instructions, 
but do not change the names of the frames (treeframe and basefrm)
-->

<%

        int roleId  =   (Integer)session.getAttribute("Role");
        
if(roleId==1){
%>

<frameset cols="13%,*"
	onResize="if (navigator.family == 'nn4') window.location.reload()"
	border="0" FRAMEBORDER=NO FRAMESPACING=0/>

	<FRAME src="<%= request.getContextPath() %>/admin/user/LeftFrame.jsp"
		name="treeframe" noresize scrolling="no"/>
	<frameset rows="92%,*" border="0" FRAMEBORDER=NO FRAMESPACING=0>
		<FRAME
			src="<%= request.getContextPath() %>/admin/project/moduleIssueSplit.jsp"
			name="basefrm" scrolling="auto"/>
		<FRAME id=frmMain name=frmMain marginWidth=0 marginHeight=0
			src="<%= request.getContextPath() %>/footer.jsp" frameBorder=0
			noResize scrolling=no/>
	</frameset>

</frameset>
<%}else{
                    String mail=(String)session.getAttribute("theName");
        String url  =   "";
        if(mail!=null){
                url=mail.substring(mail.indexOf("@")+1,mail.length());
            }
         int timeSheetMonth = 0;
             int timeSheetYear  = 0;
             int year  = 0;
             int month = 0;
              String timeSheetId ="T";
if(url.equals("eminentlabs.net")){
%>
<%
            

            Calendar timeSheetCal =new GregorianCalendar();
             year  = timeSheetCal.get(Calendar.YEAR);
             month = timeSheetCal.get(Calendar.MONTH);

            timeSheetCal.add(timeSheetCal.MONTH,-1);

            int assignedto =(Integer)session.getAttribute("uid");
            timeSheetMonth =timeSheetCal.get(timeSheetCal.MONTH);
            timeSheetYear =timeSheetCal.get(timeSheetCal.YEAR);

           
            if(timeSheetMonth>9){
                timeSheetId=timeSheetId+timeSheetMonth+timeSheetYear+assignedto;
             }else{
                 timeSheetId=timeSheetId+"0"+timeSheetMonth+timeSheetYear+assignedto;
             }
             
           
 }

%>

<frameset cols="15%,*" onResize="if (navigator.family == 'nn4') window.location.reload()" border="0" framespacing="0" marginheight="0" marginwidth="0" FRAMEBORDER="no" FRAMESPACING="0">
        <%if(roleId==2){%>
	<frame src="<%= request.getContextPath() %>/left.jsp" name="treeframe" noresize scrolling="no"`/>
        <%}else{%>
        <frame src="<%= request.getContextPath() %>/crmMenu.jsp" name="treeframe" noresize scrolling="no"/>
        <%}%>
	<frameset rows="92%,*" border="0" FRAMEBORDER="NO" FRAMESPACING="0" framespacing="0" marginheight="0" marginwidth="0">
            <%
            if((!CreateTimeSheet.checkTimesheet(timeSheetId))&& (timeSheetMonth!=month || timeSheetYear!=year)){
            %>
                <FRAME src="<%=request.getContextPath()%>/timeSheet.jsp?month=<%=timeSheetMonth%>&year=<%=timeSheetYear%>" name="basefrm" FRAMEBORDER="no" marginheight="0" marginwidth="0" FRAMESPACING=0 BORDER=0 noresize scrolling="auto"/>
            <%
            }else{
            %>
            <FRAME src="<%= request.getContextPath() %>/admin/dashboard/chartForUsers.jsp" name="basefrm" FRAMEBORDER="no" marginheight="0" marginwidth="0" FRAMESPACING=0 BORDER=0 noresize scrolling="auto"/>
            <!--<FRAME src="<%= request.getContextPath() %>/testMap.jsp?pid=10114" name="basefrm" FRAMEBORDER="no" marginheight="0" marginwidth="0" FRAMESPACING=0 BORDER=0 noresize scrolling="auto"/>-->
<!--            <FRAME src="<%= request.getContextPath() %>/MOM/addTask.jsp?pid=10114" name="basefrm" FRAMEBORDER="no" marginheight="0" marginwidth="0" FRAMESPACING=0 BORDER=0 noresize scrolling="auto"/>-->
            <%}%>
		<FRAME id=frmMain name=frmMain marginWidth=0 marginHeight=0 src="<%= request.getContextPath() %>/footer.jsp" FRAMEBORDER="no" FRAMESPACING=0 BORDER=0 noresize scrolling="no"/>
	</frameset>

</frameset>
            
}%>
<%}%>
</HTML>
