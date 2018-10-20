package dto;

import java.io.Serializable;
//CREATE TABLE ALARM(
//   SEQ number(10) PRIMARY KEY,
//   TOID VARCHAR2(50) NOT NULL, -- 누구한테 알람
//   FROMID VARCHAR2(50) NOT NULL, -- 누가 알람 만듦
//   ATYPE NUMBER(1) NOT NULL, -- 1: 새 게시글, 2: 댓글 알람
//   PDSSEQ NUMBER(10) NOT NULL,
//   ADATE DATE NOT NULL,
//   CONSTRAINT fk_ALARM_TOID FOREIGN KEY(TOID) REFERENCES MEMBER(ID),
//   CONSTRAINT fk_ALARM_FROMID FOREIGN KEY(FROMID) REFERENCES MEMBER(ID),
//   CONSTRAINT fk_ALARM_PDSSEQ FOREIGN KEY(PDSSEQ) REFERENCES PICPDS(SEQ)
//);

public class AlarmBean implements Serializable {
	
	private static final long serialVersionUID = 8266746747927251950L;
	
	public static final int NEWPOST = 1;
	public static final int NEWREPLY = 2;	
	
	private int seq;
	private String toId;
	private String fromId;
	private int type;
	private int pdsSeq;
	private String date;	
	
	public AlarmBean() {}
	
	public AlarmBean(String toId, String fromId, int type, int pdsSeq) {
		this.toId = toId;
		this.fromId = fromId;
		this.type = type;
		this.pdsSeq = pdsSeq;
	}	

	public AlarmBean(int seq, String toId, String fromId, int type, int pdsSeq, String date) {
		this.seq = seq;
		this.toId = toId;
		this.fromId = fromId;
		this.type = type;
		this.pdsSeq = pdsSeq;
		this.date = date;
	}
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getToId() {
		return toId;
	}

	public void setToId(String toId) {
		this.toId = toId;
	}

	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getPdsSeq() {
		return pdsSeq;
	}

	public void setPdsSeq(int pdsSeq) {
		this.pdsSeq = pdsSeq;
	}
	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "AlarmBean [seq=" + seq + ", toId=" + toId + ", fromId=" + fromId + ", type=" + type + ", pdsSeq="
				+ pdsSeq + ", date=" + date + "]";
	}
	
}
