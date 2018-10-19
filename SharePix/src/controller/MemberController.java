package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.FollowDto;
import dto.MemberBean;
import dto.PdsBean;
import model.service.MemberService;
import model.service.PdsService;

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
		PdsService pdsService = PdsService.getInstance();
		
		HttpSession session = req.getSession();
		
		if(command.equals("addUserPage")){		// 회원가입으로 이동
			System.out.println("command = " + command + " 들어옴");	// 확인용			
			dispatch("addUserPage.jsp", req, resp);			
		}else if(command.equals("idcheck")) {	// 아이디 중복 확인			
			String id = req.getParameter("id");
		    System.out.println("id = " + id);
		
		    boolean isS = memService.getId(id);
		   
		    PrintWriter out = resp.getWriter();
		    if(isS){
		    	out.print("NO");
		    	out.flush();
		    }else{
		    	out.print("OK");
		    	out.flush();
		    }
		    
		}else if(command.equals("regi")) { 			
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			String phone = req.getParameter("phone");
			
			boolean isS = memService.addMember(new MemberBean(id, name, pwd, email, phone, 0));

			if(isS) {
				
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('성공적으로 가입하셨습니다'); location.href='index.jsp';</script>");
				 
				out.flush();
			
			}else {	
				
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('다시 기입해 주십시오.'); location.href='regi.jsp';</script>");
				 
				out.flush();
				
			}
			
			//dispatch("index.jsp", req, resp);
		    
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
				
				// 자바에서 alert 사용하기 위해  혹은 session 에 담긴 mem이 null 일 때 로그인하라고 반환시 사용
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('안녕하세요." + dto.getName() + "님'); location.href='"+goBackTO+"';</script>");
				out.flush();
				
			}else if(dto == null || dto.getId().equals("")) {
				// 자바에서 alert 사용하기 위해  혹은 session 에 담긴 mem이 null 일 때 로그인하라고 반환시 사용
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('아이디 혹은 비밀번호가 틀렸습니다.'); location.href='index.jsp';</script>");
				out.flush();
				return;
			}
		}else if(command.equals("logout")){		// 로그아웃
			System.out.println("command = " + command + " 들어옴");	// 확인용
			session.invalidate();
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('안녕히 가십시오'); location.href='./index.jsp';</script>");
			out.flush();
			
			return;
		} else if(command.equals("userUpdatePage")){ // 회원정보 수정 페이지로 이동
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
		    
		    System.out.println("dto 출력 : " + dto.toString());
		    
			if(memService.updateUser(dto)) {	//	update가 되면 true 반환
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
		} else if(command.equals("userPage")) { // userPage 로 이동
			System.out.println("command = " + command + " 들어옴");	// 확인용
			req.setCharacterEncoding("utf-8");
			
			String pageId = req.getParameter("id");
						
			PdsBean pagePds = pdsService.getMyPdsAll(pageId); // 해당 유저 페이지의 유저 id로 찾은 pdsDto
			if(pagePds==null){
				pagePds = new PdsBean();
			}
			MemberBean pageMemDto = memService.getUserInfo(pageId);	//해당 페이지의 사용자 정보 가져온 memDto
			if(pageMemDto==null){
				pageMemDto = new MemberBean();
			}
			List<PdsBean> list = pdsService.getMyPdsAllList(pageId); // 해당 페이지의 사용자 정보 list
			if(list==null){
				list = new ArrayList<>();
			}
			List<FollowDto> fList = memService.getMyFollowerList(pageId); // 해당 페이지의 사용자를 팔로우 하는 사람 list
			if(fList==null){
				fList = new ArrayList<>();
			}
			List<FollowDto> sList = memService.getMySubscribeList(pageId); // 해당 페이지의 유저를 구독한 사람들 list
			if(sList==null){
				sList = new ArrayList<>();
			}
			List<PdsBean> lList= pdsService.getMyLikeList(pageId);	// 해당 페이지의 유저가 좋아요한 list
			if(lList==null){
				lList = new ArrayList<>();
			}
			
			req.setAttribute("pagePds", pagePds);
			req.setAttribute("pageMemDto", pageMemDto);
			req.setAttribute("list", list);
			req.setAttribute("fList", fList);
			req.setAttribute("sList", sList);
			req.setAttribute("lList", lList);
			
			dispatch("./userPage.jsp?id=" + pageId, req, resp);
		} else if(command.equals("follow")) { // 팔로우
			System.out.println("command = " + command + " 들어옴");	// 확인용
			
			String followerId = req.getParameter("followerId");
			String followeeId = req.getParameter("followeeId");
			boolean followChk = Boolean.parseBoolean(req.getParameter("followChk"));
			
			System.out.println("followChk : "+ followChk);
			memService.changeFollow(followerId, followeeId, !followChk); // follow 상태 바꿔줌
			resp.getWriter().write("<followChk>" +!followChk +"</followChk>");
			resp.getWriter().flush();
		}
	}
	
	public void dispatch( String urls, HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException { 
		RequestDispatcher dispatch = req.getRequestDispatcher(urls); // urls : 어디로 갈지
		dispatch.forward(req, resp);
	}
	
}
