package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PdsBean;
import model.service.PdsService;

public class PdsController extends HttpServlet {
	
	public static final String PATH = "images/pictures/"; 
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("PdsController 들어옴");
		String command = req.getParameter("command");
		System.out.println("command:" + command);
		if(command.equalsIgnoreCase("detailview")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println(seq);
			PdsBean pds = PdsService.getInstance().getPdsDetail(seq);
			System.out.println(pds);
			req.setAttribute("pds", pds);
			dispatch("picDetail.jsp", req, resp);			
		} else if (command.equalsIgnoreCase("keyword")) {
			String keyword = req.getParameter("tags");
			System.out.println(keyword);
			PdsBean pds = PdsService.getInstance().getSearchPds(keyword);
			System.out.println(pds);
			req.setAttribute("pds", pds);
		} else if(command.equalsIgnoreCase("likeChange")) {
			boolean like = Boolean.parseBoolean(req.getParameter("like"));
			String id = req.getParameter("id");
			int seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println("like:"+like);
			System.out.println("id:"+id);
			System.out.println("seq:"+seq);
			PdsService.getInstance().chageLike(id, seq, !like); // like 상태 바꿔줌
			int count = PdsService.getInstance().getLikeCount(seq);
			resp.getWriter().write("<like>" +!like +"</like><count>" + count +"</count>");
			resp.getWriter().flush();
			System.out.println("count:" + count);
		} else if(command.equalsIgnoreCase("increaseDowncount")) {
			int seq = Integer.parseInt(req.getParameter("pdsSeq"));
			boolean isS = PdsService.getInstance().increaseDowncount(seq);
			
			if(isS) {
				System.out.println("다운로드 수 증가");
			}
			
			PdsBean pds = PdsService.getInstance().getPdsDetail(seq);			
			req.setAttribute("pds", pds);
			dispatch("picDetail.jsp", req, resp);			
		}
	}
	
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}
		
}
