package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.MemberBean;
import model.service.MemberService;

public class MemberController extends HttpServlet {

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
		
		String command = req.getParameter("command");
		System.out.println("Member / doProcess로  들어온 command : " + command);		
		MemberService memService = MemberService.getInstance();
		
		// 오류 나서 session 지역변수로 뺐
		HttpSession session = req.getSession();
		
		if(command.equals("addUserPage")){		// 회원가입으로 이동
			System.out.println("command = " + command + " 들어옴");	// 확인용
			
			dispatch("addUserPage.jsp", req, resp);
		}else if(command.equals("login")) {	// 로그인 버튼 눌렀을 시 아이디 비밀번호 맞으면 페이지로 이동
			System.out.println("command = " + command + " 들어옴");	// 확인용
			
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String goBackTO = req.getParameter("goBackTo");
			
			MemberBean dto = null;
			dto = memService.loginAf(id, pwd);
			
			if (dto != null) {// 로그인해서 dto가 db로부터 찾아졌을 때
				session.setAttribute("login", dto);
				session.setMaxInactiveInterval(30*60);
				
				// 자바에서 alert 사용하기 위해  / TODO:혹은 session 에 담긴 mem이 null 일 때 로그인하라고 반환시 사용
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('안녕하세요." + dto.getName() + "님'); location.href='"+goBackTO+"';</script>");
				out.flush();
				
			}else if(dto == null || dto.getId().equals("")) {
				// 자바에서 alert 사용하기 위해  / TODO:혹은 session 에 담긴 mem이 null 일 때 로그인하라고 반환시 사용
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('아이디 혹은 비밀번호가 틀렸습니다.'); location.href='index.jsp';</script>");
				out.flush();
				return;
			}
			
		}else if(command.equals("logout")){		
			System.out.println("command = " + command + " 들어옴");	// 확인용
			session.invalidate();
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('안녕히 가십시오'); location.href='./index.jsp';</script>");
			out.flush();
			
			return;
		}else if(command.equals("myPage")) {	// 마이페이지로 이동
			System.out.println("command = " + command + " 들어옴");	// 확인용
			dispatch("./myPage.jsp", req, resp);
		} else if(command.equals("userUpdatePage")){
			System.out.println("command = " + command + "  들어옴");	// 확인용
			dispatch("./userUpdatePage.jsp", req, resp);
		} else if(command.equals("userUpdateAf")) {
			System.out.println("command = " + command + "  들어옴");	// 확인용
			
			String id			= req.getParameter("id");
			String name 		= req.getParameter("name");
		    String pwd 			= req.getParameter("pwd");
		    String email 		= req.getParameter("email");
		    String str_Phone1 	= req.getParameter("phone1");
		    String str_Phone2 	= req.getParameter("phone2");
		    String str_Phone3 	= req.getParameter("phone3");
		    
		    String phone = str_Phone1 + "-" + str_Phone2 + "-" + str_Phone3; // 번호 사이에 - 넣기
		    
		    MemberBean dto = new MemberBean(id, name, pwd, email, phone, -1);
		    
			if(memService.manager.updateUser(dto)) {	//	update가 되면 true 반환
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('정보가 수정되었습니다.'); location.href='./userUpdatePage.jsp'; </script>");
				out.flush();
				
			}else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('수정 실패'); location.href='./userUpdatePage.jsp';</script>");
				out.flush();
				
			}
		}
	}
	
	public void dispatch( String urls, HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException { 
		RequestDispatcher dispatch = req.getRequestDispatcher(urls); // urls : 어디로 갈지
		dispatch.forward(req, resp);
	}
	
}
