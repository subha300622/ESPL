CREATE TABLE APM_PHASEDATE(DATEID NUMBER,PID NUMBER,PHASE VARCHAR2(50),PLANNEDSTARTDATE DATE,PLANNEDENDDATE DATE,ACTUALSTARTDATE DATE,ACTUALENDDATE DATE,TOTALHOURS NUMBER);
CREATE SEQUENCE   "PHASEDATE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 10000 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE APM_PROJECTCOMMENTS(COMMENTID NUMBER,PROJECTID NUMBER,COMMENTEDBY NUMBER,COMMENTS VARCHAR2(2000),STATUS VARCHAR2(25),COMMENTEDON DATE);
CREATE SEQUENCE   "PROJECTCOMMENTID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
ALTER TABLE PROJECT ADD DELIVERABLES VARCHAR2(2000);
ALTER TABLE TIMESHEET ADD SUGGESTION VARCHAR2(1500);
ALTER TABLE TIMESHEET ADD HARDSHIP VARCHAR2(1500);
ALTER TABLE TIMESHEET ADD PLAN VARCHAR2(1500);
ALTER TABLE LEAVE ADD APPROVER NUMBER;
UPDATE TIMESHEET SET APPROVALSTATUS='Approved' WHERE APPROVALSTATUS IS NULL AND APPROVALPERCENTAGE IS NOT NULL;