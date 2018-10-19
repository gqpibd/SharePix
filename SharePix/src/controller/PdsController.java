package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PdsBean;
import model.service.PdsService;
import utils.CollenctionUtil;

public class PdsController extends HttpServlet {	
	
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
			int seq=0;
			seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println(seq);
			PdsBean pds = PdsService.getInstance().getPdsDetail(seq);
			System.out.println(pds);
			
			// 조회수 증가
			PdsService.getInstance().increaseReadcount(seq);
			// 추천피드
			List<PdsBean> list = PdsService.getInstance().relatedList(pds.getCategory(),seq); // 같은 카테고리의 사진들을 모아서 보여줌
			System.out.println(list.size());		
			req.setAttribute("list", list);		
			req.setAttribute("pds", pds);
			dispatch("picDetail.jsp", req, resp);			
		} else if (command.equalsIgnoreCase("keyword")) {
			String keyword = req.getParameter("tags");
			String choice = req.getParameter("choice");
			System.out.println("검색 키워드 : " + keyword);
			System.out.println("검색 키워드 : " + choice);
/*			PagingBean paging = new PagingBean();
			List<PdsBean> searchList = PdsService.getInstance().getPdsPagingList(paging, keyword);*/

			req.setAttribute("keyword", keyword);
			req.setAttribute("choice", choice);
			dispatch("SearchView.jsp", req, resp);
		} else if(command.equalsIgnoreCase("likeChange")) {
			int seq=0;
			String id = req.getParameter("id");
			seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println("id:"+id);
			System.out.println("seq:"+seq);
			boolean like = PdsService.getInstance().changeLike(id, seq); // like 상태 바꿔줌
			int count = PdsService.getInstance().getLikeCount(seq);
			resp.getWriter().write("<like>" +like +"</like><count>" + count +"</count>");
			resp.getWriter().flush();
			System.out.println("count:" + count);
			// req.setAttribute("pds", pds);
		} else if (command.equals("updatePds")) {
			System.out.println("command = " + command + "  들어옴"); // 확인용
			dispatch("./updatePds.jsp", req, resp);
		} else if(command.equals("delete")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			boolean isS = PdsService.getInstance().delPDS(seq);
			if(isS) {
				System.out.println("삭제 성공");
				//resp.sendRedirect("PdsController?command=detailview&seq=" + seq);
				resp.sendRedirect("./index.jsp");
			}	
			else{
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('삭제 실패'); location.href='./updatePds.jsp';</script>");
			}
			
		} else if(command.equals("pdsupdate")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			String category		= req.getParameter("category");
			String tags 		= req.getParameter("tags");
			
			System.out.println("category : " + category);
			System.out.println("tags : " + tags);
			System.out.println("seq : " + seq);
		
			PdsService up = PdsService.getInstance();
			
			PdsBean pds = new PdsBean(category, tags);
			pds.setSeq(seq);
			boolean isS = up.updatePDS(pds);
	
			if(isS) {
				dispatch("PdsController?command=detailview&seq=" + seq, req, resp);
			}		
			else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('수정 실패'); location.href='./pdswrite.jsp';</script>");
				out.flush();
			}
			
			
		} 	
		
		else if(command.equals("singo")) {
			int seq = Integer.parseInt(req.getParameter("seq"));

			PdsService singo = PdsService.getInstance();
			boolean isS = singo.updatereport(seq);
	
			if(isS) {
				dispatch("PdsController?command=detailview&seq=" + seq, req, resp);
			}		
			else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('수정 실패'); location.href='./index.jsp';</script>");
				out.flush();
			}
			
			
		} 
	}

	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp); 
	}
	
			
} 
