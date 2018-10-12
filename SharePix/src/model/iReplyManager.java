package model;

import java.util.List;

import dto.ReplyBean;

public interface iReplyManager {

	public List<ReplyBean> getReplyList(int seq);

	public boolean addReply(String id, String content, int pdsSeq, int refSeq);

}
