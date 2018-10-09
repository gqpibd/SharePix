package utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class CalUtil {

	public static String two(String msg){
		return msg.trim().length() < 2 ? "0" + msg : msg.trim(); // 한 자리 수 일 때 앞에 0 추가
	}
	
	// Date -> String 18/10/02
	// String -> Date yyyy-mm-dd
	public static String toDates(String mdate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분"); // 대소문자 주의!
		
		// 201810021607 --> 2018-10-02 16:07
		String s = mdate.substring(0, 4) + "-"	 	// yyyy 
				 + mdate.substring(4, 6) + "-"	 	// MM
				 + mdate.substring(6, 8) + " "	 	// dd
				 + mdate.substring(8, 10) + ":" 	// HH : 24시로 표기
				 + mdate.substring(10, 12) + ":00";	// mm:00
		
		Timestamp d = Timestamp.valueOf(s);
		
		return sdf.format(d);
	}
	
	public static String toDatesSimple(String mdate) {
		
		// 201810021607 --> 2018-10-02 16:07
		String s = mdate.substring(0, 4) + "-"	 	// yyyy 
				 + mdate.substring(4, 6) + "-"	 	// MM
				 + mdate.substring(6, 8) + " "	 	// dd
				 + mdate.substring(8, 10) + ":" 	// HH : 24시로 표기
				 + mdate.substring(10, 12) ;	//
		
		
		return s;
	}
	
	public static String getTime(String rdate) {
		String s = rdate.substring(8, 10) + "시 " 	
				 + rdate.substring(10, 12) + "분";
		return s;
	}
	
	public static String getTimeDot(String rdate) {
		String s = rdate.substring(8, 10) + "." 	
				 + rdate.substring(10, 12);
		return s;
	}

}
