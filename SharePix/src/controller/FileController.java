package controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dto.PdsBean;
import model.service.AlarmService;
import model.service.PdsService;
import utils.ImageResize;

public class FileController extends HttpServlet {
	public static final String PATH =  "C:\\Users\\이호영\\git\\sharePix\\SharePix\\WebContent\\images\\pictures";
	//public static final String PATH =  "http://13.125.193.248//var/lib/tomcat8/webapps/ROOT/images/pictures";

	 
	private ServletConfig mConfig = null; // 업로드 폴더의 realpath에 접근하기 위해서 필요하다
	private static final int BUFFER_SIZE = 10000000; // 10Mb
	
	public String processUploadedFile(FileItem fileItem, String dir, String dir2,String fSaveName) throws IOException {
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
				fileItem.write(uploadedFile2);
				System.out.println("여기에 저장해줘(server) : " + dir2 + "/" + fSaveName + fileName.substring(fileName.lastIndexOf(".")));
			}catch(Exception e){
				e.printStackTrace();
			}
			/*try{
				System.out.println("여기에 저장해(local) : " + dir + "/" + fSaveName + fileName.substring(fileName.lastIndexOf(".")));
				fileItem.write(uploadedFile);
			}catch(Exception e){
				e.printStackTrace();
			}*/
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
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);		
		if (isMultipart) {				
			
			String filePathServer = mConfig.getServletContext().getRealPath("/images/pictures"); // 톰캣에도 저장하자
			System.out.println("ServerPath : " +filePathServer);
			
			// form field 에 데이터(String)
			String id = "";
			String category = "";
			String tags = "";

			// file data
			String filename = ""; // 어떤 파일이 넘어오는지 정보를 얻기 위한 것
			String fSaveName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

			////////////////////// file
			
			String fupload = PATH;
			System.out.println("파일업로드:" + fupload);
			//String yourTempDirectory = fupload;
			
			String yourTempDirectory = filePathServer;
			
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
						} else if (item.getFieldName().equals("category")) {
							category = item.getString("utf-8");
						} else if (item.getFieldName().equals("tags")) {
							tags = item.getString("utf-8");
						}
					} else { // fileload
						if(item.getFieldName().equals("fileload")){
							filename = processUploadedFile(item, fupload, filePathServer, fSaveName);
							//filename = processUploadedFile(item, null, filePathServer, fSaveName);
						}
						if(filename != null){
							System.out.println("저장 파일 경로 및 파일명: " + filename);
							
							if(filename.lastIndexOf(".")!=-1) {
								fSaveName = fSaveName+filename.substring(filename.lastIndexOf("."));
							}
							System.out.println("저장 파일명: " + fSaveName);
							ImageResize.resize25(fupload,fSaveName, filePathServer);
						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}	

			PdsService pd = PdsService.getInstance();
			PdsBean pds = new PdsBean(id, category, tags);
			pds.setFileName(filename);
			pds.setfSaveName(fSaveName);
			boolean isS = pd.writePds(pds);			

			if (isS) { // update가 되면 true 반환
				int seq = PdsService.getInstance().getCurrSeq(); // 당연히 동기화 문제가 생길 수 있지만.. 일단 그냥 쓰자
				pds.setSeq(seq);
				AlarmService.getInstance().insertAlarm(pds);
				resp.sendRedirect("PdsController?command=detailview&seq=" + seq);
			} else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('업로드 실패'); location.href='./pdswrite.jsp';</script>");
				out.flush();
			}			
		}else {
			String command = req.getParameter("command");
			System.out.println("filemanager command : " + command);			
			if (command.equalsIgnoreCase("download")) { // 파일 다운로드
				boolean success= false;
				int rate = Integer.parseInt(req.getParameter("rate"));
				String filename = req.getParameter("filename");
				String fsavename = req.getParameter("fsavename");
				int pdsSeq = Integer.parseInt(req.getParameter("pdsSeq"));
				System.out.println(rate + " " + filename + " " + fsavename);			
				BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
				try {
					String filePath = mConfig.getServletContext().getRealPath("/images/pictures") +"\\"+ fsavename;
					//String filePath = PATH +"\\"+ fsavename;
					
					
					if(rate != 100) {
						filePath = ImageResize.resize(filePath,rate);
						
						int idx = filePath.lastIndexOf("\\"); // 파일 경로 중 폴더의 끝. 즉, 파일명 시작 앞의 인덱스를 가져옴.
						if(idx == -1){ // \를 못 찾으면
							idx = filePath.lastIndexOf("/"); // /를 찾아라
						}
						filename = filePath.substring(idx+1); // 파일 이름부터 확장자까지 가져옴
					}
					File f = new File(filePath);
					System.out.println("파일경로:" + filePath);
	
					if (f.exists() && f.canRead()) {
						// 다운로드창 설정
						resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
						resp.setHeader("Content-Transfer-Encoding", "binary;");
						resp.setHeader("Content-Length", "" + f.length());
						resp.setHeader("Pragma", "no-cache;");
						resp.setHeader("Expires", "-1;"); // -1 : 만기시간 무제한
	
						// 파일을 생성, 기입
						BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
						byte buffer[] = new byte[BUFFER_SIZE];
	
						int read = 0;
	
						while ((read = fileInput.read(buffer)) != -1) {
							out.write(buffer, 0, read);
						}
	
						fileInput.close();
						out.flush();
						
						success=true;		
					} else {
						System.out.println("파일이 존재하지 않습니다.");
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (out != null) {
						out.flush();
						out.close();
					}
				}
				if(success) {
					 PdsService.getInstance().increaseDowncount(pdsSeq);
				}			
			}
		}
	}
}
