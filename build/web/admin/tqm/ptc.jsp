<%-- 
    Document   : ptc
    Created on : Dec 4, 2009, 5:52:01 PM
    Author     : Administrator
--%>
<%@ page import="org.apache.log4j.*,com.eminent.tqm.TqmUtil"%>
<%


	Logger logger = Logger.getLogger("ApproveUsers");
	
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs CRM, APM, ERM and PTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        
    </head>
    <%

        int userId=(Integer)session.getAttribute("uid");
        String[] functionality=request.getParameterValues("functionality");
        String[] expectedresult=request.getParameterValues("expectedresult");
        String[] description=request.getParameterValues("description");
        int pid=Integer.parseInt(request.getParameter("project"));
        int mid=Integer.parseInt(request.getParameter("module"));
        String addPlan =   request.getParameter("addplan");
        String tepId   =   request.getParameter("testplan");
        for(int i=0;i<functionality.length;i++){
            logger.info("Func->"+functionality[i]+"--Result->"+expectedresult[i]+"-->Desc"+description[i]);
            TqmUtil.createPTC(pid,mid,functionality[i],description[i],expectedresult[i],userId,tepId,addPlan);
        }
    %>
    <jsp:forward page="listPTC.jsp"/>
    <body></body>
</html>
