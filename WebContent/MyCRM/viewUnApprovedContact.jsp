<%-- 
    Document   : viewUnApprovedContact
    Created on : 31 Oct, 2011, 4:57:55 PM
    Author     : Tamilvelan
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*,java.util.*,com.eminent.util.*,org.apache.log4j.*,java.text.*"%>
<%


	Logger logger = Logger.getLogger("Add New Contact");
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type=text/css rel=STYLESHEET>
<title>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS Solution</title>

<script type="text/javascript"	src="<%= request.getContextPath() %>/eminentech support files/simpleUtilities.js"></script>
<script type="text/javascript"	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script type="text/javascript"  src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>

<script type="text/javascript">
function createRequest(){
	var reqObj = null;
	try {
	   reqObj = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch (err) {
	   try {
		reqObj = new ActiveXObject("Microsoft.XMLHTTP");
	   }
	   catch (err2) {
			try {
			   reqObj = new XMLHttpRequest();
			}
			catch (err3) {
			  reqObj = null;
			}
   		}
	}
	return reqObj;
}
function moveContact()
{
    if(document.theForm.movetolead.checked==true){
        if (confirm("Do you want to Move Lead"))
        {
            xmlhttp = createRequest();
            if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
                xmlhttp = new XMLHttpRequest();
            }
            if(xmlhttp != null) {

                var contactmail = theForm.email.value;
                xmlhttp.open("GET","leadCheck.jsp?name="+contactmail+"&rand="+Math.random(1,10), true);
                xmlhttp.onreadystatechange = userAlert;
                xmlhttp.send(null);
            }
            document.theForm.movetolead.checked=true;
        }
        else
        {
            document.theForm.movetolead.checked=false;
        }
    }
}
function userAlert() {

        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {

            var module = xmlhttp.responseText.split(",");
            var flag = module[1];

            if(flag == 'yes'){

                alert("Selected Contact Name Already Exists in CRM Lead");
                document.theForm.movetolead.checked = false;
                theForm.title.focus();
            }
            else{
               theForm.movetolead.checked = true;
            }


      	}
	}
}
function trim(str)
{
        while (str.charAt(str.length - 1)==" ")
   	str = str.substring(0, str.length - 1);
  	while (str.charAt(0)==" ")
    	str = str.substring(1, str.length);
  	return str;
}

function isDate(str)
{
	var pattern = "1234567890-"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}

function isNumber(str)
{
	var pattern = "0123456789.+- "
	var i = 0;
	do
    {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                {
					pos = 1;
       				break;
      			}
    			i++;
 	}
 	while (pos==1 && i<str.length)
 	if (pos==0)
    		return false;
 	return true;
}

	/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

