<%-- 
    Document   : gnattIssuesSummary
    Created on : 08 Jun, 2016, 4:00:25 PM
    Author     : E0307
--%>

<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=11" type="text/css" rel="STYLESHEET"/>
   <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>   
     
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=2">
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>


        <title></title>

    </head>
    <body>
    <jsp:useBean id="pic" class="com.eminentlabs.chart.GnattChart"></jsp:useBean>       
        <%pic.getIssuesByUserWeek(request);%>
        <div class="tablecontent">
            <div>The below list shows <%=pic.getIssuesList().size()%> issues</div>
            <TABLE width="100%" id="filtersort" class="tablesorter">
                <thead>
                    <TR bgcolor="#C3D9FF">
                        <td width="1%" class="filter-false" TITLE="Severity"><font><b>S</b></font></td>
                        <td width="11%"><font><b>Issue No</b></font></td>
                        <td width="2%" class="filter-false"  TITLE="Priority"><font><b>P</b></font></td>
                        <td width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></td>
                        <td width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></td>
                        <td width="25%" ><font><b>Subject</b></font></td>
                        <td width="12%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></td>
                        <td width="8%" class="filter-false"><font><b>Due Date</b></font></td>
                        <td width="13%" data-placeholder="Select AssignTo"><font><b>Assigned To</b></font></td>
                        <td width="9%" class="filter-false"><font><b>Refer</b></font></td>
                        <td width="2%" TITLE="In Days"  data-placeholder="Try >10"><font><b>Age</b></font></td>
                    </TR>
                </thead>
                <tbody>
                    <%int i = 0;
                        for (IssueFormBean isfb : pic.getIssuesList()) {
                            if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="21">
                        <%} else {%>
                    <tr class="zebraline" height="21">
                        <%}
                            i++;%>

                        <td   style="background-color :<%=isfb.getSeverity()%>;">&nbsp;</td>
                        <td  class="background" title="<%=isfb.getType()%>"><a target="_blank" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=isfb.getIssueId()%>">

                                <%=isfb.getIssueId()%></a>
                              
                        </td>
                        <td class="background"><%=isfb.getPriority()%></td>
                        <td class="background" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                        <td class="background" width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                        <td class="background" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
                        <td class="background" onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;"><%=isfb.getStatus()%></td>
                        <td class="background" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                        <td class="background" title="<%=isfb.getCreatedBy()%>"><%=isfb.getAssignto()%></td>
                        <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                        <td class="background" ><%=isfb.getRefer()%></td>
                        <%} else {%>
                        <td class="background" ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                            <%}%>
                        <td class="background" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>

                    <%
                        }%>
                </tbody>
            </table>
        </div>
        <div id="MDAVpopup" class="popup">
            <h3 class="popupHeading">View Attached Files</h3>
            <div>
                <div class="clear"></div>
                <div class="tableshow">
                    <div id="IssuePopupFiles">

                    </div>
                    <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript">
        $.tablesorter.addParser({
            id: "ddMMMyy",
            is: function (s) {
                return false;
            },
            format: function (s, table) {
                var from = s.split("-");
                var year = "20" + from[2];
                var mon = from[1];
                var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                return new Date(year, month, from[0]).getTime() || '';
            },
            type: "numeric"
        });
        $(document).ready(function ()
        {
            
            
            
            // call the tablesorter plugin
            $("#filtersort").tablesorter({
                theme: 'blue',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
                // initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                headers: {7: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMMyy'
                    }},
                widgetOptions: {
                    // extra css class applied to the table row containing the filters & the inputs within that row
                    filter_cssFilter: 'tablesorter-filter',
                    // If there are child rows in the table (rows with class name from "cssChildRow" option)
                    // and this option is true and a match is found anywhere in the child row, then it will make that row
                    // visible; default is false
                    filter_childRows: false,
                    // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    filter_hideFilters: false,
                    // Set this option to false to make the searches case sensitive
                    filter_ignoreCase: true,
                    // jQuery selector string of an element used to reset the filters
                    filter_reset: '.reset',
                    // Use the $.tablesorter.storage utility to save the most recent filters
                    filter_saveFilters: false,
                    // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                    // every character while typing and should make searching large tables faster.
                    filter_searchDelay: 300,
                    // Set this option to true to use the filter to find text from the start of the column
                    // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                    filter_startsWith: false,
                    // if false, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    // Add select box to 4th column (zero-based index)
                    // each option has an associated function that returns a boolean
                    // function variables:
                    // e = exact text from cell
                    // n = normalized value returned by the column parser
                    // f = search filter input value
                    // i = column index
                    filter_functions: {
                    },
                    filter_formatter: {
                        8: function ($cell, indx) {
                            return $.tablesorter.filterFormatter.select2($cell, indx, {
                                match: false // exact match only
                            });
                        }
                    }
                }
                
            });
        });
    </script>
</html>
