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

//CREATE VIEW PDSALL (SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT)
//AS
//SELECT DISTINCT P.SEQ, P.ID, P.CATEGORY, P.TAGS, P.UPLOADDATE, P.FILENAME, P.READCOUNT, P.DOWNCOUNT, P.FSAVENAME,
//      (SELECT COUNT(*) FROM PDSLIKE, PICPDS WHERE PICPDS.SEQ = PDSLIKE.PDSSEQ),
//      (SELECT COUNT(*) FROM PDSREPLY, PICPDS WHERE PICPDS.SEQ = PDSREPLY.PDSSEQ)
//FROM PDSLIKE, PICPDS P, PDSREPLY

import java.io.Serializable;

import java.util.Arrays;

public class PdsBean implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8300464898308770593L;
	//////////// 5개씩 구분
	private int seq;
	private String id;
	private String category;
	private String[] tags;
	private String uploadDate;
	
	private String fileName;
	private int readCount;
	private int downCount;
	private String fileSaveName;
	private int likeCount;
	
	private int replyCount;
	////////////////////

	public PdsBean() { }

	public PdsBean(int seq, String id, String category, String[] tags, String uploadDate, String fileName,
			int readCount, int downCount, String fileSaveName, int likeCount, int replyCount) {
		super();
		this.seq = seq;
		this.id = id;
		this.category = category;
		this.tags = tags;
		this.uploadDate = uploadDate;
		this.fileName = fileName;
		this.readCount = readCount;
		this.downCount = downCount;
		this.fileSaveName = fileSaveName;
		this.likeCount = likeCount;
		this.replyCount = replyCount;
	}

	/**
	 * @return the seq
	 */
	public int getSeq() {
		return seq;
	}

	/**
	 * @param seq the seq to set
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the category
	 */
	public String getCategory() {
		return category;
	}

	/**
	 * @param category the category to set
	 */
	public void setCategory(String category) {
		this.category = category;
	}

	/**
	 * @return the tags
	 */
	public String[] getTags() {
		return tags;
	}

	/**
	 * @param tags the tags to set
	 */
	public void setTags(String[] tags) {
		this.tags = tags;
	}

	/**
	 * @return the uploadDate
	 */
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

	public String getFileSaveName() {
		return fileSaveName;
	}

	public void setFileSaveName(String fileSaveName) {
		this.fileSaveName = fileSaveName;
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

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PdsBean [seq=" + seq + ", id=" + id + ", category=" + category + ", tags=" + Arrays.toString(tags)
				+ ", uploadDate=" + uploadDate + ", fileName=" + fileName + ", readCount=" + readCount + ", downCount="
				+ downCount + ", fileSaveName=" + fileSaveName + ", likeCount=" + likeCount + ", replyCount="
				+ replyCount + "]";
	}
	
	
	
}
