package dto;

//	DROP TABLE PDSREPLY
//	CASCADE CONSTRAINTS;
//	
//	CREATE TABLE PDSREPLY(
//	   PDSSEQ NUMBER(10) NOT NULL,
//	   RESEQ NUMBER(10) NOT NULL PRIMARY KEY,
//	   ID VARCHAR2(50) NOT NULL,
//	   CONTENT VARCHAR2(500) NOT NULL,
//	   REREF NUMBER(10),
//	   WDATE DATE NOT NULL,
//	   DEL NUMBER(1) NOT NULL,
//	   CONSTRAINT fk_pdsreply_seq FOREIGN KEY(PDSSEQ) REFERENCES PICPDS(SEQ),
//	   CONSTRAINT fk_pdsreply_reref FOREIGN KEY(REREF) REFERENCES PDSREPLY(RESEQ)
//	);
//	
//	DROP SEQUENCE PDSREPLY_PDSSEQ;
//	
//	CREATE SEQUENCE PDSREPLY_PDSSEQ
//	START WITH 1
//	INCREMENT BY 1;
//	
//	DROP SEQUENCE PDSREPLY_RESEQ;
//	
//	CREATE SEQUENCE PDSREPLY_RESEQ
//	START WITH 1
//	INCREMENT BY 1;

public class ReplyBean {

	private int pdsSeq;
	private int reSeq;
	private String id;
	private String content;
	private int reRef;
	private String wdate;
	private int del;

	public ReplyBean() { }

	public ReplyBean(int pdsSeq, int reSeq, String id, String content, int reRef, String wdate, int del) {
		super();
		this.pdsSeq = pdsSeq;
		this.reSeq = reSeq;
		this.id = id;
		this.content = content;
		this.reRef = reRef;
		this.wdate = wdate;
		this.del = del;
	}

	@Override
	public String toString() {
		return "ReplyDto [pdsSeq=" + pdsSeq + ", reSeq=" + reSeq + ", id=" + id + ", content=" + content + ", reRef="
				+ reRef + ", wdate=" + wdate + ", del=" + del + "]";
	}
	
}