function isPositiveInteger(str)
{
	var pattern = "abcdefghijklmnopqrstuvwxyz,.?:;[]{}!@#$&*()-_+ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}
function isPositiveInteger1(str)
{
	var pattern = "abcdefghijklmnopqrstuvwxyz.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
	var i = 0;
	do
        {
    		var pos = 0;
    		for (var j=0; j<pattern.length; j++)
      			if (str.charAt(i)==pattern.charAt(j))
                        {
				pos = 1;
        			break;
      			}
    			i++;
  	}
  	while (pos==1 && i<str.length)
  	if (pos==0)
    		return false;
  	return true;
}



	/** Function To Validate The Input Form Data */
function fun(theForm)
{

	if (trim(theForm.title.value)=='')
    {
		alert('Please enter the Title ');
	document.theForm.title.value="";
            theForm.title.focus();
            return false;
	}
	if (!isPositiveInteger1(trim(theForm.title.value)))
    {
		alert('Please enter the AlphaNumerical only in the Title ');
	document.theForm.title.value="";
            theForm.title.focus();
            return false;
	}
	if (trim(theForm.firstname.value)=='' )
	{
		alert('Please enter the First Name ');
		document.theForm.firstname.value="";
   		theForm.firstname.focus();
   		return false;
	}
	if (!isPositiveInteger1(trim(theForm.firstname.value)))
	{
		alert('Please enter the AlphaNumerical Characters only in the First Name ');
		document.theForm.firstname.value="";
   		theForm.firstname.focus();
   		return false;
	}
        if ((theForm.lastname.value)=='')
	{
		alert('Please enter the Last Name');
		document.theForm.lastname.value="";
		theForm.lastname.focus();
   		return false;
	}
	if (!isPositiveInteger1(trim(theForm.lastname.value)))
	{
		alert('Please enter the Last Name with AlphaNumerical only');
		document.theForm.lastname.value="";
		theForm.lastname.focus();
   		return false;
	}
	if (trim(theForm.phone.value)=='')
	{
		alert('Please enter the Phone ');
		document.theForm.phone.value="";
   		theForm.phone.focus();
   		return false;
	}
	if (!isNumber(trim(theForm.phone.value)))
	{
		alert('Please enter the Numerical Characters only in the Phone ');
		document.theForm.phone.value="";
   		theForm.phone.focus();
   		return false;
	}



	if (trim(theForm.email.value)=='')
        {
   		alert('Please enter the valid Email ');
		document.theForm.email.value="";
                theForm.email.focus();
                return false;
  	}
        if (!isPositiveInteger(trim(theForm.email.value)))
        {
   		alert('Please enter the AlphaNumerical only in the Email ');
		document.theForm.email.value="";
                theForm.email.focus();
                return false;
  	}
        if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(theForm.email.value)))
 	{
		alert("Invalid E-mail Address! Please re-enter.")
		document.theForm.email.value="";
    		theForm.email.focus();
    		return (false);
	}
 	var mail=theForm.email.value;
	var user=mail.indexOf('@');
    	var len=mail.length;
	var id=mail.substring(user+1,len);
	var id1=mail.substring(0,user-1);

	if( !( (user>=0)))  {
	  		alert('Enter the valid Email Address');
	 		document.theForm.email.value="";
   			theForm.email.focus();
                        return false;
        }

        if (len<5)  {
   			alert('Size of the Email should be more than 4 charactes ');
  			document.theForm.email.value="";
                        theForm.email.focus();
                        return false;
  	}
        if (document.getElementById('assignedto').value == '--Select One--')
        {
	        alert("Please choose a Assigned to Name");
	        document.getElementById('assignedto').focus();
	        return false;
        }
        if (trim(theForm.mobile.value)=='')
    	{
    		alert('Please enter Mobile ');
    		document.theForm.mobile.value="";
       		theForm.mobile.focus();
       		return false;
    	}
      	if (!isNumber(trim(theForm.mobile.value)))
    	{
    		alert('Please enter the Numerical Characters only in the Mobile ');
    		document.theForm.mobile.value="";
       		theForm.mobile.focus();
       		return false;
    	}
        if (trim(theForm.company.value)=='')
        {
   		alert('Please enter the Company ');
		document.theForm.company.value="";
                theForm.company.focus();
                return false;
  	}

	if (!isPositiveInteger(trim(theForm.company.value)))
        {
   		alert('Please enter the AlphaNumerical only in the Company ');
		document.theForm.company.value="";
                theForm.company.focus();
                return false;
  	}
        if(!(theForm.personalemail.value=='')){
            if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(theForm.personalemail.value)))
            {
                    alert("Invalid Personal E-mail Address! Please re-enter.")
                    document.theForm.personalemail.value="";
                    theForm.personalemail.focus();
                    return (false);
            }
        }

	if (!isPositiveInteger(trim(theForm.reportsto.value)) && trim(theForm.reportsto.value)!='')
        {
   		alert('Please enter the AlphaNumerical only in the Reports To ');
		document.theForm.reportsto.value="";
                theForm.reportsto.focus();
                return false;
  	}
	if (document.getElementById('accounts').value == '--Select Account--')
    {
        alert("Please choose a Account Name");
        document.getElementById('accounts').focus();
        return false;
    }
	 if (trim(document.theForm.duedate.value)== "")
	    {
	        alert ("Please Enter the Due Date ");
	        document.theForm.duedate.focus();
	        return false;
	    }
	    if (!isDate(trim(theForm.duedate.value)))
	    {
	        alert('Please enter the valid Due Date');
		document.theForm.duedate.value="";
	        theForm.duedate.focus();
	        return false;
	    }
	    var str   = document.theForm.duedate.value;
	                var first = str.indexOf("-");
	                var last  = str.lastIndexOf("-");
	                var year         = str.substring(last+1,last+5);
	                var month        = str.substring(first+1,last);
	                var date         = str.substring(0,first);
	                var form_date    = new Date(year,month-1,date);
	                var current_date = new Date();

	                var current_year  = current_date.getYear();
	                var current_month = current_date.getMonth();
	                var current_date  = current_date.getDate();
	                var today = new Date(current_year,current_month,current_date);

	    if(form_date < today){
	        alert('Due Date cannot be less than Today');
		document.theForm.duedate.value="";
	        theForm.duedate.focus();
	        return false;
	    }

	if (!isPositiveInteger(trim(theForm.mailingstreet.value)) && trim(theForm.mailingstreet.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Street ');
		document.theForm.mailingstreet.value="";
        theForm.mailingstreet.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.mailingcity.value)) && trim(theForm.mailingcity.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the City ');
		document.theForm.mailingcity.value="";
        theForm.mailingcity.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.mailingstate.value)) && trim(theForm.mailingstate.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the State ');
		document.theForm.mailingstate.value="";
        theForm.mailingstate.focus();
        return false;
  	}
	if (!isNumber(trim(theForm.mailingzip.value)) && trim(theForm.mailingzip.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Zip ');
		document.theForm.zip.value="";
        theForm.zip.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.mailingcountry.value)) && trim(theForm.mailingcountry.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Country ');
		document.theForm.mailingcountry.value="";
        theForm.mailingcountry.focus();
        return false;
  	}
