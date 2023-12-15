<%@page import="com.eminent.util.IssueDetails"%>
<%
        
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%
	}
%>
<%@ page import="org.apache.commons.fileupload.*,org.apache.log4j.*, org.apache.commons.fileupload.servlet.ServletFileUpload, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.io.FilenameUtils, java.util.*, java.io.File,com.eminent.util.StatusSelector, java.lang.Exception"%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="multipart/form-data;">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
<script language="JavaScript">
	function check()
	{
  		if (confirm("Do you want to attach another File"))
		{
				var attach='yes';
				location = 'fileAttach.jsp?attach='+attach
		} 
		else
		{
			var attach='no';
			location='fileAttach.jsp?attach='+attach
		}
		
	}
function printpost(post)
{
	pp = window.open('UserProfile/profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
	pp.focus();
}
</script>
</head>

<%@ page import="java.io.*,pack.eminent.encryption.*,com.pack.StringUtil"%>

<%@page import="java.sql.*"%>

<body onload="check()" bgcolor="#FFFFFF">
<%@ include file="header.jsp"%>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100%" valign="top" height="525"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> </font>
                        <%
		Connection con = null;
		Statement stmt11=null;	
		ResultSet rs11=null;
		String saveFile = null;
		
		Logger logger = Logger.getLogger("File Upload");
	
try
{
	con=MakeConnection.getConnection();
        
        logger.info("Other Form data-->"+request.getParameter("filevalue"));
        if (ServletFileUpload.isMultipartContent(request))
        {
                  logger.info("Multi part content");
                  ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                  List fileItemsList = servletFileUpload.parseRequest(request);
                  ServletContext context = pageContext.getServletContext();
                  String filePath = context.getInitParameter("file-upload");
                  logger.info("Upload Path-->"+filePath);
                  logger.info("No of Files-->"+fileItemsList.size());
                  String optionalFileName = "";
                  FileItem fileItem = null;

                  Iterator it = fileItemsList.iterator();
                  while (it.hasNext()){
                    FileItem fileItemTemp = (FileItem)it.next();
                    if (fileItemTemp.isFormField()){
                %>
<!--                <b>Name-value Pair Info:</b><br/>
                Field name: <%= fileItemTemp.getFieldName() %><br/>
                Field value: <%= fileItemTemp.getString() %><br/><br/>-->
                <%
                      if (fileItemTemp.getFieldName().equals("filename"))
                        optionalFileName = fileItemTemp.getString();
                    }
                    else
                      fileItem = fileItemTemp;
                  }

                  if (fileItem!=null){
                    String fileName = fileItem.getName();
                %> <b>Uploaded File Info:</b><br />
		Content type: <%= fileItem.getContentType() %><br />
		<!--              Field name: <%= fileItem.getFieldName() %><br/>    -->
		File name: <%= fileName %><br />
		File size: <%= fileItem.getSize() %><br />
		<br />

		<%
                    /* Save the uploaded file if its size is greater than 0. */
                    if (fileItem.getSize() > 0& fileItem.getSize()<12582912)
                    {
                      if (optionalFileName.trim().equals(""))
                        fileName = FilenameUtils.getName(fileName);
                      else
                        fileName = optionalFileName;
                        
                     String issueId = (String)session.getAttribute("issueIdToAttach");
                     String contextRootPath = this.getServletContext().getRealPath("/");
                     File outputFile1 = new File(contextRootPath, "/Etracker_AttachedFiles/");
                     boolean dir=outputFile1.mkdir();
 //                     String dirName = contextRootPath+"/Etracker_AttachedFiles/";
                      String dirName    =   filePath;
                      logger.info("Dir Name"+dirName);
                      int count=IssueDetails.displayFiles(issueId);
                      count=count+1;
                      File saveTo = new File(dirName +count+"."+issueId+"_"+StringUtil.convertSpecialCharacters(fileName));
                      saveFile=count+"."+issueId+"_"+StringUtil.convertSpecialCharacters(fileName);
                      logger.info("File Name------------>"+saveFile);
                      try {
                        fileItem.write(saveTo);
                %> <b>The uploaded file has been saved successfully.</b>

		<%
                      stmt11=con.createStatement();
 		rs11 = stmt11.executeQuery("select fid_seq.nextval from dual");
 		
 		
 		
 		java.util.Date d = new java.util.Date();

		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		//Timestamp ts = new Timestamp(cal.getTimeInMillis());
		Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());

		int owner=((Integer)session.getAttribute("uid")).intValue();

		String status= null;
                if(issueId.startsWith("E")){
                    status  =   StatusSelector.getStatus(issueId);
                }else if(issueId.startsWith("R")){
                    status  =   StatusSelector.getResourceRequestStatus(issueId);
                }
                else{
                    status  =   StatusSelector.getStatus(issueId);
                }
                logger.info("File upload status"+status);
		if(rs11!=null)
		{
			while(rs11.next()) 
			{
				String st11 = rs11.getString("nextval");		        
				int fileid=Integer.parseInt(st11);
				PreparedStatement state6=con.prepareStatement("insert into fileattach(fileid,issueid,filename,owner,attacheddate,issuestatus) values(?,?,?,?,?,?)");//CHANGED
				
				state6.setInt(1,fileid);
				state6.setString(2,issueId);
				state6.setString(3,saveFile);
				state6.setInt(4,owner);
				state6.setTimestamp(5,ts);
                                state6.setString(6,status);
				state6.executeUpdate();
				con.commit();
			}
           
		}else{
			logger.info("RESULT SET IS NULL");
		}
                      }
                      catch (Exception e){
                %> <b><font color="red">An error occurred
		when we tried to save the uploaded file.</font></b> <%
                      logger.error(e.getMessage());
                      }
                    } else if(fileItem.getSize() == 0) {
                         %>
                            <b><font color="red">
                                The size of the file you were trying to upload is 0. Please upload file with content</font></b>
                         <%
                    } else {
                         %>
                            <b><font color="red">
                                The file you were trying to upload exceeds 12MB.Please upload file less than 12MB</font></b>
                         <%
                    }
                  }else{
                       %>
                            <b><font color="red">
                                The file you were trying to upload is not available</font></b>
                         <%
                  }
                }
           

        

		

	
}catch(Exception ex)
{
	logger.error(ex.getMessage());
}finally
				{
					if (con!=null)
					{
						con.close();
					}
				}
%>
</table>
</body>

</html>
