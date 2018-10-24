package dto;

import java.io.Serializable;

//	DROP TABLE PDSREPLY
//	CASCADE CONSTRAINTS;
//	
//	CREATE TABLE PDSREPLY(
//		   PDSSEQ NUMBER(10) NOT NULL,
//		   RESEQ NUMBER(10) NOT NULL PRIMARY KEY,
//		   ID VARCHAR2(50) NOT NULL,
//		   CONTENT VARCHAR2(500) NOT NULL,
//		   REREF NUMBER(10),
//		   WDATE DATE NOT NULL,
//		   DEL NUMBER(1) NOT NULL,
//		   TOWHOM VARCHAR2(50),
//		   CONSTRAINT fk_TOWHOM FOREIGN KEY(TOWHOM) REFERENCES MEMBER(ID),
//		   CONSTRAINT fk_pdsreply_seq FOREIGN KEY(PDSSEQ) REFERENCES PICPDS(SEQ),
//		   CONSTRAINT fk_pdsreply_reref FOREIGN KEY(REREF) REFERENCES PDSREPLY(RESEQ)
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

public class ReplyBean implements Serializable {

	private static final long serialVersionUID = 4990484666293070777L;
	
	private int pdsSeq;
	private int reSeq;
	private String id;
	private String content;
	private int reRef;
	private String wdate;
	private int del;
	private String toWhom;
	/* READ */
	// 아무도 안 읽었으면 0
	// 게시글 작성자가 읽었으면 1
	// TOWHOM이 읽었으면 2
	// 둘 다 읽었으면 3

	public ReplyBean() { }

	public ReplyBean(int pdsSeq, int reSeq, String id, String content, int reRef, String wdate, int del, String toWhom) {
		super();
		this.pdsSeq = pdsSeq;
		this.reSeq = reSeq;
		this.id = id;
		this.content = content;
		this.reRef = reRef;
		this.wdate = wdate;
		this.del = del;
		this.toWhom = toWhom;
	}

	public int getPdsSeq() {
		return pdsSeq;
	}

	public void setPdsSeq(int pdsSeq) {
		this.pdsSeq = pdsSeq;
	}

	public int getReSeq() {
		return reSeq;
	}

	public void setReSeq(int reSeq) {
		this.reSeq = reSeq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReRef() {
		return reRef;
	}

	public void setReRef(int reRef) {
		this.reRef = reRef;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public String getToWhom() {
		return toWhom;
	}

	public void setToWhom(String toWhom) {
		this.toWhom = toWhom;
	}


	@Override
	public String toString() {
		return "ReplyBean [pdsSeq=" + pdsSeq + ", reSeq=" + reSeq + ", id=" + id + ", content=" + content + ", reRef="
				+ reRef + ", wdate=" + wdate + ", del=" + del + ", toWhom=" + toWhom + "]";
	}

	
	
}
