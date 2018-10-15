package dto;

//	DROP TABLE PICPDS
//	CASCADE CONSTRAINTS;
//
//	CREATE TABLE PICPDS(
//	   SEQ NUMBER(10) NOT NULL PRIMARY KEY,
//	   ID VARCHAR2(50) NOT NULL,
//	   CATEGORY VARCHAR2(100) NOT NULL,
//	   TAGS VARCHAR2(500),
//	   UPLOADDATE DATE NOT NULL,
//	   FILENAME VARCHAR2(50) NOT NULL,
//	   READCOUNT NUMBER(10) NOT NULL,
//	   DOWNCOUNT NUMBER(10) NOT NULL,
//	   CONSTRAINT fk_picpds_id FOREIGN KEY(ID) REFERENCES MEMBER(ID)
//	);
//
//	DROP SEQUENCE PICPDS_SEQ;
//	
//	CREATE SEQUENCE PICPDS_SEQ
//	START WITH 1
//	INCREMENT BY 1;


import java.io.Serializable;
import java.util.Arrays;

public class PdsBean implements Serializable {

	private static final long serialVersionUID = 8300464898308770593L;

	private int seq;
	private String id;
	private String category;
	private String[] tags;
	private String uploadDate;
	private String fileName;
	private int readCount;
	private int downCount;
	private int likeCount;
	private int replyCount;
	private String fSaveName;

	public PdsBean() { }

	public PdsBean(int seq, String id, String category, String[] tags, String uploadDate, String fileName, int readCount,
			int downCount, int likeCount, int replyCount, String fSaveName) {
		super();
		this.seq = seq;
		this.id = id;
		this.category = category;
		this.tags = tags;
		this.uploadDate = uploadDate;
		this.fileName = fileName;
		this.readCount = readCount;
		this.downCount = downCount;
		this.likeCount = likeCount;
		this.replyCount = replyCount;
		this.fSaveName = fSaveName;
	}
	
	public PdsBean(int seq, String id, String category, String[] tags) {
		super();
		this.seq = seq;
		this.id = id;
		this.category = category;
		this.tags = tags;
	}
	

	public PdsBean(String id, String category, String tags) {		
		this.id = id;
		this.category = category;
		this.tags = tags.substring(1).split("#");
	}
	
	public PdsBean(String category, String tags) {		
		this.category = category;
		this.tags = tags.substring(1).split("#");
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String[] getTags() {
		return tags;
	}

	public void setTags(String[] tags) {
		this.tags = tags;
	}

	public String getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public int getDownCount() {
		return downCount;
	}

	public void setDownCount(int downCount) {
		this.downCount = downCount;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public String getfSaveName() {
		return fSaveName;
	}

	public void setfSaveName(String fSaveName) {
		this.fSaveName = fSaveName;
	}

	@Override
	public String toString() {
		return "PdsBean [seq=" + seq + ", id=" + id + ", category=" + category + ", tags=" + Arrays.toString(tags)
				+ ", uploadDate=" + uploadDate + ", fileName=" + fileName + ", readCount=" + readCount + ", downCount="
				+ downCount + ", likeCount=" + likeCount + ", replyCount=" + replyCount + ", fSaveName=" + fSaveName
				+ "]";
	}
}
