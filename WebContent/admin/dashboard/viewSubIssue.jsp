<%-- 
    Document   : viewSubIssue
    Created on : 14 Dec, 2023, 11:47:28 AM
    Author     : DhanVa CompuTers
--%>

<%@page import="java.util.Map"%>
<%@page import="com.eminent.issue.dao.IssueDAO"%>       
<%@page import="com.eminent.issue.dao.IssueDAOImpl"%>
<% String subIssue = "";
    IssueDAO isissueDAO = new IssueDAOImpl();
    String mainIssue = request.getParameter("mainIssue").toUpperCase();
    for (Map.Entry<String, String> entry : isissueDAO.getsubissues(mainIssue).entrySet()) {
        subIssue = subIssue + "<li id=\"mainIssue" + entry.getKey() + "\"> <div class=\"treeclass\" onclick=\"javascript:viewSubIssues('"+entry.getKey()+"');\"></div><a href=\"#\" onclick=\"javascript:viewSubIssues('"+entry.getKey()+"');\"><b>Sub Issue: </b>" + entry.getValue()+ "</a>";
        subIssue = subIssue + "</li>";
    }
     subIssue = "<ul>" + subIssue + "</ul>";
 out.print(subIssue);
%>