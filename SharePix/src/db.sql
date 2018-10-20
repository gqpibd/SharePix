------------------------------------------------------ PICPDS
DROP TABLE PICPDS
CASCADE CONSTRAINTS;

CREATE TABLE PICPDS(
   SEQ NUMBER(10) NOT NULL PRIMARY KEY,
   ID VARCHAR2(50) NOT NULL,
   CATEGORY VARCHAR2(100) NOT NULL,
   TAGS VARCHAR2(1000),
   UPLOADDATE DATE NOT NULL,
   FILENAME VARCHAR2(50) NOT NULL,
   READCOUNT NUMBER(10) NOT NULL,
   DOWNCOUNT NUMBER(10) NOT NULL,
   FSAVENAME VARCHAR2(100),
   REPORT NUMBER(1),
   CONSTRAINT fk_picpds_id FOREIGN KEY(ID) REFERENCES MEMBER(ID)
);
SELECT * from PICPDS

DROP SEQUENCE PICPDS_SEQ;

CREATE SEQUENCE PICPDS_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE picpds 
ADD (FSAVENAME varchar2(50));

ALTER TABLE picpds 
ADD (REPORT NUMBER(1));

ALTER TABLE picpds 
MODIFY (TAGS VARCHAR2(1000));

ALTER TABLE picpds 
MODIFY (FSAVENAME VARCHAR2(100));

insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#가을#곤충#고추잠자리#날개', sysdate, '잠자리.jpg', 0,0,'잠자리.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#개기월식#보름달#밤#하늘#붉은달', sysdate, 'totaleclipse.jpg', 0,0,'totaleclipse.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#달#보름달#밤#하늘#검정', sysdate, 'moon.jpg', 0,0,'moon.jpg');

insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '음식', '#감자튀김#치킨#야식#안주', sysdate, 'food.jpg', 0,0,'food.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#월식#밤하늘', sysdate, 'eclipse.jpg', 0,0,'eclipse.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '디자인', '#시계#손목시계', sysdate, 'watch.jpg', 0,0,'watch.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#눈#야경#설경', sysdate, 'snow1.jpg', 0,0,'snow1.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#눈#야경#설경', sysdate, 'snow2.jpg', 0,0,'snow2.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#눈#야경#설경#나무', sysdate, 'snow3.jpg', 0,0,'snow2.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '과학', '#배#바다#항구#blue', sysdate, 'boat.png', 0,0,'boat.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '디자인', '#그래피티#벽화#건물', sysdate, 'graffiti.png', 0,0,'graffiti.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '디자인', '#그래피티#벽화#벽', sysdate, 'graffiti2.png', 0,0,'graffiti2.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '디자인', '#그래피티#벽화#벽', sysdate, 'graffiti3.png', 0,0,'graffiti3.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '기타', '#길#유럽#건물#교회', sysdate, 'church1.png', 0,0,'church1.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '디자인', '#신발#길', sysdate, 'shoe.png', 0,0,'shoe.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '디자인', '#가로등#벽#창문', sysdate, 'Streetlamp.png', 0,0,'Streetlamp.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#론다#스페인#유럽#절벽', sysdate, 'ronda1.png', 0,0,'ronda1.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#론다#스페인#유럽#절벽#다리', sysdate, 'ronda2.png', 0,0,'ronda2.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#론다#스페인#유럽#절벽#다리#저녁', sysdate, 'ronda3.png', 0,0,'ronda3.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#노을#가로등#저녁', sysdate, 'evening.png', 0,0,'evening.png');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '음식', '#과일#퐁듀', sysdate, 'food2.jpg', 0,0,'food2.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#동물#고양이', sysdate, 'cat.jpg', 0,0,'cat.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '자연', '#동물#고양이', sysdate, 'cat2.jpg', 0,0,'cat2.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '디자인', '#디자인#선#단면#개미집', sysdate, 'design1.jpg', 0,0,'design1.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '과학', '#스피커#블루투스#공중부양', sysdate, 'speaker.jpg', 0,0,'speaker.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '과학', '#디스플레이#플렉시블#모니터', sysdate, 'display.jpg', 0,0,'display.jpg');
insert into PICPDS
values (PICPDS_SEQ.NEXTVAL, 'dh', '과학', '#캡슐베드#수면', sysdate, 'capsulebed.jpg', 0,0,'capsulebed.jpg');



---------------------------------------------------- PDSREPLY
DROP TABLE PDSREPLY
CASCADE CONSTRAINTS;

CREATE TABLE PDSREPLY(
   PDSSEQ NUMBER(10) NOT NULL,
   RESEQ NUMBER(10) NOT NULL PRIMARY KEY,
   ID VARCHAR2(50) NOT NULL,
   CONTENT VARCHAR2(500) NOT NULL,
   REREF NUMBER(10),
   WDATE DATE NOT NULL,
   DEL NUMBER(1) NOT NULL,
   TOWHOM VARCHAR2(50),
   READ NUMBER(1),
   CONSTRAINT fk_TOWHOM FOREIGN KEY(TOWHOM) REFERENCES MEMBER(ID),
   CONSTRAINT fk_pdsreply_seq FOREIGN KEY(PDSSEQ) REFERENCES PICPDS(SEQ),
   CONSTRAINT fk_pdsreply_reref FOREIGN KEY(REREF) REFERENCES PDSREPLY(RESEQ)
);

