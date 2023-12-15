<%-- 
    Document   : viewTimesheetDetails
    Created on : Mar 10, 2012, 12:35:32 PM
    Author     : Tamilvelan
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.apache.log4j.*,java.math.BigDecimal,com.eminent.timesheet.Timesheetinfo"%>
<%@page import="dashboard.* , java.applet.*,com.eminent.timesheet.Users,java.util.*,com.eminent.util.GetProjectMembers,com.eminent.timesheet.Timesheet,com.eminent.timesheet.ChartGeneration,com.eminent.timesheet.CreateTimeSheet"%>

<%@ include file="/include files/cacheRemover.jsp"%>
<%
        response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
 	response.setHeader("Pragma","no-cache");

                        //Configuring log4j properties

			

			Logger logger = Logger.getLogger("TimeSheetStatus");
			
                        String logoutcheck=(String)session.getAttribute("Name");
			if(logoutcheck==null)
			{

				%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
			}
                        int userId=(Integer)session.getAttribute("uid");


%>
<%!
                private static HashMap<Integer,String> monthSelect = new HashMap<Integer,String>();

                static{

                monthSelect.put(0,"Jan");
                monthSelect.put(1,"Feb");
                monthSelect.put(2,"Mar");
                monthSelect.put(3,"Apr");
                monthSelect.put(4,"May");
                monthSelect.put(5,"Jun");
                monthSelect.put(6,"Jul");
                monthSelect.put(7,"Aug");
                monthSelect.put(8,"Sep");
                monthSelect.put(9,"Oct");
                monthSelect.put(10,"Nov");
                monthSelect.put(11,"Dec");

            }
            int i=1,t=0;
%>
<%
            int year =  Integer.parseInt(request.getParameter("year"));
            int month=   Integer.parseInt(request.getParameter("month"));
            int assignedto  =Integer.parseInt(request.getParameter("userId"));
            int timeSheetMonth = 0;
            int timeSheetYear  = 0;

            Calendar timeSheetCal =new GregorianCalendar();


            timeSheetCal.set(timeSheetCal.MONTH,month);
            timeSheetCal.set(timeSheetCal.YEAR,year);


            timeSheetMonth =timeSheetCal.get(timeSheetCal.MONTH);
            timeSheetYear =timeSheetCal.get(timeSheetCal.YEAR);

            String timeSheetId ="T";
            if(timeSheetMonth>9){
                timeSheetId=timeSheetId+timeSheetMonth+timeSheetYear+assignedto;
             }else{
                 timeSheetId=timeSheetId+"0"+timeSheetMonth+timeSheetYear+assignedto;
             }
             logger.info("Generated Time Sheet Id >>"+timeSheetId);

             Timesheet timesheet =CreateTimeSheet.GetTimeSheetDetails(timeSheetId);

             String timeSheetOwner=GetProjectMembers.getUserName(((Integer)assignedto).toString());

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
       <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel="STYLESHEET">
    </head>

    <body>
        <table align="center" width="100%" cellpadding="0" cellspacing="0">
	<tr>

            <td width="145" align="left"><a
			href="http://www.eminentlabs.com" target="_new"><img border="0"
			alt="Eminentlabs Software Pvt. Ltd."
			src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                        <td align="right">
                <img alt="Eminentlabs Software Pvt Ltd" src="<%= request.getContextPath() %>/eminentech support files/Eminentlabs_logo.gif">
            </td>
        </tr>
