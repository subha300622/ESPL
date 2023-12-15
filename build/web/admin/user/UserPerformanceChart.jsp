<%-- 
    Document   : userPerformanceChart
    Created on : Oct 31, 2009, 4:24:00 PM
    Author     : Administrator
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="com.eminentlabs.appraisal.AppraisalUtil"%>
<%@page import="dashboard.*,com.eminent.util.GetProjectMembers, java.applet.*,java.util.*,com.eminent.timesheet.ChartGeneration"%>
<%@ include file="/header.jsp"%>
<%!
    int userId = 0;
%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("userPerformanceChart");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }
    userId = Integer.parseInt(request.getParameter("userId"));

    int appraisalReq = AppraisalUtil.getNoOfppraisalRequestRaised(userId);
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>

        <script type="text/javascript">
                    function monthSelection()
                    {
                    var x = document.getElementById("userId").value;
                            var date = 1;
                            var startMonth = 7;
                            var startYear = 2008;
                            var startRange = new Date(startYear, startMonth, date);
                            var month = document.getElementById("month").value;
                            var year = document.getElementById("year").value;
                            var selectedValue = new Date(year, month, date);
                            var current_date = new Date();
                            var months = (current_date.getFullYear() - selectedValue.getFullYear()) * 12;
                            months -= selectedValue.getMonth();
                            months += current_date.getMonth() + 1;
                            if (months >= 12) {
                    document.getElementById('button').value = 'Processing';
                            document.getElementById('button').disabled = true;
                            window.location = '/eTracker/admin/user/UserPerformanceChart.jsp?userId=' + x + '&month=' + month + '&year=' + year;
                    } else {
                    alert("Performance chart range should be 12 months");
                    }
                    }

        </script>

    </head>
    <%!
        private static HashMap<Integer, String> monthSelect = new HashMap();

        static {

            monthSelect.put(0, "Jan");
            monthSelect.put(1, "Feb");
            monthSelect.put(2, "Mar");
            monthSelect.put(3, "Apr");
            monthSelect.put(4, "May");
            monthSelect.put(5, "Jun");
            monthSelect.put(6, "Jul");
            monthSelect.put(7, "Aug");
            monthSelect.put(8, "Sep");
            monthSelect.put(9, "Oct");
            monthSelect.put(10, "Nov");
            monthSelect.put(11, "Dec");

        }
    %>
    <body>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr bgcolor="#C3D9FF">
                <td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Performance Chart of <%=GetProjectMembers.getUserName(((Integer) userId).toString())%></b></font><select name="month" id="month">
                        <%
                            //calculating start and end date of this month
                            Calendar calDuration = new GregorianCalendar();
                            int current_Year = calDuration.get(Calendar.YEAR);
                            calDuration.add(Calendar.MONTH, -11);
                            int currYear = calDuration.get(Calendar.YEAR);
                            int currMonth = calDuration.get(Calendar.MONTH);
                            int selyear = 0;
                            int selmonth = 0;
                            if (request.getParameter("year") != null && request.getParameter("month") != null) {
                                selyear = Integer.parseInt(request.getParameter("year"));
                                selmonth = Integer.parseInt(request.getParameter("month"));
                            } else {
                                selyear = currYear;
                                selmonth = currMonth;
                            }
                            calDuration.set(Calendar.MONTH, selmonth);
                            calDuration.set(Calendar.YEAR, selyear);

                            for (int k = 0; k < monthSelect.size(); k++) {
                                if (k == selmonth) {
                        %>
                        <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                        <%
                        } else {
                        %>
                        <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                        <%
                                }

                            }
                        %>

                    </select>

                    <%
                        ArrayList<Integer> selectYears = new ArrayList();
                        int startYear = 2008;
                        logger.info("Current Years" + currYear);
                        while (startYear <= current_Year) {
                            selectYears.add(startYear);
                            startYear++;
                        }
                        logger.info("Years" + selectYears);
                    %>

                    <select name='year' id='year' >
                        <%
                            for (int k = 0, selected = 2008; k < selectYears.size(); k++, selected++) {
                                if (selected == selyear) {
                        %>
                        <option value='<%=selectYears.get(k)%>' selected><%=selectYears.get(k)%></option>
                        <%
                        } else {
                        %>
                        <option value='<%=selectYears.get(k)%>'><%=selectYears.get(k)%></option>
                        <%
                                }

                            }

                        %>
                    </select>
                    <input type="button" id="button" value="Submit" onclick="monthSelection()"></td>
            </tr>
        </table>

        <%        String Values[][] = ChartGeneration.getNewSelectedValue(userId, calDuration,request);
            String mail = GetProjectMembers.getMail(((Integer) userId).toString());
            String url = null;
            if (mail != null) {
                url = mail.substring(mail.indexOf("@") + 1, mail.length());
            }
            boolean member = GetProjectMembers.isBDMembers(userId);
            String totalPallateColors = "";
            if (url.equals("eminentlabs.net")) {
                totalPallateColors = "#FFFF00,#B404AE,#FF8000,#088A08,#0101DF,";
                if (member) {
                    totalPallateColors = totalPallateColors + "#6495ED,#B404AE,#DAA520,#800000";
                }
            } else {
                totalPallateColors = totalPallateColors + "FF8000,#088A08";
            }
        %>   

        <script type="text/javascript">

                    FusionCharts.ready(function () {
                    var hourlySalesChart = new FusionCharts({
                    type: 'msline',
                            renderAt: 'chart-container',
                            width: '990',
                            height: '450',
                            dataFormat: 'json',
                            dataSource: {

                            //Vertical divline configuration
                            "chart": {
                            "caption": "My Performance Chart",
                                    "subcaption": "Last 1 year",
                                    "xaxisname": "Month",
                                    "showvalues": "0",
                                    "paletteColors": "<%=totalPallateColors%>",
                                    "bgColor": "#ffffff",
                                    "showBorder":"0",
                                    "showcanvasborder":"0",
                                    "showXaxisline":"1",
                                    "showYAxisline":"1",
                                    "yAxisMaxvalue": "100",
                                    "yAxisMinValue": "0",
                                    "vDivLineColor": "#C3D9FF",
                                    "numVDivLines": "10",
                                    "numDivLines": "9",
                                    "showAlternateHGridColor":"0",
                                    "legendPosition":"RIGHT",
                                    "exportEnabled": "1"

                            },
                                    "categories": [
                                    {"category": [
            <%

                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
            %>
                                    { "label": "<%=month%>" },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                                    ]
                                    }
                                    ],
            <%if (url.equals("eminentlabs.net")) {%>
                            "dataset": [{"seriesname": "Working Days", "linethickness": "2", "data": [

            <%  try {

                    for (int i = 0, k = 1; i < 12; i++, k++) {

                        String work = Values[i][5];
            %>
                            { "value": "<%=work%>", },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                            ]
                            },
                            {
                            "seriesname": "Attendance",
                                    "linethickness": "2",
                                    "data": [
            <%
                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String att = Values[i][6];
            %>
                                    {
                                    "value": "<%=att%>",
                                    },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                                    ]
                            },
                            {
                            "seriesname": "Created Issues",
                                    "linethickness": "2",
                                    "data": [
            <%
                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String created = Values[i][3];
                        String mon = Values[i][4];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>
                                    {
                                    "value": "<%=created%>", "link":'<%= request.getContextPath()%>/MyTimeSheet/CreatedIssues.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>',
                                                                },
            <%
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %> ]}, { "seriesname": "Closed Issues", "linethickness": "2", "data": [
            <%try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String closed = Values[i][2];
                        String mon = Values[i][4];
                        String app = Values[i][11];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>{"value": "<%=closed%>", "link":'<%= request.getContextPath()%>/admin/user/timeSheet.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>'
                                        },
            <%
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }%>
                                ]},
                                { "seriesname": "Approval",
                                        "linethickness": "2",
                                        "data": [
            <%
                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String app = Values[i][11];
                        String mon = Values[i][4];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %> { "value": "<%=app%>", "link":'<%= request.getContextPath()%>/MyTimeSheet/TimeSheetStatus.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>', },
            <%
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>]},<%if (member) {%>
                                {
                                "seriesname": "Contacts",
                                        "linethickness": "2",
                                        "data": [
            <%
                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String mon = Values[i][4];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>
                                        {
                                        "value": "<%=Values[i][7]%>", "link":'<%= request.getContextPath()%>/MyTimeSheet/contacts.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>',
                                                                    },
            <%
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %> ]}, { "seriesname": "Leads", "linethickness": "2", "data": [

            <%try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String total = Values[i][1];
                        String closed = Values[i][2];
                        String created = Values[i][3];
                        String mon = Values[i][4];
                        String app = Values[i][5];
                        String work = Values[i][6];
                        String att = Values[i][7];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>{"value": "<%=Values[i][8]%>", "link":'<%= request.getContextPath()%>/MyTimeSheet/leads.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>'
                                        },
            <%
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }%>
                                ]},
                                { "seriesname": "Opportunities",
                                        "linethickness": "2",
                                        "data": [
            <%
                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String total = Values[i][1];
                        String closed = Values[i][2];
                        String created = Values[i][3];
                        String mon = Values[i][4];
                        String app = Values[i][5];
                        String work = Values[i][6];
                        String att = Values[i][7];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %> { "value": "<%=Values[i][9]%>", "link":'<%= request.getContextPath()%>/MyTimeSheet/opportunities.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>', },
            <%
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %> ]}, {
                                "seriesname": "Accounts",
                                        "linethickness": "2",
                                        "data": [
            <%
                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String mon = Values[i][4];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>
                                        {
                                        "value": "<%=Values[i][10]%>", "link":'<%= request.getContextPath()%>/MyTimeSheet/accounts.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>',
                                                                    },
            <%
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }%>]},
            <%}
            } else { %>
                                                            "dataset": [{
                                                            "seriesname": "created",
                                                                    "linethickness": "2",
                                                                    "data": [
            <%
                try {

                    for (int i = 0, k = 1; i < 12; i++, k++) {

                        String month = Values[i][0];
                        String total = Values[i][1];
                        String closed = Values[i][2];
                        String created = Values[i][3];
                        String mon = Values[i][4];
                        String app = Values[i][5];
                        String work = Values[i][6];
                        String att = Values[i][7];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>{"value": "<%=created%>", "link":"<%= request.getContextPath()%>/MyTimeSheet/CreatedIssues.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>", },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                                        ]
                                },
                                {
                                "seriesname": "",
                                        "linethickness": "2",
                                        "data": [
            <%
                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String total = Values[i][1];
                        String closed = Values[i][2];
                        String created = Values[i][3];
                        String mon = Values[i][4];
                        String app = Values[i][5];
                        String work = Values[i][6];
                        String att = Values[i][7];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>{"value": "<%=total%>", "link":"<%= request.getContextPath()%>/timeSheet.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>", },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                                        ]
                                },
                                {
                                "seriesname": "Closed",
                                        "linethickness": "2",
                                        "data": [
            <%
                try {
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];
                        String total = Values[i][1];
                        String closed = Values[i][2];
                        String created = Values[i][3];
                        String mon = Values[i][4];
                        String app = Values[i][5];
                        String work = Values[i][6];
                        String att = Values[i][7];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>{"value": "<%=closed%>", "link":'<%= request.getContextPath()%>/MyTimeSheet/ClosedIssues.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>', },
            <%
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }%>]},
            <%}%>

                                ]
                                }
                                }).render();
                                });</script>


        <div id="chart-container" class="chartarea"></div>
        <form name="theForm">
            <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="0"
                   align="center">


                <tr>
                    <td><font face="Book Antiqua"><b>Select Dashboard of : </b></font></td>
                    <td><select id="userId" name="userId" size=1 onchange="javascript:call(this.form)">
                            <%
                                int role = (Integer) session.getAttribute("Role");
                                ArrayList<String> al = null;
                                if (role == 1) {
                                    al = CountIssue.getAllUsers();
                                }
                                int getUser = 0;

                                for (int i = 0; i < al.size(); i += 2) {

                                    getUser = Integer.parseInt(al.get(i));
                                    if (getUser == userId) {
                            %>
                            <option value="<%= getUser%>" selected><%= al.get(i + 1)%>
                                <%

                                } else {
                                %>

                            <option value="<%= getUser%>"><%= al.get(i + 1)%> <%
                                    }
                                }
                                %>
                        </select>
                    </td>
                    <%
                        if (url.equals("eminentlabs.net") && appraisalReq == 0) {
                    %>
                    <td><a href="<%= request.getContextPath()%>/admin/appraisal/initiateAppRequest.jsp?userId=<%=userId%>">Initiate Appraisal Process</a></td>
                    <%}%>

                </tr>
            </table>
        </form>
                    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>
</html>
