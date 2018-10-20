package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ReplyBean;
import model.service.AlarmService;
import model.service.ReplyService;

public class ReplyController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReplyController 들어옴");
		String command = req.getParameter("command");
		System.out.println("command:" + command);
		if (command.equalsIgnoreCase("getList")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println(seq);
			List<ReplyBean> pds = ReplyService.getInstance().getReplyList(seq);
			System.out.println(pds);
			req.setAttribute("pds", pds);
			dispatch("picDetail.jsp", req, resp);
		} else if (command.equalsIgnoreCase("addReply")) {
			String id = req.getParameter("id");
			int pdsSeq = Integer.parseInt(req.getParameter("pdsSeq"));
			String reRefStr = req.getParameter("refSeq");
			String toWhom = req.getParameter("toWhom");
			int refSeq = 0;
			if (reRefStr != null) {
				refSeq = Integer.parseInt(reRefStr);
			}
			String content = req.getParameter("content");
			if (toWhom == null) {
				toWhom = "";
			}

			boolean isS = ReplyService.getInstance().addReply(id, toWhom, content, pdsSeq, refSeq);
		
			if (isS) {
				System.out.println("댓글 등록 성공");
			}
			resp.sendRedirect("PdsController?command=detailview&seq=" + pdsSeq);
		} else if (command.equalsIgnoreCase("delete")) {
			int pdsSeq = Integer.parseInt(req.getParameter("pdsSeq"));
			int reSeq = Integer.parseInt(req.getParameter("reSeq"));
			boolean isS = ReplyService.getInstance().deleteReply(reSeq);

			if (isS) {
				System.out.println("댓글 삭제 성공");
			}
			resp.sendRedirect("PdsController?command=detailview&seq=" + pdsSeq);
		} else if (command.equalsIgnoreCase("updateReply")) {
			int pdsSeq = Integer.parseInt(req.getParameter("pdsSeq"));
			int reSeq = Integer.parseInt(req.getParameter("reSeq"));
			String content = req.getParameter("content");

			boolean isS = ReplyService.getInstance().updateReply(reSeq, content);

			if (isS) {
				System.out.println("댓글 수정 성공");
			}
			resp.sendRedirect("PdsController?command=detailview&seq=" + pdsSeq);
		}
	}

	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}

}
