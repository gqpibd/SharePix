package controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PdsService;

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
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		// 현재 시간 출력인데 편의상 쓰는 거라 지워도 됨	///////////////
		req.setCharacterEncoding("utf-8");
		Date now = new Date();
		System.out.println("--- pdsControl 시간 : " + now);
		///////////////////////////////////////////////////
		
		String command = req.getParameter("command");
		System.out.println("Pds / doProcess로  들어온 command : " + command);
		PdsService service = PdsService.getInstance();
	}
	
	public void dispatch( String urls, HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException { 
		RequestDispatcher dispatch = req.getRequestDispatcher(urls); // urls : 어디로 갈지
		dispatch.forward(req, resp);
	}
		
}
