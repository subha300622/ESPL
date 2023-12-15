<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,com.eminent.util.*"%>
<%
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("waitingLead");
	
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
            logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
<script language="JavaScript">
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}	
</script>
<script language="JavaScript">
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}
	
	var form='showleads' //form name

	function SetChecked(val,chkName) 
	{
		dml=document.forms[form];
		len = dml.elements.length;
		var i=0;
		for( i=0 ; i<len ; i++) 
		{
			if (dml.elements[i].name==chkName) 
			{
				dml.elements[i].checked=val;
			}
		}
	}

	function ValidateForm(dml,chkName)
	{
		len = dml.elements.length;
		var i=0;
		for( i=0 ; i<len ; i++) 
		{
			if ((dml.elements[i].name==chkName) && (dml.elements[i].checked==1)) return true
                        
		}
		alert("Please select at least one record to be approved/denied")
		return false;
	}
        

</script>

</head>
<body>
<%@ page import="java.sql.*"%>
<%! 
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%@ include file="/header.jsp"%>
<form name="searchContact" onsubmit="return check(this);"
	action="searchContact.jsp">
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr>
		<td align="left"><font size="4" COLOR="#0000FF"><b>Disabled Contacts
		</b> </font>
		<td align="center"><b>Enter the Name or Account Name:</b></td>
		<td align="left"><input type="text" name="contactName"
			maxlength="20" size="15"></td>
		<td><input type="submit" name="submit" value="Search"></td>
		<td><input type="reset" name="reset" value="Reset"></td>
		<td></td>
	</tr>
</table>
</form>

<% 

	session.setAttribute("forwardpage","disabledContacts.jsp");
	Connection  connection = null;
	Statement st=null;
	ResultSet rs=null;
	try
    {
		connection=MakeConnection.getConnection();
		logger.debug("Connection has been created:"+connection);
	
		if(connection != null)  
		{
			int x=-2;
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("SELECT CONTACTID, FIRSTNAME, LASTNAME, ACCOUNTNAME,TITLE, PHONE, EMAIL,CONTACT_OWNER from contact where roleid='"+x+"' order by FIRSTNAME ASC");
			rs.last();
			int rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			pageone=rowcount/15;
			pageremain=rowcount%15;
					
			if(pageremain>0)
			{
				totalpage=pageone+1;
			}
			else
			{
				totalpage=pageone;	
			}
			try
			{
				String requestpag=request.getParameter("manipulation");
				logger.debug("Requested Page:"+requestpag);
				if(requestpag!=null)
				{
					requestpage=Integer.parseInt(requestpag);
					if(requestpage==1)
					{
						presentpage=1;
						rs.beforeFirst();
						logger.debug("Requested page First"+presentpage);	
						issuenofrom=1;
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
							extra=issuenoto-rowcount;
							issuenoto=issuenoto-extra;
						}
					}
					if(requestpage==2)
					{
						presentpage=presentpage-1;
						if(presentpage<=0)
						{
							presentpage=1;
						}
						if(presentpage==1)
						{
							rs.beforeFirst();
							issuenofrom=1;
							issuenoto=issuenofrom+14;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}
						}
						else
						{
						    issuenofrom=((presentpage-1)*15+1);
							rs.absolute(issuenofrom-1);	
							issuenoto=issuenofrom+14;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}
						}
						logger.debug("Requested page Prev"+presentpage);					
					}
					if(requestpage==3)
					{
						presentpage=presentpage+1;
						if(presentpage>=totalpage)
						{
							presentpage=totalpage;
						}
						issuenofrom=((presentpage-1)*15+1);
						rs.absolute(issuenofrom-1);	
						logger.debug("Requested page Next"+presentpage);		
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
					}
					if(requestpage==4)
					{
						presentpage=totalpage;
						logger.debug("Requested page Last"+presentpage);
						issuenofrom=((presentpage-1)*15+1);
						rs.absolute(issuenofrom-1);	
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
					}
				}
				else
				{
					presentpage=1;
					issuenofrom=1;
					rs.beforeFirst();
					issuenoto=issuenofrom+14;
					if(issuenoto>rowcount)
					{
					    extra=issuenoto-rowcount;
					    issuenoto=issuenoto-extra;
					}
				}
		   }
		   catch(Exception e)
		   {
		   		logger.error("Exception:"+e);
		   }
			if(request.getParameter("newContact")!=null)
			{
%>

<table width="100%" align=center border="0" bgcolor="E8EEF7">
	<tr>
		<td align=center><FONT SIZE="4" COLOR="#33CC33">New
		Contact has been added successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("company")%></FONT>
		</td>
	</tr>
</table>
<%
			}
