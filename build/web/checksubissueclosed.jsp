<%@page import="com.eminent.issue.dao.IssueDAOImpl"%>
<%@page import="com.eminent.issue.dao.IssueDAO"%>           
<%String mainIssue = request.getParameter("mainIssue");
IssueDAO issueDAO = new IssueDAOImpl();
out.print(issueDAO.checkSubissues(mainIssue));
%>