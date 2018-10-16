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
	
	public static final String PATH = "images/pictures/"; 
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
		int seq=0;
		if(command.equalsIgnoreCase("detailview")) {
			seq = Integer.parseInt(req.getParameter("seq"));
			System.out.println(seq);
			PdsBean pds = PdsService.getInstance().getPdsDetail(seq);
			System.out.println(pds);
			
			// 추천피드
			List<PdsBean> list = PdsService.getInstance().relatedList(pds.getCategory(),seq); // 같은 카테고리의 사진들을 모아서 보여줌
			System.out.println(list.size());
					
			
			req.setAttribute("list", list);
			
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
		} else if(command.equals("delete")) {

			boolean isS = PdsService.getInstance().delPDS(seq);
			if(isS) {
				System.out.println("삭제 성공");
				
			resp.sendRedirect("PdsController?command=detailview&seq=" + seq);
			dispatch("./updatePds.jsp", req, resp);
			}	
			else{
				
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('삭제 실패'); location.href='./updatePds.jsp';</script>");
			}
			
		}
		
		
	
			
		
			
					
		if (isMultipart) {
			System.out.print("upload");
			
			String fupload = "C:\\Users\\user2\\git\\SharePix\\SharePix\\WebContent\\images\\pictures\\";

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

			if (isS) { // write가 되면 true 반환
				dispatch("./updatePds.jsp", req, resp);
			} else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('업로드 실패'); location.href='./pdswrite.jsp';</script>");
				out.flush();
			}
		}else if(command.equals("pdsupload")) {
			req.setCharacterEncoding("utf-8");
			System.out.println("command = " + command + "  들어옴");	// 확인용
			
			String category		= req.getParameter("category");
			String tags 		= req.getParameter("tags");
			
			System.out.println("category : " + category);
			System.out.println("tags : " + tags);
			    
		/*	PdsService pd = PdsService.getInstance();*/
		    PdsBean dto = new PdsBean(category, tags);
		    dto.setSeq(seq);
			
			boolean isS = PdsService.getInstance().updatePDS(dto);
			
			if (isS) { // update가 되면 true 반환
				dispatch("./index.jsp", req, resp);
			} else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('수정 실패'); location.href='./pdswrite.jsp';</script>");
				out.flush();
			}
		}else if(command.equals("pdsupdate")) {
			String category		= req.getParameter("category");
			String tags 		= req.getParameter("tags");
			String seqStr = req.getParameter("seq");
			seq = Integer.parseInt(seqStr);
			
			System.out.println("category : " + category);
			System.out.println("tags : " + tags);
			System.out.println("seq : " + seq);
		
			PdsService up = PdsService.getInstance();
			PdsBean pds = new PdsBean(category, tags);
			boolean isS = up.updatePDS(pds);
	
			if(isS) {
				dispatch("./updatePds.jsp?seq=", req, resp);			
				//resp.sendRedirect("PdsController?command=detailview&seq=" + seq);
			}		
			else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				
				out.println("<script>alert('수정 실패'); location.href='./pdswrite.jsp';</script>");
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
