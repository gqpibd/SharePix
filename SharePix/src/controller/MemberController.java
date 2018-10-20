package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dto.FollowDto;
import dto.MemberBean;
import dto.PdsBean;
import model.service.MemberService;
import model.service.PdsService;
import utils.ImageResize;

public class MemberController extends HttpServlet {
	
	public static final String PROFILEPATH = "C:\\Users\\이호영\\git\\sharePix\\SharePix\\WebContent\\images\\profiles";
	
	private ServletConfig mConfig = null; // 업로드 폴더의 realpath에 접근하기 위해서 필요하다
	
	public String profileUploadFile(FileItem fileItem, String dir, String dir2,String fSaveName) throws IOException {
		String fileName = fileItem.getName();
		long sizeInBytes = fileItem.getSize();	
		// 업로드한 파일 정상일 경우
		if(sizeInBytes > 0){ // c:\\temp\abc.jpg 또는 c:\\temp/abc.jpg
			int idx = fileName.lastIndexOf("\\"); // 파일 경로 중 폴더의 끝. 즉, 파일명 시작 앞의 인덱스를 가져옴.
			if(idx == -1){ // \를 못 찾으면
				idx = fileName.lastIndexOf("/"); // /를 찾아라
			}
			fileName = fileName.substring(idx+1); // 파일 이름부터 확장자까지 가져옴
			
			File uploadedFile = new File(dir, fSaveName + fileName.substring(fileName.lastIndexOf(".")));
			File uploadedFile2 = new File(dir2, fSaveName + fileName.substring(fileName.lastIndexOf(".")));
			try{
				fileItem.write(uploadedFile);
				fileItem.write(uploadedFile2);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return fileName;
	}

	@Override
	public void init(ServletConfig config) throws ServletException { // mConfig값을 받기 위해 사용
		super.init(config);
		mConfig = config;
	}
	
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
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		
		if (isMultipart) {
			System.out.print("profile upload");					
			
			String filePathServer = mConfig.getServletContext().getRealPath("/images/pictures"); // 톰캣에도 저장하자
			System.out.println(filePathServer);
			
			// form field 에 데이터(String)
			String id = "";
			String name = "";
			String pwd = "";
			String email = "";
			String phone = "";

			// file data
			String filename = ""; // 어떤 파일이 넘어오는지 정보를 얻기 위한 것
			String fSaveName = req.getParameter("id");

			////////////////////// file
			
			String fupload = PROFILEPATH;
			System.out.println("파일업로드:" + fupload);
			String yourTempDirectory = fupload;
			
			int yourMaxRequestSize = 1000 * 1024 * 1024; // 10M
			int yourMaxMemorySize = 1000 * 1024;

			// FileItem 오브젝트를 생성하는 클래스
			DiskFileItemFactory factory = new DiskFileItemFactory();

			factory.setSizeThreshold(yourMaxMemorySize);
			factory.setRepository(new File(yourTempDirectory));

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(yourMaxRequestSize); // 파일 업로드 최대 크기
			
			List<FileItem> items;
			try {
				items = upload.parseRequest(req);
				Iterator<FileItem> it = items.iterator();

				while (it.hasNext()) {
					FileItem item = it.next();
					if (item.isFormField()) {
						if (item.getFieldName().equals("id")) {
							id = item.getString("utf-8");
						} else if (item.getFieldName().equals("name")) {
							name = item.getString("utf-8");
						} else if (item.getFieldName().equals("pwd")) {
							pwd = item.getString("utf-8");
						} else if (item.getFieldName().equals("email")) {
							email = item.getString("utf-8");
						} else if (item.getFieldName().equals("phone")) {
							phone = item.getString("utf-8");
						}
					} else { // fileload
						if(item.getFieldName().equals("fileload")){
							filename = profileUploadFile(item, fupload, filePathServer, fSaveName);							
						}
						if(filename != null){
							System.out.println("저장 파일 경로 및 파일명: " + filename);							
							fSaveName = fSaveName+filename.substring(filename.lastIndexOf("."));
							System.out.println("저장 파일명: " + fSaveName);
							ImageResize.resize25(PROFILEPATH,fSaveName, filePathServer);
						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}	

			MemberService memberService = MemberService.getInstance();
			MemberBean memDto = new MemberBean(id, name, pwd, email, phone, -1);
			
			boolean isS = memberService.updateUser(memDto);

			if (isS) { // update가 되면 true 반환
				resp.sendRedirect("userPage.jsp?id=" + memDto.getId());
			} else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('개인정보 수정 실패'); location.href='./userPage.jsp?id=" + memDto.getId() + "';</script>");
				out.flush();
			}
		}
			
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
			
			boolean isS = memService.addMember(new MemberBean(id, name, pwd, email, phone, 1));

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
		} /*else if(command.equals("userUpdateAf")) {
			System.out.println("command = " + command + "  들어옴");	// 확인용
			
				String id			= req.getParameter("id");
				String name 		= req.getParameter("name");
				String pwd 		= req.getParameter("pwd");
				String email 		= req.getParameter("email");
				String phone		= req.getParameter("phone");
				
		  //String str_Phone1 	= req.getParameter("phone1");
		  //String str_Phone2 	= req.getParameter("phone2");
		  //String str_Phone3 	= req.getParameter("phone3");
		  //String phone = str_Phone1 + "-" + str_Phone2 + "-" + str_Phone3; // 번호 사이에 - 넣기
		    
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
		}*/ else if(command.equals("userPage")) { // userPage 로 이동
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
