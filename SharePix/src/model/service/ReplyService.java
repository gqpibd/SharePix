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

}
