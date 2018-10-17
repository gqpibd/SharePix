package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dto.PdsBean;
import model.service.PdsService;

public class PdsController extends HttpServlet {	
	public static final String PATH = "C:\\Users\\이호영\\git\\sharePix\\SharePix\\WebContent\\images\\pictures"; 
	public String processUploadedFile(FileItem fileItem, String dir, String fSaveName) throws IOException {
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
			try{
				fileItem.write(uploadedFile);
			}catch(Exception e){
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
/*			PagingBean paging = new PagingBean();
			List<PdsBean> searchList = PdsService.getInstance().getPdsPagingList(paging, keyword);*/
			System.out.println("후 확인keyword dto"+ keyword);
			req.setAttribute("keyword", keyword);
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
		} else if(command.equals("pdsUpdatePage")){
			System.out.println("command = " + command + "  들어옴");	// 확인용
			dispatch("./pdsUpdatePage.jsp", req, resp);
		} else if(command.equals("delete")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
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
			
		} else if(command.equals("pdsupdate")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			String category		= req.getParameter("category");
			String tags 		= req.getParameter("tags");
			
			System.out.println("category : " + category);
			System.out.println("tags : " + tags);
			System.out.println("seq : " + seq);
		
			PdsService up = PdsService.getInstance();
			PdsBean pds = new PdsBean(category, tags);
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
			
			String fupload = PATH.substring(0,PATH.length()-2);

			System.out.println("파일업로드:" + fupload);

			String yourTempDirectory = fupload;

			int yourMaxRequestSize = 1000 * 1024 * 1024; // 10M
			int yourMaxMemorySize = 1000 * 1024;

			// form field 에 데이터(String)
			String id = "";
			String category = "";
			String tags = "";

			// file data
			String filename = ""; // 어떤 파일이 넘어오는지 정보를 얻기 위한 것
			String fSaveName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

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
						if(item.getFieldName().equals("fileload")){
							filename = processUploadedFile(item, fupload, fSaveName);
						}
						if(filename != null){
							System.out.println("저장 파일 경로 및 파일명: " + filename);
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
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
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
		
}
