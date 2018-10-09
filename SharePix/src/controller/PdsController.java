package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PdsBean;
import model.iPdsManager;
import model.service.PdsService;

public class PdsController extends HttpServlet {
	
	public static final String PATH = "images/"; 
	
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
		}
	}
	
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}
		
}
