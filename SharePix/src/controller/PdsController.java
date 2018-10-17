package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dto.MemberBean;
import dto.PdsBean;
import model.PdsManager;
import model.iPdsManager;
import model.service.PdsService;
import model.service.ReplyService;

public class PdsController extends HttpServlet {	
	public static final String PATH = "images\\pictures\\"; 
	public String processUploadFile(FileItem fileItem, String dir, JspWriter out) throws IOException {
		String f = fileItem.getName();
		long sizeInBytes = fileItem.getSize();

		String fileName = "";
		String fpost = "";

		// 업로드한 파일이 정상일 경우
		if (sizeInBytes > 0) {
			if (f.indexOf('.') >= 0) {
				fpost = f.substring(f.indexOf('.'));
				fileName = new Date().getTime() + fpost;
			} else {
				fileName = new Date().getTime() + ".back";
			}
			try {
				File uploadFile = new File(dir, fileName);
				fileItem.write(uploadFile); // 실제 업로드하는 부분
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return fileName;
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
		System.out.println("PdsController 들어옴");
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		String command = "";
		if (!isMultipart) {
			command = req.getParameter("command");
		}
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
			System.out.println("검색 키워드 : " + keyword);
			System.out.println("전 확인keyword dto");
			List<PdsBean> searchList = PdsService.getInstance().getSearchPds(keyword);
			System.out.println("후 확인keyword dto");
			req.setAttribute("searchList", searchList);
			dispatch("SearchView.jsp", req, resp);
		} else if(command.equalsIgnoreCase("likeChange")) {
			int seq=0;
			boolean like = Boolean.parseBoolean(req.getParameter("like"));
			String id = req.getParameter("id");
			seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println("like:"+like);
			System.out.println("id:"+id);
			System.out.println("seq:"+seq);
			PdsService.getInstance().chageLike(id, seq, !like); // like 상태 바꿔줌
			int count = PdsService.getInstance().getLikeCount(seq);
			resp.getWriter().write("<like>" +!like +"</like><count>" + count +"</count>");
			resp.getWriter().flush();
			System.out.println("count:" + count);
			//req.setAttribute("pds", pds);
		} else if(command.equalsIgnoreCase("myLikePdsList")) {
			String id = req.getParameter("id");
			List<PdsBean> list = PdsService.getInstance().myLikePdsList(id); // 즐겨찾기한 사진들을 모아서 보여줌
			req.setAttribute("list", list);
			dispatch("myLikes.jsp", req, resp);	
		} else if(command.equals("updatePds")){
			System.out.println("command = " + command + "  들어옴");	// 확인용
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
		
		
		if (isMultipart) {
			System.out.print("upload");
			
			String fupload ="images/pictures";

			System.out.println("파일업로드:" + fupload);

			String yourTempDirectory = fupload;
			
			
			

			int yourMaxRequestSize = 1000 * 1024 * 1024; // 10M
			int yourMaxMemorySize = 1000 * 1024;

			// form field 에 데이터(String)
			String id = "";
			String category = "";
			String tags = "";

			// file data
			String filename = "";		

			////////////////////// file

			// FileItem 오브젝트를 생성하는 클래스
			DiskFileItemFactory factory = new DiskFileItemFactory();

			factory.setSizeThreshold(yourMaxMemorySize);
			factory.setRepository(new File(yourTempDirectory));

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(yourMaxRequestSize); // 파일 업로드 최대 크기

			///////////////////////////

			List<FileItem> items;
			
			try {
				items = upload.parseRequest(req);
				Iterator<FileItem> it = items.iterator();

				while (it.hasNext()) {
					FileItem item = it.next();
					if (item.isFormField()) {
						if (item.getFieldName().equals("id")) {
							id = item.getString("utf-8");
						} else if (item.getFieldName().equals("category")) {
							category = item.getString("utf-8");
						} else if (item.getFieldName().equals("tags")) {
							tags = item.getString("utf-8");
						}
					} else { // fileload
						if (item.getFieldName().equals("fileload")) {
							filename = processUploadFile(item, fupload, null);
							System.out.println("fupload:" + fupload+filename);
						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}	

			PdsService pd = PdsService.getInstance();
			PdsBean pds = new PdsBean(id, category, tags);
			pds.setFileName(filename);
			pds.setfSaveName(filename);
			boolean isS = pd.writePds(pds);
			

			if (isS) { // update가 되면 true 반환		
				dispatch("./index.jsp", req, resp);
			} else {
				PrintWriter out = resp.getWriter();
				resp.setContentType("text/html; charset=UTF-8");
				out.println("<script>alert('업로드 실패'); location.href='./pdswrite.jsp';</script>");
				out.flush();
			}
		}		
	}
	
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}
	
	
	/*public String processUploadedFile(FileItem fileItem, String dir, JspWriter out) throws IOException{
		
		String fileName = fileItem.getName();
		long sizeInBytes = fileItem.getSize();
		
		//업로드한 파일이 정상일 경우
		if(sizeInBytes>0){ 
			int idx = fileName.lastIndexOf("\\"); 
			
			만약 파일명이 c:\\temp\abc.jpg라면 뒤에서부터 가장 첫 \를 찾아 \뒤의 abc.jpg를 가지고 오기 위해서.
			
			if(idx==-1){ // \ 못찾음. 
				idx = fileName.lastIndexOf("/");
			}
			fileName = fileName.substring(idx+1);//그 다음거도 다 가지고 와라. abc.jpg
			
			try{
			File uploadedFile = new File(dir, fileName); // c:\\temp\abc.jpg는 지정해둔 특정 구역에 들어 가고오있다.
			fileItem.write(uploadedFile);
			
			
			}catch(Exception e){}
		}
		return fileName; 
	}*/
	
		
}