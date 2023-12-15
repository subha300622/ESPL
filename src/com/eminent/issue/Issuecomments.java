package com.eminent.issue;
// Generated Dec 12, 2009 11:06:39 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * Issuecomments generated by hbm2java
 */
public class Issuecomments  implements java.io.Serializable {


     private int commentid;
     private Issue issue;
     private String commentedby;
     private Date commentDate;
     private String comments;
     private String status;
     private String commentedto;
     private Date duedate;
     private String priority;
     private String severity;

    public Issuecomments() {
    }

	
    public Issuecomments(int commentid, String comments) {
        this.commentid = commentid;
        this.comments = comments;
    }
    public Issuecomments(int commentid, Issue issue, String commentedby, Date commentDate, String comments, String status, String commentedto, Date duedate, String priority, String severity) {
       this.commentid = commentid;
       this.issue = issue;
       this.commentedby = commentedby;
       this.commentDate = commentDate;
       this.comments = comments;
       this.status = status;
       this.commentedto = commentedto;
       this.duedate = duedate;
       this.priority = priority;
       this.severity = severity;
    }
   
    public int getCommentid() {
        return this.commentid;
    }
    
    public void setCommentid(int commentid) {
        this.commentid = commentid;
    }
    public Issue getIssue() {
        return this.issue;
    }
    
    public void setIssue(Issue issue) {
        this.issue = issue;
    }
    public String getCommentedby() {
        return this.commentedby;
    }
    
    public void setCommentedby(String commentedby) {
        this.commentedby = commentedby;
    }
    public Date getCommentDate() {
        return this.commentDate;
    }
    
    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }
    public String getComments() {
        return this.comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public String getCommentedto() {
        return this.commentedto;
    }
    
    public void setCommentedto(String commentedto) {
        this.commentedto = commentedto;
    }
    public Date getDuedate() {
        return this.duedate;
    }
    
    public void setDuedate(Date duedate) {
        this.duedate = duedate;
    }
    public String getPriority() {
        return this.priority;
    }
    
    public void setPriority(String priority) {
        this.priority = priority;
    }
    public String getSeverity() {
        return this.severity;
    }
    
    public void setSeverity(String severity) {
        this.severity = severity;
    }




}


