<%-- 
    Document   : adminLeadView
    Created on : Aug 21, 2013, 4:42:45 PM
    Author     : Tamilvelan
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap, java.text.*, com.pack.StringUtil"%>
<%@ page import="pack.eminent.encryption.*,com.eminent.util.*, dashboard.CheckDate,com.eminentlabs.crm.CRMUtil"%>





<%
    session.setAttribute("forwardpage", "/MyCRM/adminLeadView.jsp");
//			response.setHeader("Cache-Control","no-cache");
//			response.setHeader("Cache-Control","no-store");
//			response.setDateHeader("Expires", 0);
//		 	response.setHeader("Pragma","no-cache");

                        //Configuring log4j properties
    Logger logger = Logger.getLogger("CRM Lead Issues");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>

<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
        <META NAME="Author" CONTENT="">
        <META NAME="Keywords" CONTENT="">
        <META NAME="Description" CONTENT="">
        <LINK title=STYLE
              href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
              type=text/css rel=STYLESHEET>
        <script language="JavaScript">
            function check(searchLead) {
                if ((searchLead.leadName.value === null) || (searchLead.leadName.value === ""))
                {
                    alert("Please Enter Name or Company ")
                    searchLead.leadName.focus()
                    return false
                }
                return true
            }

        </script>
    </HEAD>

    <style fprolloverstyle>
        A:hover {
            color: #FF0000;
            font-weight: bold
        }
    </style>
    <BODY BGCOLOR="#FFFFFF">

        <%@ include file="../header.jsp"%>



        <form name="searchLead" onsubmit="return check(this);"
              action="searchLead.jsp">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#E8EEF7">
                    <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                        COLOR="#0000FF"> <b> CRM Lead Issues </b></font><FONT SIZE="3"
                                                                              COLOR="#0000FF"> </FONT></td>
                    <td align="right"><b>Enter Lead Name:</b></td>
                    <td align="left"><input type="text" name="leadName" maxlength="12"
                                            size="15"></td>
                    <td><input type="submit" name="submit" value="Search"></td>
                    <td><input type="reset" name="reset" value="Reset"></td>
                    <td width="25%" border="1" align="right"><font size="2"
                                                                   face="Verdana, Arial, Helvetica, sans-serif"></font></td>
                </tr>
            </table>
        </form>

        <br>

        <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> <%!
            int requestpage, pageone, pageremain, rowcount, age;
            static int totalpage, pagemanipulation, presentpage, extra, issuenofrom, issuenoto;
            int userid_curri;
            HashMap<String, Integer> hm = null;
            String userid_curr = "";

                    %> <%

                    Connection connection = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    //int count =0;
                    try {
                        connection = MakeConnection.getConnection();
                        logger.debug("Connection:" + connection);

                        if (connection != null) {
                            userid_curr = request.getParameter("currentUserId");
                            userid_curri = Integer.parseInt(userid_curr);
                                    //String theissuno;

                            // invoking the Query() of MyIssueBean
                            logger.debug("CurrentUserID:" + userid_curri);
                            String assignedto = String.valueOf(userid_curri);
                            ps = connection.prepareStatement("SELECT LEADID,TITLE,FIRSTNAME, LASTNAME, COMPANY, STATE,PHONE,MOBILE,EMAIL,LEADSTATUS,RATING,DUEDATE,ASSIGNEDTO,CREATEDON,MODIFIEDON,LEAD_OWNER,DESCRIPTION  from lead where roleid=2 and assignedto=? order by duedate ASC", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            ps.setString(1, assignedto);

                            rs = ps.executeQuery();
                            rs.last();
                            rowcount = rs.getRow();
                            rs.beforeFirst();

                            pageone = rowcount / 15;
                            pageremain = rowcount % 15;

                            logger.debug("Total No of records:" + rowcount);
                            if (pageremain > 0) {
                                totalpage = pageone + 1;
                            } else {
                                totalpage = pageone;
                            }
                            logger.debug("Total no of pages" + totalpage);
                            try {
                                String requestpag = request.getParameter("manipulation");
                                logger.debug("Requested page" + requestpag);
                                if (requestpag != null) {
                                    requestpage = Integer.parseInt(requestpag);
                                    if (requestpage == 1) {
                                        presentpage = 1;
                                        issuenofrom = 1;
                                        issuenoto = issuenofrom + 14;
                                        if (issuenoto > rowcount) {
                                            extra = issuenoto - rowcount;
                                            issuenoto = issuenoto - extra;
                                        }
                                        rs.beforeFirst();
                                        logger.debug("Requested page First" + presentpage);
                                    }
                                    if (requestpage == 2) {
                                        presentpage = presentpage - 1;
                                        if (presentpage <= 0) {
                                            presentpage = 1;
                                        }
                                        if (presentpage == 1) {
                                            rs.beforeFirst();
                                            issuenofrom = 1;
                                            issuenoto = issuenofrom + 14;
                                            if (issuenoto > rowcount) {
                                                extra = issuenoto - rowcount;
                                                issuenoto = issuenoto - extra;
                                            }
                                        } else {
                                            issuenofrom = ((presentpage - 1) * 15 + 1);
                                            rs.absolute(issuenofrom - 1);
                                            issuenoto = issuenofrom + 14;
                                            if (issuenoto > rowcount) {
                                                extra = issuenoto - rowcount;
                                                issuenoto = issuenoto - extra;
                                            }
                                        }
                                        logger.debug("Requested page Prev" + presentpage);
                                    }
                                    if (requestpage == 3) {
                                        presentpage = presentpage + 1;
                                        if (presentpage >= totalpage) {
                                            presentpage = totalpage;
                                        }
                                        issuenofrom = ((presentpage - 1) * 15 + 1);
                                        rs.absolute(issuenofrom - 1);
                                        logger.debug("Requested page Next" + presentpage);
                                        issuenoto = issuenofrom + 14;
                                        if (issuenoto > rowcount) {
                                            extra = issuenoto - rowcount;
                                            issuenoto = issuenoto - extra;
                                        }
                                    }
                                    if (requestpage == 4) {

                                        presentpage = totalpage;
                                        logger.debug("Requested page Last" + presentpage);
                                        issuenofrom = ((presentpage - 1) * 15 + 1);
                                        rs.absolute(issuenofrom - 1);
                                        issuenoto = issuenofrom + 14;
                                        if (issuenoto > rowcount) {
                                            extra = issuenoto - rowcount;
                                            issuenoto = issuenoto - extra;
                                        }
                                    }
                                } else {
                                    presentpage = 1;
                                    if (rowcount > 0) {
                                        issuenofrom = 1;
                                    } else {
                                        issuenofrom = 0;
                                    }
                                    rs.beforeFirst();
                                    issuenoto = issuenofrom + 14;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
                                }
                            } catch (Exception e) {
                                logger.error("Exception:" + e);
                            }
                            int apmIssues = CRMIssue.getAPMIssues(connection, userid_curri);
                            hm = CRMIssue.getCRMIssuesCounts(connection, userid_curri);
                            int contact = hm.get("Contact");
                            int lead = hm.get("Lead");
                            int opportunity = hm.get("Opportunity");
                            int account = hm.get("Account");
        %>

        <%
            String pro = "CRM";
            String fix = "1.0";
            String manager = GetProjectManager.getManager(pro, fix);
            int userId = (Integer) session.getAttribute("userid_curr");
            int unapprovedContact = 0;
            if (Integer.parseInt(manager) == userId) {
                unapprovedContact = CRMUtil.getUnapprovedContacts(userId);
            }
        %>
        <table width="100%">
            <tr>
                <td colspan="3">

                    <%
                        if (contact > 0) {
                    %> 
                    <a href="<%=request.getContextPath()%>/MyCRM/adminContactView.jsp?currentUserId=<%=userid_curri%>">Contact Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%}%>
                    <%
                        if (unapprovedContact > 0) {
                    %>
                    <a href="<%=request.getContextPath()%>/MyCRM/waitingContacts.jsp">Approve Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%}%>
                    <b><a href="javascript:void(0);">Lead Issues</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%
                        if (opportunity > 0) {
                    %>  
                    <a href="<%=request.getContextPath()%>/MyCRM/adminOppView.jsp?currentUserId=<%=userid_curri%>">Opportunity Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%}
                        if (account > 0) {
                    %>  
                    <a href="<%=request.getContextPath()%>/MyCRM/adminAccView.jsp?currentUserId=<%=userid_curri%>">Account Issues</a>
                    <%} %>
                </td>
            </tr>
            <tr>
                <%
                    if (rowcount == 0) {
                %>
                <td align="left" width="40%">This list shows <b> <%=rowcount%>
                    </b>leads are assigned to you.</td>
                    <%
                    } else {
                    %>
                <td align="left" width="40%">This list shows <b> <%=rowcount%>
                    </b>leads are assigned to you.</td>
                    <%
                        }
                    %>
                    <%if (apmIssues > 0) {%>
                <TD align="right" width="40%">You have <a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp"><%=apmIssues%></a> APM Issues</td>
                    <%} else { %>
                <TD align="right" width="40%" ></td>
                    <%}%>
                <td align="right" width="100%">Leads</td>
                <TD align="right" width="25"><%=issuenofrom%></td>
                <TD align="right" width="25">-</td>
                <TD align="right" width="25"><%=issuenoto%></td>


            </tr>
        </table>
        <br>
        <TABLE width="100%">
            <TR bgColor="#C3D9FF" height="9">


                <TD width="20%"><font><b>Lead Name</b></font></TD>
                <TD width="18%"><font><b>Company</b></font></TD>
                <TD width="12%"><font><b>Phone</b></font></TD>
                <TD width="13%"><font><b>Email</b></font></TD>
                <TD width="10%"><font><b>Lead Status</b></font></TD>
                <TD width="8%"><font><b>Rating</b></font></TD>
                <TD width="9%"><font><b>Due Date</b></font></TD>
                <TD width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>

            </TR>
            <%

                if (rs != null) {
                    for (int i = 1; i <= 15; i++) {
                        if (rs.next()) {

                            int leadid = rs.getInt("leadid");
                            String title = rs.getString("TITLE");

                            String firstname = rs.getString("firstname");

                            String lastname = rs.getString("lastname");

                            String company = rs.getString("company");

                            String state = rs.getString("state");

                            String email = rs.getString("email");

                            String leadstatus = rs.getString("leadstatus");

                            String phone = rs.getString("phone");

                            String mobile = rs.getString("mobile");

                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                            Date createdOn = rs.getDate("createdon");
                            String createdon = null;
                            if (createdOn != null) {
                                createdon = sdf.format(createdOn);
                                age = GetAge.getContactAge(connection, createdon);
                                createdon = ((Integer) age).toString();
                            } else {
                                createdon = "NA";
                            }
                            Date dueDateFormat = rs.getDate("duedate");

                            String dueDate = "NA";
                            if (dueDateFormat != null) {

                                dueDate = sdf.format(dueDateFormat);
                            }

                            String typ = rs.getString("assignedto");
                            String assignedTo = "NA";
                            if (typ != null) {
                                assignedTo = GetProjectManager.getUserName(Integer.parseInt(typ));
                            }

                            String own = rs.getString("lead_owner");
                            String owner = "NA";
                            if (own != null) {
                                owner = GetProjectManager.getUserName(Integer.parseInt(own));
                            }

                            Date modifiedOn = rs.getDate("modifiedon");

                            String modified = "NA";
                            if (modifiedOn != null) {

                                modified = sdf.format(modifiedOn);
                            }

                            String rate = rs.getString("rating");
                            if (rate == null) {
                                rate = "NA";
                            }

                            String description = rs.getString("description");
                            if (description == null) {
                                description = "NA";
                            }

                            String lastcomment = CRMIssue.getLeadLastComment(connection, leadid);


            %>


            <%            if ((i % 2) != 0) {
            %>
            <tr bgcolor="white" height="22">
                <%
                } else {
                %>

            <tr bgcolor="#E8EEF7" height="22">
                <%
                    }
                %>


                <td width="20%" TITLE="<%= title%>"><A
                        HREF="<%=request.getContextPath()%>/MyCRM/crmIssueView.jsp?leadid=<%=leadid%>"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=firstname%><%=lastname%>
                        </font></A></td>
                <td width="18%" TITLE="Description:<%= StringUtil.encodeHtmlTag(description)%>,Last Comment:<%=StringUtil.encodeHtmlTag(lastcomment)%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                                                                                size="1" color="#000000"><%= company%></font></td>
                <td width="12%" TITLE="<%= mobile%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                            size="1" color="#000000"><%= phone%></font></td>
                        <%
                            if (email.length() < 42) {
                        %>
                <td width="13%" ><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email%></font></td>
                        <%
                        } else {
                        %>
                <td width="13%" ><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0, 42) + "..."%></font></td>
                        <%
                            }

                        %>
                <td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                      size="1" color="#000000"><%= leadstatus%></font></td>
                <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                     size="1" color="#000000"><%= rate%></font></td>

                <%
                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                %>
                <td width="9%" title="Last Modified On <%= modifiedOn%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                </td>
                <%
                } else {
                %>
                <td width="9%" title="Last Modified On <%= modifiedOn%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                </td>
                <%
                    }
                %>


                <td width="5%" align=center><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font>
                </td>
            </tr>

            <%
                }
            %>

            <%
                    }

                }
            %>
        </TABLE>
        <%
                }
            } catch (Exception e) {
                logger.error("Exception:" + e);
                //System.err.println(e);
            } finally {
                //MyIssue.close();
                logger.debug("closing jdbc resources in finally block");
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                    logger.info("connection closed");
                }
                if (connection.isClosed()) {
                    logger.info("Connection is Closed");
                } else {
                    logger.info("Connection not Closed");
                }

            }
        %> <%
            if (rowcount > 0) {
                if (request.getParameter("manipulation") == null && (rowcount / 16 == 0)) {
                    logger.debug("Caught in 1");
        %> <%
                            } else if (request.getParameter("manipulation") == null) {
        %>
        <table align=right>
            <tr>
                <td>First</td>
                <td>Prev</td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=3&currentUserId=<%=userid_curr%>">Next</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=4&currentUserId=<%=userid_curr%>">Last</a></td>
            </tr>
        </table>
        <%

        } else if (request.getParameter("manipulation").equals("4")) {
            logger.debug("Caught in 2");
        %>
        <table align=right>
            <tr>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=1&currentUserId=<%=userid_curr%>">First</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=2&currentUserId=<%=userid_curr%>">Prev</a></td>
                <td>Next</td>
                <td>Last</td>
            </tr>
        </table>
        <%
        } else if (request.getParameter("manipulation").equals("1")) {
        %>
        <table align=right>
            <tr>
                <td>First</td>
                <td>Prev</td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=3&currentUserId=<%=userid_curr%>">Next</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=4&currentUserId=<%=userid_curr%>">Last</a></td>
            </tr>
        </table>
        <%
        } else if (request.getParameter("manipulation").equals("3") && issuenoto == rowcount) {
            logger.debug("Caught in 3");
        %>
        <table align=right>
            <tr>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=1&currentUserId=<%=userid_curr%>">First</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=2&currentUserId=<%=userid_curr%>">Prev</a></td>
                <td>Next</td>
                <td>Last</td>
            </tr>
        </table>
        <%

        } else if (request.getParameter("manipulation").equals("3")) {
            logger.debug("Caught in 4");
        %>
        <table align=right>
            <tr>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=1&currentUserId=<%=userid_curr%>">First</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=2&currentUserId=<%=userid_curr%>">Prev</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=3&currentUserId=<%=userid_curr%>">Next</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=4&currentUserId=<%=userid_curr%>">Last</a></td>
            </tr>
        </table>
        <%

        } else if (request.getParameter("manipulation").equals("2") && issuenofrom == 1) {
            logger.debug("Caught in 5");
        %>
        <table align=right>
            <tr>
                <td>First</td>
                <td>Prev</td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=3&currentUserId=<%=userid_curr%>">Next</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=4&currentUserId=<%=userid_curr%>">Last</a></td>
            </tr>
        </table>
        <%

        } else if (request.getParameter("manipulation").equals("2")) {
            logger.debug("Caught in 6");
        %>
        <table align=right>
            <tr>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=1&currentUserId=<%=userid_curr%>">First</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=2&currentUserId=<%=userid_curr%>">Prev</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=3&currentUserId=<%=userid_curr%>">Next</a></td>
                <td><a href="<%=request.getContextPath()%>/MyCRM/adminLeadView.jsp?manipulation=4&currentUserId=<%=userid_curr%>">Last</a></td>
            </tr>
        </table>
        <%

                }
            }
        %>

    </BODY>
</HTML>
