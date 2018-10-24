package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// connection을 만들 때 사용하는 static class

public class DBConnection {
	public static void initConnection() {
		try {
			// 오라클 들어가기 전에 항상 확인해 줘야함
			Class.forName("oracle.jdbc.driver.OracleDriver"); // Class.forName(클래스이름) : 클래스 찾는 것
			System.out.println("Driver Loading Success!!");
		} catch (ClassNotFoundException e) { // Class.forName()가 클래스를 못 찾는 경우
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException { // 183.99.33.240 // 127.0.0.1 (혼자 쓸 때)
		Connection conn = null;
		//conn = DriverManager.getConnection("jdbc:oracle:thin:@183.99.33.240:1521:xe", "hr", "hr");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@myinstance.cvunqfkcxy2b.ap-northeast-2.rds.amazonaws.com:1521:ORCL", "jw", "jw910415");
		System.out.println("DB Connection Success!!");

		return conn;
	}
}
