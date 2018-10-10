package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.PdsBean;

public class PdsManager implements iPdsManager {
	
	public PdsManager() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws SQLException {
		String url = "jdbc:oracle:thin:@183.99.33.240:1521:xe";
		String user = "hr";
		String pass = "hr";

		Connection conn = DriverManager.getConnection(url, user, pass);

		return conn;
	}
	
	public void close(Connection conn, PreparedStatement psmt, ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			} else if (psmt != null) {
				psmt.close();
			} else if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public PdsBean getMyPageCount( String id ) {
		
		String sql  = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, "
					+ " READCOUNT, DOWNCOUNT, FSAVENAME LIKECOUNT, REPLYCOUNT "
					+ " FROM PDSALL "  
					+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PdsBean dto = null;
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			
			f(rs.next()) {
				int i = 1;
				dto = new PdsBean(rs.getInt(i++),		// seq
								  rs.getString(i++),	//	id
								  rs.getString(i++),	// CATEGORY
								  rs.getString(i++),	// tags
								  rs.getString(i++),	// uploaddate
								  rs.getString(i++),	// filename
								  rs.getInt(i++),		// readcount
								  rs.getInt(i++),		// downcount
								  likeCount, replyCount);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn, psmt, rs);
		}
		
		
		return dto;
	}

	
}