/*  	if (!isPositiveInteger(trim(theForm.otherstreet.value)) && trim(theForm.otherstreet.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the otherstreet ');
		document.theForm.otherstreet.value="";
        theForm.otherstreet.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.othercity.value)) && trim(theForm.othercity.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the othercity ');
		document.theForm.othercity.value="";
        theForm.othercity.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.otherstate.value)) && trim(theForm.otherstate.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the otherstate ');
		document.theForm.mailingstate.value="";
        theForm.mailingstate.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.otherzip.value)) && trim(theForm.otherzip.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the otherzip ');
		document.theForm.zip.value="";
        theForm.zip.focus();
        return false;
  	}
	if (!isPositiveInteger(trim(theForm.othercountry.value)) && trim(theForm.othercountry.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the othercountry ');
		document.theForm.othercountry.value="";
        theForm.othercountry.focus();
        return false;
  	}
  	*/
	if (!isNumber(trim(theForm.fax.value)) && trim(theForm.fax.value)!='')
	{
		alert('Please enter the Numerical Characters only in the Fax ');
		document.theForm.fax.value="";
   		theForm.fax.focus();
   		return false;
	}
	if (!isNumber(trim(theForm.homephone.value)) && trim(theForm.homephone.value)!='')
	{
		alert('Please enter the Numerical Characters only in the Home Phone ');
		document.theForm.homephone.value="";
   		theForm.homephone.focus();
   		return false;
	}
	if (!isNumber(trim(theForm.otherphone.value)) && trim(theForm.otherphone.value)!='')
	{
		alert('Please enter the Numerical Characters only in the Other Phone ');
		document.theForm.otherphone.value="";
   		theForm.otherphone.focus();
   		return false;
	}

	if (!isPositiveInteger(trim(theForm.assistant.value)) && trim(theForm.assistant.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Assistant ');
		document.theForm.assistant.value="";
        theForm.assistant.focus();
        return false;
  	}
	if (!isNumber(trim(theForm.asstphone.value)) && trim(theForm.asstphone.value)!='')
	{
		alert('Please enter the Numerical Characters only in the Asst.Phone ');
		document.theForm.asstphone.value="";
   		theForm.asstphone.focus();
   		return false;
	}
	var str   = document.theForm.birthdate.value;
        var first = str.indexOf("-");
        var last  = str.lastIndexOf("-");
        var year         = str.substring(last+1,last+5);
        var month        = str.substring(first+1,last);
        var date         = str.substring(0,first);
        var form_date    = new Date(year,month-1,date);
        var current_date = new Date();

    if (!(theForm.birthdate.value)=='')
        {
   			if(form_date.getFullYear() > (current_date.getFullYear()-18))
            {
                window.alert("Enter the valid Date of Birth");
                theForm.birthdate.focus();
                document.theForm.birthdate.value="";
                return false;
            }

  		}

	if (!isPositiveInteger(trim(theForm.department.value)) && trim(theForm.department.value)!='')
    {
   		alert('Please enter the AlphaNumerical only in the Department ');
		document.theForm.department.value="";
        theForm.department.focus();
        return false;
  	}
    if(theForm.comments.value.length<=0)
  	{
	   		alert('Enter your comments');
		    theForm.comments.focus();
		    return false;
    	}

	if(theForm.comments.value.length>4000)
  	{
	    	alert('Comments Should not exceed 4000 Characters');
		    theForm.comments.focus();
		    return false;
	}
    monitorSubmit();
	}

	/** Function To Set Focus On The Project Name Field In The Form */

	function setFocus()  {
		document.theForm.firstname.focus();
	}
	window.onload = setFocus;
