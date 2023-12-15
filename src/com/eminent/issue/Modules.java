package com.eminent.issue;
// Generated Dec 12, 2009 11:06:39 AM by Hibernate Tools 3.2.1.GA


import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * Modules generated by hbm2java
 */
public class Modules  implements java.io.Serializable {


     private BigDecimal moduleid;
     private Project projectid;
     private String module;
     private Set issues = new HashSet(0);

    public Modules() {
    }

	
    public Modules(BigDecimal moduleid, Project project) {
        this.moduleid = moduleid;
        this.projectid = project;
    }
    public Modules(BigDecimal moduleid, Project projectid, String module, Set issues) {
       this.moduleid = moduleid;
       this.projectid = projectid;
       this.module = module;
       this.issues = issues;
    }
   
    public BigDecimal getModuleid() {
        return this.moduleid;
    }
    
    public void setModuleid(BigDecimal moduleid) {
        this.moduleid = moduleid;
    }
    public Project getProjectid() {
        return this.projectid;
    }
    
    public void setProjectid(Project projectid) {
        this.projectid = projectid;
    }
    public String getModule() {
        return this.module;
    }
    
    public void setModule(String module) {
        this.module = module;
    }
    public Set getIssues() {
        return this.issues;
    }
    
    public void setIssues(Set issues) {
        this.issues = issues;
    }




}