insert into PDSREPLY
values (1, PDSREPLY_RESEQ.nextval, 'dh2', '퍼가요', null, sysdate, 0);
insert into PDSREPLY
values (1, PDSREPLY_RESEQ.nextval, 'dh', '네', 1, sysdate, 0);
insert into PDSREPLY
values (1, PDSREPLY_RESEQ.nextval, 'dh2', '감사합니다', 1, sysdate, 0);
insert into PDSREPLY
values (1, PDSREPLY_RESEQ.nextval, 'dh2', '감사합니다', NULL, sysdate, 0);
insert into PDSREPLY
values (1, PDSREPLY_RESEQ.nextval, 'dh', '네', NULL, sysdate, 0);

DROP SEQUENCE PDSREPLY_RESEQ;

CREATE SEQUENCE PDSREPLY_RESEQ
START WITH 6
INCREMENT BY 1;

SELECT * FROM PDSREPLY WHERE PDSSEQ = 1 ORDER BY REREF ASC, RESEQ ASC 
SELECT * FROM PDSREPLY  

ALTER TABLE PDSREPLY 
ADD(
	TOWHOM VARCHAR2(50),
	READ NUMBER(1),
 	CONSTRAINT fk_TOWHOM FOREIGN KEY(TOWHOM) REFERENCES MEMBER(ID)
);

---------------------------------------------------- PDSLIKE
DROP TABLE PDSLIKE
CASCADE CONSTRAINTS;

CREATE TABLE PDSLIKE(
   PDSSEQ NUMBER(10) NOT NULL,
   ID VARCHAR2(50) NOT NULL,
   CONSTRAINT fk_pdslike_pdsseq FOREIGN KEY(PDSSEQ) REFERENCES PICPDS(SEQ),
   CONSTRAINT fk_pdslike_id FOREIGN KEY(ID) REFERENCES MEMBER(ID)
);

---------------------------------------------------- FOLLOW
DROP TABLE FOLLOW
CASCADE CONSTRAINTS;

CREATE TABLE FOLLOW(
   FOLLOWERID VARCHAR2(50) NOT NULL,
   FOLLOWEEID VARCHAR2(50) NOT NULL,
   CONSTRAINT fk_follow_followerid FOREIGN KEY(FOLLOWERID) REFERENCES MEMBER(ID),
   CONSTRAINT fk_follow_followeeid FOREIGN KEY(FOLLOWEEID) REFERENCES MEMBER(ID)
);

---------------------------------------------------- PDSALL
DROP VIEW PDSALL;

CREATE VIEW PDSALL (SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT)
AS
SELECT P.SEQ, P.ID, P.CATEGORY, P.TAGS, P.UPLOADDATE, P.FILENAME, P.READCOUNT, P.DOWNCOUNT, P.FSAVENAME, 
	NVL((SELECT COUNT(*) FROM PDSLIKE  GROUP BY PDSSEQ HAVING PDSSEQ = P.SEQ),0),
	NVL((SELECT COUNT(*) FROM PDSREPLY GROUP BY PDSSEQ HAVING PDSSEQ = P.SEQ),0)	
FROM PICPDS P

select * from pdsall

---------------------------------------------------- ALARM
DROP table ALARM
cascade constraints;

CREATE TABLE ALARM(
   SEQ number(10) PRIMARY KEY,
   TOID VARCHAR2(50) NOT NULL, -- 누구한테 알람
   FROMID VARCHAR2(50) NOT NULL, -- 누가 알람 만듦
   ATYPE NUMBER(1) NOT NULL, -- 1: 새 게시글, 2: 댓글 알람
   PDSSEQ NUMBER(10) NOT NULL,
   ADATE DATE NOT NULL,
   CONSTRAINT fk_ALARM_TOID FOREIGN KEY(TOID) REFERENCES MEMBER(ID),
   CONSTRAINT fk_ALARM_FROMID FOREIGN KEY(FROMID) REFERENCES MEMBER(ID),
   CONSTRAINT fk_ALARM_PDSSEQ FOREIGN KEY(PDSSEQ) REFERENCES PICPDS(SEQ)
);

DROP SEQUENCE ALARM_SEQ;

CREATE SEQUENCE ALARM_SEQ
START WITH 1
INCREMENT BY 1;

INSERT INTO ALARM (SEQ, TOID, FROMID, ATYPE, PDSSEQ, ADATE) 
VALUES((SELECT NVL(MAX(SEQ),0)+1 FROM ALARM), 'dh', 'dh', 1, 1, SYSDATE) 

SELECT * FROM ALARM
