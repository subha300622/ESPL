package com.eminent.bpm;
// Generated Jun 14, 2012 4:44:57 PM by Hibernate Tools 3.2.1.GA

import java.util.Date;




/**
 * BpmTeststep generated by hbm2java
 */
public class BpmTeststep  implements java.io.Serializable {

     private Integer teststepId;
     private String teststep;
     private String tsType;
     private Integer testcaseId;
     private Integer createdby;
     private Date createdon;

    public BpmTeststep() {
    }

    public BpmTeststep(Integer teststepId, String teststep, String tsType, Integer testcaseId, Integer createdby, Date createdon) {
       this.teststepId = teststepId;
       this.teststep = teststep;
       this.tsType  = tsType;
       this.testcaseId = testcaseId;
       this.createdby = createdby;
       this.createdon = createdon;
    }
   
    public Integer getTeststepId() {
        return this.teststepId;
    }
    
    public void setTeststepId(Integer teststepId) {
        this.teststepId = teststepId;
    }
    public String getTeststep() {
        return this.teststep;
    }
    
    public void setTeststep(String teststep) {
        this.teststep = teststep;
    }
    public String getTsType() {
        return this.tsType;
    }
    
    public void setTsType(String tsType) {
        this.tsType = tsType;
    }
    public Integer getTestcaseId() {
        return this.testcaseId;
    }
    
    public void setTestcaseId(Integer testcaseId) {
        this.testcaseId = testcaseId;
    }
    public Integer getCreatedby() {
        return this.createdby;
    }
    
    public void setCreatedby(Integer createdby) {
        this.createdby = createdby;
    }
    public Date getCreatedon() {
        return this.createdon;
    }
    
    public void setCreatedon(Date createdon) {
        this.createdon = createdon;
    }





}


