package model;

import java.util.List;

import dto.ReplyBean;

public interface iReplyManager {

	public List<ReplyBean> getReplyList(int seq);

	public boolean addReply(String id, String toWhom, String content, int pdsSeq, int refSeq);

	public boolean deleteReply(int reSeq);

	public ReplyBean getReply(int reSeq);

	public boolean updateReply(int reSeq, String content);

	public boolean readReply(int reSeq);

}