%>
<TABLE width="100%" border="0">
	<tr>
		<td>
                    <a href="<%=request.getContextPath() %>/admin/customer/addnewcontact.jsp">Add Contact</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath() %>/admin/customer/viewcontact.jsp">View Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath() %>/admin/customer/waitingContacts.jsp">Approve Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath() %>/admin/customer/deniedContacts.jsp">Denied Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <b><a href="javascript:void(0)">Disabled Contacts</a></b>
                </td>


		<%
			if(rowcount==0)
			{
%>
			<table width="100%" height="70%" align="center">
			<tr>
				<td><font face="Tahoma" size="5" color="red">
				<h3 align="center"><%= "No disabled contacts" %></h3>
				</font></td>
			</tr>
		</table>
		<%
			}
			else
			{
%>
		<td width="20%" colspan=3>Displaying&nbsp;<%=issuenofrom%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
		
		<td align="right"><a href="javascript:SetChecked(1,'approve')"><font
			face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
			href="javascript:SetChecked(0,'approve')"><font
			face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
	</tr>
</TABLE>
<br>
<form name="showleads" action="approveContacts.jsp"
	onSubmit="return ValidateForm(this,'approve')">
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
		<TD width="18%"><font><b>Name</b></font></TD>
		<TD width="13%"><font><b>Account Name</b></font></TD>
		<TD width="15%"><font><b>Title</b></font></TD>
		<TD width="15%"><font><b>Phone</b></font></TD>
		<TD width="18%"><font><b>Email</b></font></TD>
		<TD width="12%"><font><b>Owner</b></font></TD>
		
	</TR>

	<%
			String fname="",lname="",title="",account="",email="",phone="",fullname="",owner=null;
			int contactid=9999;
			if(rs!=null)
			{ 
			    for(int i=1;i<=15;i++)
				{
					if(rs.next())
					{
						contactid=rs.getInt("contactid");
						fname=rs.getString("firstname");
						if (fname==null)
							fname="";
						lname=rs.getString("lastname");
						if (lname==null)
							lname="";
                                                fullname=fname+" "+lname;
						title=rs.getString("title");
						if (title==null)
							title="nil";
						account=rs.getString("accountname");
						if (account==null)
							account="nil";
						email=rs.getString("email");
						if (email==null)
							email="";
						phone=rs.getString("phone");
						if (phone==null)
							phone="nil";
						
						String own		= rs.getString("contact_owner");
                        owner="NA";
                        if(own!=null){
                        	owner    = GetProjectManager.getUserName(Integer.parseInt(own));
                        }
                        
						if(( i % 2 ) != 0)                    
                                                {
%>
	<tr bgcolor="white" height="21">
		<%
						}
                                                else
                                                {
%>
	
	<tr bgcolor="#E8EEF7" height="21">
		<%
						}
                                                if (fullname.length()<25)
                                                    {
%>
		<td width="20%"><input type="checkbox" name="approve" value="<%= email %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A
			HREF="editContact.jsp?contactid=<%=contactid%>"><%= fullname%></A></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                        %>
		<td width="20%"><input type="checkbox" name="approve" value="<%= email %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A
			HREF="editContact.jsp?contactid=<%=contactid%>"><%= fullname.substring(0,25)+"..." %></A></font></td>
		<%
                                                        }
                                                        %>
		<td width="13%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(account) %></font></td>
		<%
                                                        if (title.length()<15)
                                                    {
 %>
		<td width="15%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(title) %></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                            %>
		<td width="15%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= title.substring(0,15)+"..." %></font></td>
		<%
                                                            }
                                                            %>
		<td width="15%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= phone %></font></td>
		<%if (email.length()<20)
                                                    {
 %>
		<td width="24%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email) %></font></td>
		<%
                                                        }else
                                                            {
                                                            %>
		<td width="24%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0,20)+"..." %></font></td>
		<%
                                                            }
                                                            %>
		<%if (owner.length()<15)
                                                    {
 		%>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(owner) %></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                            %>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= owner.substring(0,15)+"..." %></font></td>
		<%
                                                            }
                                                            %>
		

	</tr>

	<% 
					}
				}
			}
			if(rowcount>0)
			{
				%>
	<tr>
		<td colspan="6" align="center"><input type="submit" name="submit"
			value="Enable"></td>
	</tr>
	<%
			}
			
			if(request.getParameter("manipulation")==null && (rowcount/16==0))
			{
%>

	<%
			}
			else if(request.getParameter("manipulation")==null)
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=disabledContacts.jsp?manipulation=3>Next</a></td>
			<td><a href=disabledContacts.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("1"))
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=disabledContacts.jsp?manipulation=3>Next</a></td>
			<td><a href=disabledContacts.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}	
			else if(request.getParameter("manipulation").equals("4"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=disabledContacts.jsp?manipulation=1>First</a></td>
			<td><a href=disabledContacts.jsp?manipulation=2>Prev</a></td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("3") && issuenoto==rowcount)
			{
%>
	<table align=right>
		<tr>
			<td><a href=disabledContacts.jsp?manipulation=1>First</a></td>
			<td><a href=disabledContacts.jsp?manipulation=2>Prev</a></td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("3"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=disabledContacts.jsp?manipulation=1>First</a></td>
			<td><a href=disabledContacts.jsp?manipulation=2>Prev</a></td>
			<td><a href=disabledContacts.jsp?manipulation=3>Next</a></td>
			<td><a href=disabledContacts.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2") && issuenofrom == 1)
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=disabledContacts.jsp?manipulation=3>Next</a></td>
			<td><a href=disabledContacts.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=disabledContacts.jsp?manipulation=1>First</a></td>
			<td><a href=disabledContacts.jsp?manipulation=2>Prev</a></td>
			<td><a href=disabledContacts.jsp?manipulation=3>Next</a></td>
			<td><a href=disabledContacts.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}

			}
		}
    }
	catch(Exception e)
	{
            logger.error(e.getMessage());
	}	
	finally
	{
		if(rs!=null)
			rs.close();
		if(st!=null)
			st.close();
        if(connection!=null)
			connection.close();
		logger.debug("Closing JDBC Resources");
	}
%>
</table>
</form>
</body>
</html>