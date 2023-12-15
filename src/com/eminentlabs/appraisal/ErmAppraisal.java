package com.eminentlabs.appraisal;
// Generated Dec 17, 2011 10:34:40 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.sql.Timestamp;

/**
 * ErmAppraisal generated by hbm2java
 */
public class ErmAppraisal  implements java.io.Serializable {


     private Integer appraisalId;
     private ErmAppraisalStatus ermAppraisalStatus;
     private String empId;
     private Integer appraisalUser;
     private String period;
     private Integer firstAppraiser;
     private Integer secondAppraiser;
     private Integer thirdAppraiser;
     private Integer initiatedBy;
     private Integer assignedto;
     private Date duedate;
     private Timestamp createdon;
     private Timestamp updatedon;
     private String createdIssuesComment;
     private String workedIssuesComment;
     private String closedIssuesComment;
     private String newLearningsComment;
     private String attendanceComments;
     private String approvalPercentage;
     private String approvalStatus;
     private Integer systemAppraisalPercentage;
     private Integer userAppraisalPercentage;
     private Set<ErmAppraisalComment> ermAppraisalComments = new HashSet<ErmAppraisalComment>(0);

    public ErmAppraisal() {
    }

	
    public ErmAppraisal(Integer appraisalId) {
        this.appraisalId = appraisalId;
    }
    public ErmAppraisal(Integer appraisalId, ErmAppraisalStatus ermAppraisalStatus, String empId, Integer appraisalUser, String period, Integer firstAppraiser, Integer secondAppraiser, Integer thirdAppraiser, Integer initiatedBy, String accomplishments, String onGoingActivities, String planForNextMonth, Integer assignedto, Date duedate, Timestamp createdon, Timestamp updatedon, String createdIssuesComment, String workedIssuesComment, String closedIssuesComment, String newLearningsComment, String attendanceComments, String approvalPercentage,String approvalStatus,int userAppraisalPercentage,int systemAppraisalPercentage, Set<ErmAppraisalComment> ermAppraisalComments) {
       this.appraisalId = appraisalId;
       this.ermAppraisalStatus = ermAppraisalStatus;
       this.empId = empId;
       this.appraisalUser = appraisalUser;
       this.period = period;
       this.firstAppraiser = firstAppraiser;
       this.secondAppraiser = secondAppraiser;
       this.thirdAppraiser = thirdAppraiser;
       this.initiatedBy = initiatedBy;
       this.assignedto = assignedto;
       this.duedate = duedate;
       this.createdon = createdon;
       this.updatedon = updatedon;
       this.approvalStatus  =   approvalStatus;
       this.createdIssuesComment = createdIssuesComment;
       this.workedIssuesComment = workedIssuesComment;
       this.closedIssuesComment = closedIssuesComment;
       this.newLearningsComment = newLearningsComment;
       this.attendanceComments = attendanceComments;
       this.approvalPercentage = approvalPercentage;
       this.ermAppraisalComments = ermAppraisalComments;
       this.userAppraisalPercentage=userAppraisalPercentage;
       this.systemAppraisalPercentage=systemAppraisalPercentage;
    }
   
    public Integer getAppraisalId() {
        return this.appraisalId;
    }
    
    public void setAppraisalId(Integer appraisalId) {
        this.appraisalId = appraisalId;
    }
    public ErmAppraisalStatus getErmAppraisalStatus() {
        return this.ermAppraisalStatus;
    }
    
    public void setErmAppraisalStatus(ErmAppraisalStatus ermAppraisalStatus) {
        this.ermAppraisalStatus = ermAppraisalStatus;
    }
    public String getEmpId() {
        return this.empId;
    }
    
    public void setEmpId(String empId) {
        this.empId = empId;
    }
    public Integer getAppraisalUser() {
        return this.appraisalUser;
    }
    
    public void setAppraisalUser(Integer appraisalUser) {
        this.appraisalUser = appraisalUser;
    }
    public String getPeriod() {
        return this.period;
    }
    
    public void setPeriod(String period) {
        this.period = period;
    }
    public Integer getFirstAppraiser() {
        return this.firstAppraiser;
    }
    
    public void setFirstAppraiser(Integer firstAppraiser) {
        this.firstAppraiser = firstAppraiser;
    }
    public Integer getSecondAppraiser() {
        return this.secondAppraiser;
    }
    
    public void setSecondAppraiser(Integer secondAppraiser) {
        this.secondAppraiser = secondAppraiser;
    }
    public Integer getThirdAppraiser() {
        return this.thirdAppraiser;
    }
    
    public void setThirdAppraiser(Integer thirdAppraiser) {
        this.thirdAppraiser = thirdAppraiser;
    }
    public Integer getInitiatedBy() {
        return this.initiatedBy;
    }
    
    public void setInitiatedBy(Integer initiatedBy) {
        this.initiatedBy = initiatedBy;
    }
    public Integer getAssignedto() {
        return this.assignedto;
    }
    
    public void setAssignedto(Integer assignedto) {
        this.assignedto = assignedto;
    }
    public Date getDuedate() {
        return this.duedate;
    }
    
    public void setDuedate(Date duedate) {
        this.duedate = duedate;
    }
    public Date getCreatedon() {
        return this.createdon;
    }
    
    public void setCreatedon(Timestamp createdon) {
        this.createdon = createdon;
    }
    public Date getUpdatedon() {
        return this.updatedon;
    }
    
    public void setUpdatedon(Timestamp updatedon) {
        this.updatedon = updatedon;
    }
    public String getCreatedIssuesComment() {
        return this.createdIssuesComment;
    }
    
    public void setCreatedIssuesComment(String createdIssuesComment) {
        this.createdIssuesComment = createdIssuesComment;
    }
    public String getWorkedIssuesComment() {
        return this.workedIssuesComment;
    }
    
    public void setWorkedIssuesComment(String workedIssuesComment) {
        this.workedIssuesComment = workedIssuesComment;
    }
    public String getClosedIssuesComment() {
        return this.closedIssuesComment;
    }
    
    public void setClosedIssuesComment(String closedIssuesComment) {
        this.closedIssuesComment = closedIssuesComment;
    }
    public String getNewLearningsComment() {
        return this.newLearningsComment;
    }
    
    public void setNewLearningsComment(String newLearningsComment) {
        this.newLearningsComment = newLearningsComment;
    }
    public String getAttendanceComments() {
        return this.attendanceComments;
    }
    
    public void setAttendanceComments(String attendanceComments) {
        this.attendanceComments = attendanceComments;
    }
    public String getApprovalPercentage() {
        return this.approvalPercentage;
    }
    
    public void setApprovalPercentage(String approvalPercentage) {
        this.approvalPercentage = approvalPercentage;
    }
    public String getApprovalStatus() {
        return this.approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }
    public Integer getSystemAppraisalPercentage() {
        return this.systemAppraisalPercentage;
    }

    public void setSystemAppraisalPercentage(Integer systemAppraisalPercentage) {
        this.systemAppraisalPercentage = systemAppraisalPercentage;
    }
    public Integer getUserAppraisalPercentage() {
        return this.userAppraisalPercentage;
    }

    public void setUserAppraisalPercentage(Integer userAppraisalPercentage) {
        this.userAppraisalPercentage = userAppraisalPercentage;
    }
    public Set<ErmAppraisalComment> getErmAppraisalComments() {
        return this.ermAppraisalComments;
    }
    
    public void setErmAppraisalComments(Set<ErmAppraisalComment> ermAppraisalComments) {
        this.ermAppraisalComments = ermAppraisalComments;
    }

}


