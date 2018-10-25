package utils;

import java.io.File;

public class FileUtil {

	public static boolean deleteFile(String localPath, String tomcatPath) {		
		boolean sDel = false;	
		
		if(localPath != null) {
			sDel = deleteFile(localPath);
		}
		
		if(tomcatPath != null) {
			sDel = deleteFile(tomcatPath);
		}

		
		return sDel;		
	}
	
	public static boolean deleteFile(String path) {
		boolean sDel = false;	
		File f = new File(path);		
		
		if (f.exists() && f.canRead()) {
			sDel = f.delete();
			if(sDel) {
				System.out.println("파일경로:" + path + " 지움");
			}
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
		String smallPath = path.substring(0, path.lastIndexOf('.')) + "_small" + path.substring(path.lastIndexOf('.'));
		f = new File(smallPath);
		if (f.exists() && f.canRead()) {
			sDel = f.delete();
			if(sDel) {
				System.out.println("small 지움");
			}
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
		return sDel;
	}
}
