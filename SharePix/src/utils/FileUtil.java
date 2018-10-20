package utils;

import java.io.File;

public class FileUtil {

	public static boolean deleteFile(String localPath, String tomcatPath) {		
		boolean sDel = false;	

		File f = new File(localPath);		
				
		System.out.println("파일경로:" + localPath);

		if (f.exists() && f.canRead()) {
			sDel = f.delete();
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
		String smallPath = localPath.substring(0, localPath.lastIndexOf('.')) + "_small" + localPath.substring(localPath.lastIndexOf('.'));
		f = new File(smallPath);
		if (f.exists() && f.canRead()) {
			sDel = f.delete();
			System.out.println("small 삭제");
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
		
		if(tomcatPath != null) { // 톰캣에서도 지우기
			f = new File(tomcatPath);
	
			if (f.exists() && f.canRead()) {
				f.delete();
			} else {
				System.out.println("파일경로:" + tomcatPath);
				System.out.println("파일이 존재하지 않습니다.");
			}
			
			smallPath = tomcatPath.substring(0, tomcatPath.lastIndexOf('.')) + "_small" + tomcatPath.substring(tomcatPath.lastIndexOf('.'));
			f = new File(smallPath);
			if (f.exists() && f.canRead()) {
				sDel = f.delete();
				System.out.println("small 삭제");
			} else {
				System.out.println("파일이 존재하지 않습니다.");
			}
		}			
		return sDel;		
	}
}
