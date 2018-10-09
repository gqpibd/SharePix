package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// DB를 종료할 때 사용하는 static 메소드를 가진 클래스
// 클래스명을 보고 구분하기 위해 DBConnection과 별개로 만들어 줌.

public class DBClose {
	public static void close(Statement stmt, Connection conn, ResultSet rs) { // ResultSet : 데이터를 얻어올 때(select할 때) 사용하는 클래스
		try {
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
			if(rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
}
