ALTER TABLE ERM_APPLICANT ADD APPLICANT_STATUS NUMBER;
CREATE TABLE ERM_APPLICANT_COMMENT(APPLICANTID VARCHAR2(15),COMMENTID NUMBER,COMMENTEDBY NUMBER,COMMENTS VARCHAR2(1000),COMMENTEDON TIMESTAMP,COMMENTEDTO NUMBER,APPLICANT_STATUS NUMBER,CONSTRAINT "COMMENTID_PK" PRIMARY KEY("COMMENTID") ENABLE)
CREATE SEQUENCE   "APPLICANT_COMMENT_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;