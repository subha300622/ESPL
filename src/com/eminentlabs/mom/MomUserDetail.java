package com.eminentlabs.mom;
// Generated Jan 10, 2013 10:12:46 PM by Hibernate Tools 3.2.1.GA

import java.util.Date;

/**
 * MomUserDetail generated by hbm2java
 */
public class MomUserDetail implements java.io.Serializable {

    private Integer momuserdetailid;
    private Integer userid;
    private Date momdate;
    private String status;
    private Integer createdby;
    private Date createdon;
    private Date modifiedon;
    private String momtime;
    private String comment;

    public MomUserDetail() {
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public Date getModifiedon() {
        return this.modifiedon;
    }

    public void setModifiedon(Date modifiedon) {
        this.modifiedon = modifiedon;
    }

//    public MomUserPk getMomUserPk() {
//        return momUserPk;
//    }
//
//    public void setMomUserPk(MomUserPk momUserPk) {
//        this.momUserPk = momUserPk;
//    }
    public Integer getMomuserdetailid() {
        return momuserdetailid;
    }

    public void setMomuserdetailid(Integer momuserdetailid) {
        this.momuserdetailid = momuserdetailid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Date getMomdate() {
        return momdate;
    }

    public void setMomdate(Date momdate) {
        this.momdate = momdate;
    }

    public String getMomtime() {
        return momtime;
    }

    public void setMomtime(String momtime) {
        this.momtime = momtime;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    
    
    
}