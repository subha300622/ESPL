CREATE TABLE BPM_VERTICALS(VERTICALID NUMBER,VERTICALNAME VARCHAR2(150),VERTICALDESCRIPTION VARCHAR2(150),VERTICALTYPE VARCHAR2(150),DESCRIPTION VARCHAR2(500),CREATEDBY NUMBER,CREATEDON TIMESTAMP,MODIFIEDON TIMESTAMP,CONSTRAINT VERTICALID_PK PRIMARY KEY("VERTICALID") ENABLE);
CREATE SEQUENCE   "VERTICALID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE BPM_DEPARTMENTS (DEPARTMENTID NUMBER,DEPARTMENTNAME VARCHAR2(100),ACCOUNTID NUMBER,VERTICALID NUMBER,DESCRIPTION VARCHAR2(500),CREATEDBY NUMBER,CREATEDON TIMESTAMP,MODIFIEDON TIMESTAMP,CONSTRAINT DEPARTMENTID_PK PRIMARY KEY("DEPARTMENTID") ENABLE,CONSTRAINT "FK_ACCOUNTID" FOREIGN KEY ("ACCOUNTID") REFERENCES  "ACCOUNT" ("ACCOUNTID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_VERTICALID" FOREIGN KEY ("VERTICALID") REFERENCES  "BPM_VERTICALS" ("VERTICALID") ON DELETE CASCADE ENABLE);
CREATE SEQUENCE   "DEPARTMENTID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE BPM_MAINPROCESS (PROCESSID NUMBER,PROCESSNAME VARCHAR(200),DEPARTMENTID NUMBER,ACCOUNTID NUMBER,VERTICALID NUMBER,CREATEDBY NUMBER,CREATEDON TIMESTAMP,MODIFIEDON TIMESTAMP,CONSTRAINT PROCESSID_PK PRIMARY KEY("PROCESSID") ENABLE,CONSTRAINT "FK_MP_ACCOUNTID" FOREIGN KEY ("ACCOUNTID") REFERENCES  "ACCOUNT" ("ACCOUNTID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_MP_VERTICALID" FOREIGN KEY ("VERTICALID") REFERENCES  "BPM_VERTICALS" ("VERTICALID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_MP_DEPARTMENTID" FOREIGN KEY ("DEPARTMENTID") REFERENCES  "BPM_DEPARTMENTS" ("DEPARTMENTID") ON DELETE CASCADE ENABLE);
CREATE SEQUENCE   "MAINPROCESSID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE BPM_BUSINESSPROCESS (BPID NUMBER,BPNAME VARCHAR(200),MAINPROCESSID NUMBER,DEPARTMENTID NUMBER,ACCOUNTID NUMBER,VERTICALID NUMBER,CREATEDBY NUMBER,CREATEDON TIMESTAMP,MODIFIEDON TIMESTAMP,CONSTRAINT BPID_PK PRIMARY KEY("BPID") ENABLE,CONSTRAINT "FK_BP_ACCOUNTID" FOREIGN KEY ("ACCOUNTID") REFERENCES  "ACCOUNT" ("ACCOUNTID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_BP_VERTICALID" FOREIGN KEY ("VERTICALID") REFERENCES  "BPM_VERTICALS" ("VERTICALID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_BP_DEPARTMENTID" FOREIGN KEY ("DEPARTMENTID") REFERENCES  "BPM_DEPARTMENTS" ("DEPARTMENTID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_BP_MAINPROCESSID" FOREIGN KEY ("MAINPROCESSID") REFERENCES  "BPM_MAINPROCESS" ("PROCESSID") ON DELETE CASCADE ENABLE);
CREATE SEQUENCE   "BPID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
CREATE TABLE BPM_BUSINESSSCENARIO (BSID NUMBER,BSNAME VARCHAR(200),BPID NUMBER,MAINPROCESSID NUMBER,DEPARTMENTID NUMBER,ACCOUNTID NUMBER,VERTICALID NUMBER,CREATEDBY NUMBER,CREATEDON TIMESTAMP,MODIFIEDON TIMESTAMP,CONSTRAINT BSID_PK PRIMARY KEY("BSID") ENABLE,CONSTRAINT "FK_BS_ACCOUNTID" FOREIGN KEY ("ACCOUNTID") REFERENCES  "ACCOUNT" ("ACCOUNTID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_BS_VERTICALID" FOREIGN KEY ("VERTICALID") REFERENCES  "BPM_VERTICALS" ("VERTICALID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_BS_DEPARTMENTID" FOREIGN KEY ("DEPARTMENTID") REFERENCES  "BPM_DEPARTMENTS" ("DEPARTMENTID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_BS_MAINPROCESSID" FOREIGN KEY ("MAINPROCESSID") REFERENCES  "BPM_MAINPROCESS" ("PROCESSID") ON DELETE CASCADE ENABLE,CONSTRAINT "FK_BS_BPID" FOREIGN KEY ("BPID") REFERENCES  "BPM_BUSINESSPROCESS" ("BPID") ON DELETE CASCADE ENABLE);
CREATE SEQUENCE   "BSID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;
ALTER TABLE ACCOUNT ADD VERTICALID NUMBER;
ALTER TABLE ACCOUNT ADD CONSTRAINT "FK_AC_VERTICALID" FOREIGN KEY (VERTICALID) REFERENCES BPM_VERTICALS("VERTICALID") ON DELETE CASCADE ENABLE;