//-->

</script>
</head>
<body>
<jsp:include page="/header.jsp" />
<BR>
<!-- Table To Display The Formatted String "Add New User" -->
<table  width="100%"   bgcolor="#c3d9ff">
	<tr>
		<td  align="left" ><font size="4"
			COLOR="#0000FF"><b> Edit Contact Information</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		<td  align="right"><strong><font size="10"
				COLOR="#FF0000">*</font> = Required Information</strong></td>
	</tr>
</table>
<BR>
<FORM name=theForm onsubmit="return fun(this)"
	action="<%=request.getContextPath() %>/MyCRM/crmContactUpdate.jsp"
	method=post onReset="return setFocus()"><%@ page
	import="java.sql.*,pack.eminent.encryption.*"%> <%
int contactid=Integer.parseInt(request.getParameter("contactid"));
Connection connection = null;
Statement st=null;
ResultSet rs=null;
try  {
	connection=MakeConnection.getConnection();
	if(connection != null)  {
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		rs = st.executeQuery("Select EMAIL,PERSONALEMAIL,FIRSTNAME,LASTNAME,ACCOUNTNAME, contact_owner, TITLE,PHONE,MOBILE,REPORTSTO,MAILINGSTREET,MAILINGCITY,MAILINGSTATE,MAILINGZIP,MAILINGCOUNTRY,OTHERSTREET,OTHERCITY,OTHERSTATE,OTHERZIP,OTHERCOUNTRY,FAX,HOMEPHONE,OTHERPHONE,ASSISTANT,ASSTPHONE,LEADSOURCE,BIRTHDATE,DEPARTMENT,DESCRIPTION,assignedto,company,duedate,rating,modifiedon,INTERESTED,ROLEID  from contact where contactid="+contactid);
		if(rs!=null)
		{
			while(rs.next())
			{

				String firstname=rs.getString("FIRSTNAME");
				String lastname=rs.getString("LASTNAME");
                String contactOwner=rs.getString("CONTACT_OWNER");
				String accountname=rs.getString("ACCOUNTNAME");
				String title=rs.getString("TITLE");
				String phone=rs.getString("PHONE");
				String mobile=rs.getString("MOBILE");
				String reportsto=rs.getString("REPORTSTO");
				String company=rs.getString("company");
				String email=rs.getString("EMAIL");
                                String pmail=rs.getString("PERSONALEMAIL");
				String mailingstreet=rs.getString("MAILINGSTREET");
				String mailingcity=rs.getString("MAILINGCITY");
                String mailingstate=rs.getString("MAILINGSTATE");
				String mailingzip=rs.getString("MAILINGZIP");
				String mailingcountry=rs.getString("MAILINGCOUNTRY");
                String otherstreet=rs.getString("OTHERSTREET");
                String othercity=rs.getString("OTHERCITY");
				String otherstate=rs.getString("OTHERSTATE");
                String otherzip=rs.getString("OTHERZIP");
                String othercountry=rs.getString("OTHERCOUNTRY");
				String fax=rs.getString("FAX");
				String homephone=rs.getString("HOMEPHONE");
				String otherphone=rs.getString("OTHERPHONE");
				String assistant=rs.getString("ASSISTANT");
				String asstphone=rs.getString("ASSTPHONE");
				String leadsource=rs.getString("LEADSOURCE");
				String birthdate=rs.getString("BIRTHDATE");
				String department=rs.getString("DEPARTMENT");
				String description=rs.getString("DESCRIPTION");


				String rating=rs.getString("rating");

				int assi=rs.getInt("assignedto");

				java.util.Date due=rs.getDate("duedate");

				SimpleDateFormat dfm =  new SimpleDateFormat("d-M-yyyy");
				String dueDate = "NA";
                if(due != null){
                    dueDate = dfm.format(due);
                }

                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                java.sql.Date modifiedOn = rs.getDate("modifiedon");

				String modified = "NA";
                if(modifiedOn != null){
                	modified = sdf.format(modifiedOn);
                }

                String product=rs.getString("INTERESTED");
                int	   roleid		=	rs.getInt("ROLEID");


                if (firstname==null) firstname="";
                if (lastname==null) lastname="";
                if (accountname==null) accountname="";
				if (phone==null) phone="";
				if (mobile==null) mobile="";
				if (title==null) title="";
				if (reportsto==null) reportsto="";
				if (email==null) email="";
                                if (pmail==null) pmail="";
				if (mailingstreet==null) mailingstreet="";
				if (mailingcity==null) mailingcity="";
				if (mailingstate==null)	mailingstate="";
				if (mailingzip==null) mailingzip="";
				if (mailingcountry==null) mailingcountry="";
				if (otherstreet==null) otherstreet="";
				if (othercity==null) othercity="";
				if (otherstate==null)	otherstate="";
				if (otherzip==null) otherzip="";
				if (othercountry==null) othercountry="";
				if (fax==null) fax="";
				if (homephone==null) homephone="";
				if (otherphone==null) otherphone="";
				if (assistant==null) assistant="";
				if (asstphone==null)	asstphone="";
				if (birthdate==null)birthdate="";
				if (department==null) department="";
				if (description==null) description="";
				if (company==null) company="";
				if(rating==null) rating="NA";
				if(product==null) product="NA";
				if(leadsource==null) leadsource="--None--";



		%>

<table width="100%" bgColor=#E8EEF7  align="center">
	<TBODY>


		<tr>
			<td width="10%"><strong>Title<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="title" id="title" maxlength="30" size=14 value="<%=title%>"><strong class="style20"></strong></td>
			<td width="10%"><strong>First Name<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="25%"><input type="text" name="firstname" id="firstname" maxlength="30" size=25 value="<%=firstname%>"><strong class="style20"></strong></td>
			<td width="12%"><strong>Last Name <font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="23%"><input type="text" name="lastname" id="lastname" maxlength="30" size=20 value="<%=lastname%>"><strong class="style20"></strong></td>
		</tr>

		<tr>


			<td width="10%"><strong>Phone<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="phone" id="phone" maxlength="15" size=14 value="<%=phone%>"><strong class="style20"></strong></td>
			<td width="10%"><strong>Email<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="25%"><input type="text" name="email" id="email" maxlength="60" size=25 value="<%=email%>"><strong class="style20"></strong></td>
			<td width="12%"><strong>Assigned To <font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="23%">
					<select name="assignedto" id="assignedto" size="1">
					
			<%


			HashMap al;

			String pro="CRM";
			String fix="1.0";
			al=GetProjectMembers.getBDMembers(pro,fix);
			Collection set=al.keySet();
			Iterator iter = set.iterator();
			int assigned=0;
            int useridassi=0;

		    while (iter.hasNext()) {

		      String key=(String)iter.next();
		      String nameofuser=(String)al.get(key);
		      logger.info("Userid"+key);
		      logger.info("Name"+nameofuser);


		     // String commentedby=GetProjectMembers.getUserName(rs.getString("commentedby"));
				nameofuser=nameofuser.substring(0,nameofuser.indexOf(" ")+2);

		      useridassi=Integer.parseInt(key);
		      if (useridassi==assi)
 				{
					assigned=useridassi;
%>
			<option value="<%=assigned%>" selected><%=nameofuser%></option>
			<%
			}
			else
			{
					assigned=useridassi;
%>
<!--			<option value="<%=assigned%>"><%=nameofuser%></option>-->
<%
			}
		    }
%>
		</select></td>





		</tr>
		<tr>
			<td width="10%"><strong>Mobile<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="21%"><input type="text" name="mobile" id="mobile" maxlength="15" size=14 value="<%=mobile%>"><strong class="style20"></strong></td>
                        <td width="10%"><strong>Personal Email</strong></td>
                        <td width="23%"><input type="text" name="personalemail" id="personalemail" maxlength="60" size=25 value="<%=pmail%>"><strong class="style20"></strong></td>
			<td width="10%"><strong>Company<font size="10" COLOR="#FF0000">*</font></strong></td>
			<td width="23%"><input type="text" name="company" id="company" maxlength="60" size=25 value="<%=company%>"><strong class="style20"></strong></td>


		</tr>
		<tr>
			<%
		    String[] ratingExist = { "Hot" , "Warm" , "Cold" };
%>
			<td width="10%"><strong>Rating</strong></td>
			<td width="21%"> <SELECT NAME="rating" id="rating" size="1">
				<%
			for (int i = 0;i < ratingExist.length ;i++ ){
				if (rating.equalsIgnoreCase(ratingExist[i]))
				{
%>
				<option value="<%= rating %>" selected><%= rating %></option>
				<%
				}
				else
				{
%>
				<option value="<%= ratingExist[i] %>"><%= ratingExist[i] %></option>
				<%
				}
          }
%>
			</SELECT></td>


			<td width="10%"><strong>Accounts <font size="10"
				COLOR="#FF0000">*</font></strong></td>
			<%
		PreparedStatement ps1=null;
		ResultSet rs1=null;

		ps1 = connection.prepareStatement("SELECT accountname  FROM account GROUP BY accountname Order by accountname asc");
		rs1 = ps1.executeQuery();
		String accounts="";
%>
			<td width="23%"><select name="accounts" id="accounts" size="1">
				<option value="--Select Account--" selected>--Select
				Account--</option>
				<%
			while(rs1.next())
			{
				accounts= rs1.getString(1);
				if (accounts.equals(accountname))
		        {
%>
				<option value="<%=accounts%>" selected><%=accounts%></option>
				<%
				}
				else
				{
%>
				<option value="<%=accounts%>"><%=accounts%></option>
				<%
				}
			}
			if(rs1!=null)
			{
					rs1.close();
			}
			if(ps1!=null)
			{
					ps1.close();
			}
%>
			</select></td>


			<td width="12%"><strong>Contact Owner</strong></td>
			<td width="23%"><input type="text" name="owner" id="owner" maxlength="30" size=20 value="<%= GetProjectMembers.getUserName(contactOwner) %>" readonly=true></td>


		</tr>
		<tr>
                        <td width="10%"><strong>Due Date<font size="10"	COLOR="#FF0000">*</font></strong></td>
                        <td width="21%"><input type="text" name="duedate" id="duedate" value="<%=dueDate%>"maxlength="10" size="14" readonly /><a href="javascript:NewCal('duedate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" 	border="0" width="16" height="16" alt="Pick a date"></a></td>
                        <td width="12%"><strong>Reports to</strong></td>
                        <td width="23%"><input type="text" name="reportsto" id="reportsto" maxlength="30" size=20 value="<%=reportsto%>"><strong class="style20"></strong></td>
                        <td width="12%"><strong>Interested In </strong></td>
			<td width="23%">

				<select name="product" id="product" size="1">
<%					String products[]={"eTracker","eOutSource","ERPDS"};
					for(int i = 0;i < products.length ;i++ ){
						 if (product.equals(products[i]))
			                {
			%>
						<option value="<%= product%>" selected><%= product %></option>
						<%
			                }
			                else
			                {
			%>
						<option value="<%= products[i] %>"><%= products[i] %></option>
						<%
			                }


					}


%>
				</select>
			</td>

		</tr>

		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
		<tr bgcolor="C3D9FF">
			<td colspan=7><strong >Address Information</strong>
			<input type="hidden" name="contactid" id="contactid" value="<%=contactid %>">
			<input type="hidden" name="contactowner" id="contactowner" value="<%=contactOwner %>"></td>
		</tr>

		<tr>
			<td width="10%"><strong>Street</strong></td>
			<td width="21%"> <textarea name="mailingstreet" id="mailingstreet" wrap="physical" cols="13" rows="2"><%=mailingstreet%></textarea></td>
			<td width="10%"><strong>City</strong></td>
			<td width="23%"><input type="text" name="mailingcity" id="mailingcity" maxlength="30" size=25 value="<%=mailingcity%>"></td>
			<td width="12%"><strong>State</strong></td>
			<td width="23%"><input type="text" name="mailingstate" id="mailingstate" maxlength="30" size=20 value="<%=mailingstate%>"></td>

		</tr>
		<tr>
			<td width="10%"><strong>Zip</strong></td>
			<td width="21%"><input type="text" name="mailingzip" id="mailingzip" maxlength="30" size=14 value="<%=mailingzip%>"></td>
			<td width="10%"><strong>Country</strong></td>
			<td width="23%"><input type="text" name="mailingcountry" id="mailingcountry" maxlength="30" size=25 value="<%=mailingcountry%>"><strong class="style20"></strong></td>

		</tr>

		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>

		<tr bgcolor="C3D9FF">
			<td colspan=6><strong>Additional Information</strong></td>
		</tr>


		<tr>
			<td width="10%"><strong>Fax</strong></td>
			<td width="21%"><input type="text" name="fax" id="fax" maxlength="30" size=14 value="<%=fax%>"></td>
			<td width="10%"><strong>Home Phone</strong></td>
			<td width="23%"><input type="text" name="homephone" id="homephone" maxlength="30" size=25 value="<%=homephone%>"></td>
			<td width="12%"><strong>Other Phone</strong></td>
			<td width="23%"><input type="text" name="otherphone" id="otherphone" maxlength="30" size=20 value="<%=otherphone%>"></td>

		</tr>

		<tr>

			<td width="10%"><strong>Department</strong></td>
			<td width="21%"><input type="text" name="department" id="department" maxlength="30" size=14 value="<%=department%>"></td>

			<td width="10%"><strong>Assistant</strong></td>
			<td width="23%"><input type="text" name="assistant" id="assistant" maxlength="30" size=25 value="<%=assistant%>"></td>

			<td width="12%"><strong>Asst. Phone</strong></td>
			<td width="23%"><input type="text" name="asstphone" id="asstphone" maxlength="30" size=20 value="<%=asstphone%>"></td>
		</tr>
<tr>
			<td width="10%"><strong>Birthdate</strong></td>
			<td width="21%"><input type="text" name="birthdate" id="birthdate" maxlength="30" size=14 value="<%=birthdate%>" readonly="true"> <a href="javascript:NewCal('birthdate','ddmmyyyy')"> <img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
			<td width="10%"><strong>Lead Source</strong></td>

			<td align="left" width="23%"><SELECT NAME="leadsource" id="leadsource" size="1">
<%
				String[] leadsourceExist = { "--None--" , "Advertisement" , "Employee Referrel" , "External Referrel","partner","public relataion","seminar-internal","Trade Show","web","Word of mouth","others"};
				for (int i = 0;i < leadsourceExist.length ;i++ ){
				if (leadsource.equals(leadsourceExist[i]))
				{
%>
				<option value="<%= leadsource %>" selected><%= leadsource %></option>
				<%
				}
				else
				{
%>
				<option value="<%= leadsourceExist[i] %>"><%= leadsourceExist[i] %></option>
				<%
				}
          }
%>
			</SELECT></td>



		</tr>
	<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
		<tr bgcolor="C3D9FF" width="100%">
			<td colspan=6 width="100%"><strong>Description</strong></td>
		</tr>

		<tr >

			<td colspan=6><%=description%></td>
		</tr>

	<tr height="21">
		<td width="100%" class="textdisplay" align="left" colspan=6>
		<p class="textdisplay"><b>Comments</b></p>
		</td>
	</tr>
	<tr height="21">
		<td width="10%"><strong></strong></td>
		<td width="90%" align="left" colspan=5><font size="2"	face="Verdana, Arial, Helvetica, sans-serif">
	<textarea rows="3" cols="68" name="comments" id="comments" maxlength="4000"
			onKeyDown="textCounter(document.theForm.comments,document.theForm.remLen1,4000)"
			onKeyUp="textCounter(document.theForm.comments,document.theForm.remLen1,4000)"></textarea></font>
			<input readonly type="text" name="remLen1" size="3"
			maxlength="3" value="4000">characters left</td>
	</tr>

	<tr align="center">
		<td></td><td></td><td></td>
		<td  align="center"><INPUT type=submit id="submit" value=Update name=submit>
				<input type=reset id="reset" value=Reset name=reset/>
		</td>
		<td></td>
		<td></td>
	</tr>
</TBODY>
</table>
<%
                   session.setAttribute("name",firstname);
                   session.setAttribute("category","contact");
                %> <iframe
	src="<%=request.getContextPath()%>/admin/customer/comments.jsp?contactId=<%= contactid %>" scrolling="auto"
	frameborder="2" height="45%" width="100%"></iframe> <br>
<br>
<br>


</FORM>

<%
			}
		}
	}
}catch(Exception ex)
		{
			logger.error(ex.getMessage());
		}finally
				{
			if(rs!=null)
			{
					rs.close();
			}
			if(st!=null)
			{
					st.close();
			}
//					rs.close();
					if (connection!=null)
					{
						connection.close();
					}

				}
%>
<BR>
</body>
</html>