</table>
            <br>
            <br>
         <table cellpadding="0" cellspacing="0" width="100%">
         <tr border="2" bgcolor="#C3D9FF">
              <td><b><%=timeSheetOwner%>'s Timesheet Approval for the month of <%=monthSelect.get(month)%> <%=" "%><%=year%></b></td>
          </tr>
         </table>
           <%
    try{
        if(timesheet!=null){
            String timesheetid      =   timesheet.getTimesheetid();
            Date requestedon        =   timesheet.getRequestedon();
            String user             =   ((Integer)userId).toString();
            String period           =     monthSelect.get(month)+" "+year;
            Users users             =    timesheet.getUsers();
            int  owner              =    users.getUserid();
            BigDecimal assigned     =    timesheet.getAssignedto();
            String approvalStatus   =   timesheet.getApprovalstatus();
            BigDecimal approval     =   timesheet.getApprovalpercentage();
            Date approvedon         =   timesheet.getApprovedon();
            String feedback         =   timesheet.getFeedback();
            String appreciation     =   timesheet.getAppreciation();
            BigDecimal approvedby   =   timesheet.getApprovedby();

            BigDecimal attendance   =   timesheet.getAttendance();
            BigDecimal workingdays  =   timesheet.getWorkingdays();
            BigDecimal attUpdated   =   timesheet.getAttendenceupdatedby();
            Date attUpdateOn        =   timesheet.getAttendenceupdatedon();
            String attendanceRemark =   timesheet.getAttendenceremark();

            String accountStatus    =   timesheet.getAccountstatus();
            BigDecimal accountUpdate=   timesheet.getAccountupdatedby();
            String accountNaration  =   timesheet.getAccountsremarks();
            Date accountUpdatedOn   =   timesheet.getAccountsupdatedon();
            String accomplishments  =   timesheet.getAccomplishments();
            String learnings        =   timesheet.getLearning();
            String suggestion       =   timesheet.getSuggestion();
            String hardship         =   timesheet.getHardship();
            String plan             =   timesheet.getPlan();




             //Approval Data Manipulation

            String requestedOn="NA";
            if(requestedon!=null){
                requestedOn=new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(requestedon);
            }
           

            String assignedTo="NA";
            if(assigned!=null){
                assignedTo=GetProjectMembers.getUserName(((BigDecimal)assigned).toString());

             }
            if(approvalStatus==null){
                approvalStatus="NA";
            }
            String approvalPercentage="NA";
            if(approval!=null){
                approvalPercentage=((BigDecimal)approval).toString();
            }
            String approvedOn="NA";
            if(approvedon!=null){
                    approvedOn=new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(approvedon);
               }
            if(feedback==null){
                feedback="NA";
            }
            if(appreciation==null){
                appreciation="NA";
               }
            String approvedBy="NA";
            if(approvedby!=null){
                approvedBy=GetProjectMembers.getUserName(((BigDecimal)approvedby).toString());
             }
              if(accomplishments==null){
                    accomplishments="NA";
              }
             if(learnings==null){
                    learnings="NA";
              }
            if(suggestion==null){
                    suggestion="NA";
              }
             if(hardship==null){
                    hardship="NA";
              }
            if(plan==null){
                plan="NA";
            }
            //Attendance Data Manipulation
            String workingDays="NA";
            if(workingdays!=null){
                workingDays=((BigDecimal)workingdays).toString();;
             }

            String attendanceValue="NA";
            if(attendance!=null){
                attendanceValue=((BigDecimal)attendance).toString()+" Days";
             }
            String attApprovedOn="NA";
            if(attUpdateOn!=null){
                    attApprovedOn=new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(attUpdateOn);
               }
            String attApprovedBy="NA";
            if(attUpdated!=null){
                attApprovedBy=GetProjectMembers.getUserName(((BigDecimal)attUpdated).toString());
             }

            if(attendanceRemark==null){
                 attendanceRemark="NA";
             }



            //Accounts Data Manipulation

            String accApprovedOn="NA";
            if(accountUpdatedOn!=null){
                    accApprovedOn=new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(accountUpdatedOn);
               }
            String accApprovedBy="NA";
            if(accountUpdate!=null){
                accApprovedBy=GetProjectMembers.getUserName(((BigDecimal)accountUpdate).toString());
             }

            if(accountNaration==null){
                accountNaration="NA";
             }

              String color[]={"white","#E8EEF7"};
    %>

          <br>
          <br>

          <table align="left" width="100%">
              <tr bgcolor="#C3D9FF"><td colspan="4" width="100%"><b>TimeSheet Approval</b></td></tr>
             <tr bgcolor="white" >
             <td width="15%" height="10"><b>TimeSheetId</b></td>  <td width="35%"><%=timesheetid%></td>  <td width="15%"><b>TimeSheet of</b></td>  <td width="35%"><%=timeSheetOwner%></td>
             </tr>
             <tr bgcolor="#E8EEF7">
                 <td height="10"><b>Requested On</b></td> <td><%=requestedOn%></td>  <td><b>Requested By</b></td>  <td><%=timeSheetOwner%></td>
             </tr>
             <tr bgcolor="white">
                 <td height="10"><b>Approval Status</b></td>       <td><%=approvalStatus%></td>    <td><b>Assigned To</b></td>  <td><%=assignedTo%></td>
             </tr>
             <tr bgcolor="#E8EEF7">
                 <td height="10"><b>Approved On</b></td>  <td><%=approvedOn%></td>  <td><b>Approved By</b></td>  <td><%=approvedBy%></td>
             </tr>
             <tr bgcolor="white">
                 <td height="10"><b>Accomplishments</b></td> <td colspan="3"><%=accomplishments%></td>
             </tr>
             <tr bgcolor="#E8EEF7">
                 <td height="10"><b>New Learnings</b></td> <td colspan="3"><%=learnings%></td>
             </tr>
             <tr bgcolor="white">
                 <td height="10"><b>Suggestions</b></td> <td colspan="3"><%=suggestion%></td>
             </tr>
             <tr bgcolor="#E8EEF7">
                 <td height="10"><b>Hardship Faced</b></td> <td colspan="3"><%=hardship%></td>
             </tr>
             <tr bgcolor="white">
                 <td height="10"><b>My Plan</b></td> <td colspan="3"><%=plan%></td>
             </tr>

             <%

                 List l =CreateTimeSheet.GetCommentDetails(timeSheetId);
                 int infoSize=l.size();
                 int s=0;
            for (Iterator f = l.iterator(); f.hasNext(); ) {
                Timesheetinfo t =(Timesheetinfo)f.next();
                Users usrs=t.getUsersByInfoby();


                int commentedbyuserid =usrs.getUserid();
                String commentedby=GetProjectMembers.getUserName(((Integer)commentedbyuserid).toString());
                String comments=t.getInfo();
                commentedby=commentedby.substring(0,commentedby.indexOf(" ")+2);
                i=s%2;
                if(i>0){
                    i=0;
                }else{
                    i=1;
                    }
            %>
            <tr bgcolor="<%=color[i]%>">
                <td ><b>Info by <%=commentedby%></b></td>
                <td colspan="3"><%=comments%></td>


            </tr>

        <%
                s++;
            }
           if(i>0){
               t=-1;
               }else{
                    t=1;
               }
        %>

        <tr bgcolor="<%=color[i+t]%>">
                 <td height="10"><b>Approval %</b></td>   <td><%=approvalPercentage%></td> <td height="10"><b>Period</b></td>       <td><%=period%></td>
             </tr>
             <tr bgcolor="<%=color[i]%>">
                 <td height="10"><b>Appreciation</b></td> <td colspan="3"><%=appreciation%></td>
             </tr>
             <tr bgcolor="<%=color[i+t]%>">
                 <td height="10"><b>Feedback</b></td>     <td colspan="3"><%=feedback%></td>
             </tr>
             <tr><td width="100%" height="20" colspan="4"></td></tr>
             <tr bgcolor="#C3D9FF"><td colspan="4"><b>Attendance Approval</b></td></tr>
             <tr bgcolor="white">
                 <td width="15%" height="10"><b>Working Days</b></td>       <td td width="30%"><%=workingDays%></td>    <td><b>Attendance</b></td>  <td><%=attendanceValue%></td>
             </tr>
             <tr bgcolor="#E8EEF7">
                 <td height="10"><b>Approved On</b></td>  <td><%=attApprovedOn%></td>  <td><b>Approved By</b></td>  <td><%=attApprovedBy%></td>
             </tr>
             <tr bgcolor="white">
                 <td height="10"><b>Remarks</b></td>   <td colspan="3"><%=attendanceRemark%></td>
             </tr>
             <tr><td width="100%" height="20" colspan="4"></td></tr>
             <tr bgcolor="#C3D9FF"><td colspan="4"><b>Accounts Approval</b></td></tr>
              <tr bgcolor="white">
                 <td width="15%" height="10"><b>Approved On</b></td>  <td td width="30%"><%=accApprovedOn%></td>  <td width="15%"><b>Approved By</b></td>  <td width="30%"><%=accApprovedBy%></td>
             </tr>
             <tr bgcolor="#E8EEF7">
                 <td width="15%" height="10"><b>Narration</b></td>   <td colspan="3"><%=accountNaration%></td>
             </tr>
              </table>

             <%
        }
        else{
            %>
            <br>
            <br>
            <br>
            <table align="center">
            <tr>
                <td width="100%"><b style="color:red">Timesheet not available for this month</b></td>
            </tr>
            </table>
            <%
            }

 }
      catch(Exception e){
          logger.error(e.getMessage());
      }
%>

    </body>
</html>
