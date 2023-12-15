<%-- 
    Document   : mainsubissues
    Created on : 20 Nov, 2023, 10:48:06 AM
    Author     : Subhashini-ABAP
--%>

<%@page import="java.util.Map"%>
<%@page import="com.eminent.issue.dao.IssueDAOImpl"%>
<%@page import="com.eminent.issue.dao.IssueDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="dashboard.TestCases"%>
<%@page import="dashboard.CheckCategory"%>
<%@page import="com.eminent.util.GetProjects"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%
    //Configuring log4j properties
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    Logger logger = Logger.getLogger("mainsubissues");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }

%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=120720161653" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js?c=0"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/css/displayColumns.css?test=280620161553" type="text/css" rel="STYLESHEET">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/dragtable.css" />

    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.dragtable.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javaScript/jquery.chili-2.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <link title=STYLE href="<%= request.getContextPath()%>/css/notifyMe.css?test=1" type="text/css" rel="STYLESHEET"/>
        <script src="<%=request.getContextPath()%>/javaScript/bp.js?tt=232332323" type="text/javascript"></script>

    <style type="text/css">
        ul{list-style: none outside none;padding: 0;	margin: 0;margin-top: 4px;background-color: white;}
        ul li{padding: 3px 0px 3px 16px;margin: 0;}
        a{text-decoration: none;color: black;}

    </style>
    <script>
        function call(theForm)
        {
            var x = document.getElementById("pid").value;
            theForm.action = 'mainsubissues.jsp?pid=' + x;
            theForm.submit();
        }
    </script>
</head>
<body>
    <%@ include file="/header.jsp"%>
    <%
        String pid = request.getParameter("pid");
        Integer current_userId = (Integer) session.getAttribute("userid_curr");
        String userId = current_userId.toString();
        boolean projectAccess = false;
        int roleId = (Integer) session.getAttribute("Role");
        if (roleId != 1) {
            projectAccess = GetProjectMembers.isAssigned(userId, pid);
        } else {
            projectAccess = true;
        }
        if (projectAccess == true) {
            String project = GetProjects.getProjectName(pid);
            String category = "NA";
            if (project != null) {
                category = CheckCategory.getCategory(project);
            }
            String cases[][] = TestCases.showTestCases(pid);
            int noOfTestcases = cases.length;
            logger.info("Category :" + category);
            session.setAttribute("testMapPid", pid);
            //Getting User Id and Role
            Integer role = (Integer) session.getAttribute("Role");
            Integer uid = (Integer) session.getAttribute("userid_curr");
            int roleValue = role.intValue();
            int uidValue = uid.intValue();
            HashMap<String, String> projects = null;
            if (roleValue == 1) {
                projects = GetProjectManager.getProjects();
            } else {
                //Displaying only assigned projects to other roles
                projects = GetProjectManager.getUserProjects(uidValue);
            }
            Collection se1 = projects.keySet();
            String pname = GetProjects.getProject(Integer.parseInt(pid));
    %>

    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF" >
        <tr style="height:15px;">
            <td border="1" align="left" width="80%">
                <b>View Main Issues for <%=pname%></b></td>
            <td style="text-align:right;">
                <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                    <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">                 

                        <%                            //Displaying all the projects for Admin role
                            Iterator iter3 = se1.iterator();
                            int projectId = 0;
                            while (iter3.hasNext()) {

                                String key = (String) iter3.next();
                                String nameofproject = (String) projects.get(key);
                                //      logger.info("Userid"+key);
                                //      logger.info("Name"+nameofuser);
                                projectId = Integer.parseInt(key);
                                if (projectId == Integer.parseInt(pid)) {

                        %>
                        <option value="<%=pid%>" selected><%=nameofproject%></option>
                        <%
                        } else {%>
                        <option value="<%=projectId%>"><%=nameofproject%></option>
                        <% }
                            }%>
                    </select></form>
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td width="5%">
                <%
                    if (category.equalsIgnoreCase("SAP Project")) {
                %>
                <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Business Process Map Tree View</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                <%
                    }
                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                <%
                    if (noOfTestcases > 0) {
                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=project%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>&project=<%=project%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>" >View Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/mainsubissues.jsp?pid=<%=pid%>" style="font-weight: bold;">View Main Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                <%if (project.contains("10043")) {%>
                <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
            </td>
        </tr>
    </table>
  <div>
        <input type="hidden" value="<%=pid%>" id="pid"/>
        <input type="hidden" value="<%=project%>" id="pname"/>
         <ul id="mainTree">
            <%
            IssueDAO isissueDAO = new IssueDAOImpl();
            
            
           for(Map.Entry<String, String> entry : isissueDAO.getmainissues(Integer.parseInt(pid)).entrySet()){
            %>
            <li id="mainIssue<%=entry.getKey()%>">
               <div class="treeclass" onclick="javascript:viewSubIssues('<%=entry.getKey()%>');"></div>
               <a href="#" onclick="javascript:viewSubIssues('<%=entry.getKey()%>');"><b>Main Issue :</b> <%=entry.getValue()%> </a>
            </li>
            <%}%>
         </ul>
        </div>

  

    <%} else {%>
    <br/><div style="text-align: center;color: red;">You are not authorized to access it</div>
    <%}%>
  
</body>

    
</html>
