package manager;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.service.PdsService;

public class FileManager extends HttpServlet {

	private ServletConfig mConfig = null; // 업로드 폴더의 realpath에 접근하기 위해서 필요하다
	private static final int BUFFER_SIZE = 10000000; // 10Mb

	public void fileUploader(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// javascript에서 locatoin.href로 넘어오는 것은 get으로 넘어온다!!
		/*
		 * System.out.println("FileDownloader doGet");
		 * 
		 * String filename = req.getParameter("filename"); int seq =
		 * Integer.parseInt(req.getParameter("seq"));
		 * 
		 * // download 횟수를 여기서 증가시켜 주면 됨 iPdsManager pDao = PdsManager.getInstance();
		 * pDao.increadDowncount(seq);
		 * 
		 * String savedfile = pDao.getFSaveName(seq);
		 * 
		 * BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		 * try { String filePath = "";
		 * 
		 * // tomcat // filePath = mConfig.getServletContext().getRealPath("/upload");
		 * 
		 * // 폴더 filePath = "d:\\tmp";
		 * 
		 * //filePath = filePath + "\\" + filename; filePath = filePath + "\\" +
		 * savedfile;
		 * 
		 * File f = new File(filePath); System.out.println("파일경로:" + filePath);
		 * 
		 * if (f.exists() && f.canRead()) { // 다운로드창 설정
		 * resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename +
		 * "\";"); resp.setHeader("Content-Transfer-Encoding", "binary;");
		 * resp.setHeader("Content-Length", "" + f.length()); resp.setHeader("Pragma",
		 * "no-cache;"); resp.setHeader("Expires", "-1;"); // -1 : 만기시간 무제한
		 * 
		 * // 파일을 생성, 기입 BufferedInputStream fileInput = new BufferedInputStream(new
		 * FileInputStream(f)); byte buffer[] = new byte[BUFFER_SIZE];
		 * 
		 * int read = 0;
		 * 
		 * while ((read = fileInput.read(buffer)) != -1) { out.write(buffer, 0, read); }
		 * 
		 * fileInput.close(); out.flush(); } else {
		 * System.out.println("파일이 존재하지 않습니다."); } } catch (Exception e) {
		 * e.printStackTrace(); } finally { if (out != null) { out.flush(); out.close();
		 * } }
		 */
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
		String command = req.getParameter("command");
		System.out.println("filemanager command : " + command);
		if (command.equalsIgnoreCase("download")) {
			
		}
	}

}
