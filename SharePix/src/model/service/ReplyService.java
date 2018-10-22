package model.service;

import java.util.List;

import dto.ReplyBean;
import model.ReplyManager;
import model.iReplyManager;

public class ReplyService {
	private static ReplyService reService = new ReplyService();
	private iReplyManager rManager;

	private ReplyService() {
		rManager = new ReplyManager();
	}

	public static ReplyService getInstance() {
		return reService;
	}

	public List<ReplyBean> getReplyList(int seq) {
		return rManager.getReplyList(seq);
	}

	public boolean addReply(String id, String toWhom, String content,  int pdsSeq, int refSeq) {
		AlarmService.getInstance().insertAlarm(id,toWhom,pdsSeq,content);
		return rManager.addReply(id,toWhom,content,pdsSeq,refSeq);		
	}

	public boolean deleteReply(int reSeq) {
		return rManager.deleteReply(reSeq);
	}
	
	public ReplyBean getReply(int reSeq) {
		return rManager.getReply(reSeq);
	}

	public boolean updateReply(int reSeq, String content) {
		return rManager.updateReply(reSeq, content);
	}

}
