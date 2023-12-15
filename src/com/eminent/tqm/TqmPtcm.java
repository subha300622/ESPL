package com.eminent.tqm;
// Generated Dec 8, 2009 2:55:55 PM by Hibernate Tools 3.2.1.GA


import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * TqmPtcm generated by hbm2java
 */
public class TqmPtcm  implements java.io.Serializable {


     private String ptcid;
     private String ctcid;
     private Integer pid;
     private Integer mid;
     private String functionality;
     private String description;
     private String expectedresult;
     private Timestamp createdon;
     private Integer createdby;
     private Timestamp modifiedon;
     private Set<TqmIssuetestcases> tqmIssuetestcaseses = new HashSet<TqmIssuetestcases>(0);
     private Set<TqmTestcaseresult> tqmTestcaseresults = new HashSet<TqmTestcaseresult>(0);
     private Set<TqmTestcaseexecution> tqmTestcaseexecutions = new HashSet<TqmTestcaseexecution>(0);

    public TqmPtcm() {
    }

	
    public TqmPtcm(String ptcid) {
        this.ptcid = ptcid;
    }
    public TqmPtcm(String ptcid, String ctcid, Integer pid, Integer mid, String functionality, String description, String expectedresult, Timestamp createdon, Integer createdby, Timestamp modifiedon, Set<TqmIssuetestcases> tqmIssuetestcaseses,Set<TqmTestcaseresult> tqmTestcaseresults,Set<TqmTestcaseexecution> tqmTestcaseexecutions) {
       this.ptcid = ptcid;
       this.ctcid = ctcid;
       this.pid = pid;
       this.mid = mid;
       this.functionality = functionality;
       this.description = description;
       this.expectedresult = expectedresult;
       this.createdon = createdon;
       this.createdby = createdby;
       this.modifiedon = modifiedon;
       this.tqmIssuetestcaseses = tqmIssuetestcaseses;
       this.tqmTestcaseresults  = tqmTestcaseresults;
    }
   
    public String getPtcid() {
        return this.ptcid;
    }
    
    public void setPtcid(String ptcid) {
        this.ptcid = ptcid;
    }
    public String getCtcid() {
        return this.ctcid;
    }
    
    public void setCtcid(String ctcid) {
        this.ctcid = ctcid;
    }
    public Integer getPid() {
        return this.pid;
    }
    
    public void setPid(Integer pid) {
        this.pid = pid;
    }
    public Integer getMid() {
        return this.mid;
    }
    
    public void setMid(Integer mid) {
        this.mid = mid;
    }
    public String getFunctionality() {
        return this.functionality;
    }
    
    public void setFunctionality(String functionality) {
        this.functionality = functionality;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public String getExpectedresult() {
        return this.expectedresult;
    }
    
    public void setExpectedresult(String expectedresult) {
        this.expectedresult = expectedresult;
    }
    public Timestamp getCreatedon() {
        return this.createdon;
    }
    
    public void setCreatedon(Timestamp createdon) {
        this.createdon = createdon;
    }
    public Integer getCreatedby() {
        return this.createdby;
    }
    
    public void setCreatedby(Integer createdby) {
        this.createdby = createdby;
    }
    public Timestamp getModifiedon() {
        return this.modifiedon;
    }
    
    public void setModifiedon(Timestamp modifiedon) {
        this.modifiedon = modifiedon;
    }
    public Set<TqmIssuetestcases> getTqmIssuetestcaseses() {
        return this.tqmIssuetestcaseses;
    }
    
    public void setTqmIssuetestcaseses(Set<TqmIssuetestcases> tqmIssuetestcaseses) {
        this.tqmIssuetestcaseses = tqmIssuetestcaseses;
    }
    public Set<TqmTestcaseresult> getTqmtestcaseresults() {
        return this.tqmTestcaseresults;
    }

    public void setTqmtestcaseresults(Set<TqmTestcaseresult> tqmTestcaseresults) {
        this.tqmTestcaseresults = tqmTestcaseresults;
    }
    public Set<TqmTestcaseexecution> getTqmtestcaseexecutions() {
        return this.tqmTestcaseexecutions;
    }

    public void setTqmtestcaseexecutions(Set<TqmTestcaseexecution> tqmTestcaseexecutions) {
        this.tqmTestcaseexecutions = tqmTestcaseexecutions;
    }


}


