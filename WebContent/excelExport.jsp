<%@ page language="java"
         contentType="application/vnd.ms-excel;"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap, java.text.*, org.apache.log4j.*"%>
<%@ page import="com.eminent.util.*, dashboard.CheckDate"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
        <META NAME="Author" CONTENT="">
        <META NAME="Keywords" CONTENT="">
        <META NAME="Description" CONTENT="">
        <style>
            td{
                border: 1px solid black;
                text-align: center;
            }
        </style>
    </HEAD>


    <BODY BGCOLOR="#FFFFFF">

        <jsp:useBean id="MyIssue" class="com.pack.MyIssueBean" />
        <jsp:useBean id="MyAssignement" class="com.pack.UpdateIssueBean" />
        <%
            response.setHeader("Content-Disposition", "attachment; filename=\"excelExport.xls\"");
            //Configuring log4j properties

            Logger logger = Logger.getLogger("excelExport");

            Connection connection = null;
            Statement state1 = null;
            ResultSet result1 = null, rs = null, rs2 = null, rs1 = null;
            int count = 0, rowcount = 0, age = 0;
            String requestPage = null;
            HashMap hm = null;
            PreparedStatement ps = null;

            try {
                connection = MakeConnection.getConnection();

                if (connection != null) {
                    Integer userid_curr = (Integer) session.getAttribute("userid_curr");
                    int userid_curri = userid_curr.intValue();
                    String theissuno;
                    requestPage = request.getParameter("export");
                    if (requestPage.equals("MyIssue")) {

                        String createdby = String.valueOf(userid_curri);
                        ps = connection.prepareStatement("select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and createdby = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ps.setString(1, createdby);
                        rs = ps.executeQuery();
                        hm = MyIssue.getUser(connection);
                    } else if (requestPage.equals("MyAssignment")) {
                        logger.info(request.getParameter("assignmentType"));
                        if (request.getParameter("assignmentType") != null) {
                            String query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                            String assignmentType = "All";
                            assignmentType = request.getParameter("assignmentType");
                            if (assignmentType.equalsIgnoreCase("backlog")) {
                                query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date < sysdate-1 order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                            } else if (assignmentType.equalsIgnoreCase("currentWeek")) {
                                query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date > sysdate-1 and i.due_date<=(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                            } else if (assignmentType.equalsIgnoreCase("nextWeek")) {
                                query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual) and i.due_date<(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+7 from dual)order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                            } else if (assignmentType.equalsIgnoreCase("afterTwoWeeks")) {
                                query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+7 from dual) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                            } else {
                                query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                            }
                            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            ps.setInt(1, userid_curri);
                            rs = ps.executeQuery();
                        } else {
                            logger.info("no parameter");
                            ps = connection.prepareStatement("select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            ps.setInt(1, userid_curri);
                            rs = ps.executeQuery();
                        }
                        hm = MyAssignement.showUsers(connection);
                    } else if (requestPage.equals("IssueSummary")) {
                        String sql = (String) session.getAttribute("IssueSummaryQuery");
                        ps = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        rs = ps.executeQuery();
                        hm = MyAssignement.showUsers(connection);
                    } else if (requestPage.equals("MyQuery")) {
                        String queryid = (String) session.getAttribute("query_id");

                        int queryidInt = Integer.parseInt(queryid);
                        state1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        rs = state1.executeQuery("select QUERY_STRING from MYQUERY where query_id = " + queryidInt);
                        String query_string = "";
                        if (rs != null) {
                            rs.next();
                            query_string = (String) rs.getString("query_string");
                            logger.info("QueryString:" + query_string);

                            state1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            rs = state1.executeQuery(query_string);
                        }
                        hm = MyIssue.getUser(connection);
                    }

                    rs.last();
                    rowcount = rs.getRow();

                    rs.beforeFirst();


        %>

        <table width="100%" height="15">
            <tr>

                <TD align="right" width="25" height="40">Severity</td>
                <TD align="right" width="25" height="40" bgcolor="#FF0000">S1</TD>
                <TD align="right" width="25" height="40" bgcolor="#FF9900">S2</TD>
                <TD align="right" width="25" height="40" bgcolor="#FFFF00">S3</TD>
                <TD align="right" width="25" height="40" bgcolor="#33FF33">S4</TD>
            </tr>

        </table>



        <TABLE width="100%">
            <TR bgColor="#C3D9FF">
                <TD width="1%"><font><b>S</b></font></TD>
                <TD width="11%"><font><b>Issue No</b></font></TD>
                <TD width="7%"><font><b>Priority</b></font></TD>
                <TD width="13%"><font><b>Project</b></font></TD>
                <TD width="13%"><font><b>Module</b></font></TD>
                <TD width="29%"><font><b>Subject</b></font></TD>
                <TD width="9%"><font><b>Status</b></font></TD>


                <TD width="9%"><font><b>Due Date</b></font></TD>
                        <%                            if (requestPage.equals("MyAssignment")) {
                        %>
                <TD width="13%"><font><b>CreatedBy</b></font></TD>
                        <%                } else {
                        %>
                <TD width="13%"><font><b>AssignedTo</b></font></TD>
                        <%                    }
                        %>
                <TD width="8%"><font><b>Age(in Days)</b></font></TD>


            </TR>
        </table>
        <%
            if (rs != null) {
                while (rs.next()) {

                    String project = rs.getString("project");
                    String iss = rs.getString("issueid");
                    String module = rs.getString("module");
                    String severity = rs.getString("severity");
                    String type = rs.getString("type");
                    String priority = rs.getString("priority");
                    String p = "NA";
                    if (priority != null) {
                        p = priority.substring(0, 2);
                    }

                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                    Date dueDateFormat = rs.getDate("due_date");

                    String dueDate = "NA";
                    if (dueDateFormat != null) {
                        dueDate = sdf.format(dueDateFormat);
                    }

                    String sub = rs.getString("subject");
                    String assignedto1 = rs.getString("assignedto");
                    String createdby = rs.getString("createdby");
                    String status = rs.getString("status");
                    Date created = rs.getDate("createdon");

                    String createdon = "NA";
                    if (created != null) {
                        createdon = sdf.format(created);
                    }

                    Date modified = rs.getDate("modifiedon");
                    String modifiedon = "NA";
                    if (modified != null) {
                        modifiedon = sdf.format(modified);
                    }
                    age = GetAge.getIssueAge(createdon, status, modifiedon);

                    // to fetch the firstname & lastname from user table
                    //int size = hm.size();
                    int assignedTo = Integer.parseInt(assignedto1);

                    String result = (String) hm.get(assignedTo);
                    String createdname = (String) hm.get(Integer.parseInt(createdby));
                    //			logger.info("ASSSIGNEDTO:"+assignedTo+"::"+result);

                    String s1 = "S1- Fatal";
                    String s2 = "S2- Critical";
                    String s3 = "S3- Important";
                    String s4 = "S4- Minor";


        %>



        <table>
            <tr bgcolor="white" height="22">


                <%                    if (severity.equals(s1)) {
                %>
                <td width="1%" bgcolor="#FF0000"></td>
                <%                } else if (severity.equals(s2)) {
                %>
                <td width="1%" bgcolor="#DF7401"></td>
                <%                } else if (severity.equals(s3)) {
                %>
                <td width="1%" bgcolor="#F7FE2E"></td>
                <%                } else if (severity.equals(s4)) {
                %>
                <td width="1%" bgcolor="#33FF33"></td>
                <%                    }
                %>
                <td width="11%" height="40"><font face="Times New Roman" size="1"
                                                  color="#0033FF"><%=iss%> </font></td>
                <td width="7%" height="40"><font face="Times New Roman" size="1"
                                                 color="#000000"><%= p%></font></td>
                <td width="13%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%= project%></font></td>
                <td width="13%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%= module%></font></td>
                <td width="29%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%= sub%></font></td>
               	<td width="9%" height="40"><font face="Times New Roman" size="1"
                                                 color="#000000"><%= status%></font></td>

                <%
                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                %>
                <td width="9%" height="40"><font face="Times New Roman" size="1"
                                                 color="RED"><%= dueDate%></font></td>
                        <%
                        } else {
                        %>
                <td width="9%" height="40"><font face="Times New Roman" size="1"
                                                 color="#000000"><%= dueDate%></font></td>
                        <%
                            }
                        %>
                        <%
                            if (requestPage.equals("MyAssignment")) {

                        %>
                <td width="13%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%= createdname%> </font></td>
                        <%
                        } else {
                        %>
                <td width="13%" height="40"><font face="Times New Roman" size="1"
                                                  color="#000000"><%= result%> </font></td>
                        <%
                            }
                        %>


                <td width="8%" align="center" height="40"><font
                        face="Times New Roman" size="1" color="#000000"><%=age%></font></td>
            </tr>

            <%
                }
            %>

            <%
                }
            %>
        </TABLE>
        <%
                }
            } catch (Exception e) {

                logger.error(e);
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (state1 != null) {
                    state1.close();
                }
                if (connection != null) {
                    connection.close();

                }
            }
        %>
    </BODY>
</html>

