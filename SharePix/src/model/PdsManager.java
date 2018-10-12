package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	public PdsBean getMyPdsAll( String id ) {
		
		String sql  = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, "
					+ " READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
					+ " FROM PDSALL "  
					+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PdsBean dto = null;
		
		try {
			conn = getConnection();
			System.out.println("1/6 getMyPdsAll success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			System.out.println("2/6 getMyPdsAll success");
			
			if(rs.next()) {
				
				String[] tag = rs.getString(4).substring(1).split("#");
				
				dto = new PdsBean(rs.getInt(1),          	// seq
								  rs.getString(2),        //	id
								  rs.getString(3),    	// CATEGORY
								  tag,        
								  rs.getString(5),  	// uploaddate
								  
								  rs.getString(6),    // filename     
								  rs.getInt(7),   	        // readcount    
								  rs.getInt(8),   	        // downcount    
								  rs.getString(9),	        // fileSaveName 
								  rs.getInt(10),    	        	// likeCount
								  rs.getInt(11));

				System.out.println("getMyPdsAll 로부터 나오는 dto " + dto.toString());
			}
			System.out.println("3/6 getMyPdsAll success");
			
		} catch (SQLException e) {
			System.out.println("getMyPdsAll fail");
			e.printStackTrace();
		} finally {
			close(conn, psmt, rs);
		}
		
		return dto;
	}

	@Override
	public List<PdsBean> getMyPdsAllList(String id) {// 아이디에 해당하는 것들 list로 뽑아오기
		
		List<PdsBean> list = new ArrayList<>();
		
		String sql  = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, "
					+ " READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
					+ " FROM PDSALL "  
					+ " WHERE ID=? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PdsBean dto = null;
		
		try {
			conn = getConnection();
			System.out.println("1/6 getMyPdsAllList success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			System.out.println("2/6 getMyPdsAllList success");
			
			while(rs.next()) {
				
				String[] tag = rs.getString(4).substring(1).split("#");
				
				dto = new PdsBean(rs.getInt(1),          	// seq
								  rs.getString(2),        //	id
								  rs.getString(3),    	// CATEGORY
								  tag,        
								  rs.getString(5),  	// uploaddate
								  
								  rs.getString(6),    // filename     
								  rs.getInt(7),   	        // readcount    
								  rs.getInt(8),   	        // downcount    
								  rs.getString(9),	        // fileSaveName 
								  rs.getInt(10),    	        	// likeCount
								  rs.getInt(11));
				list.add(dto);
				
			}
			
			System.out.println("3/6 getMyPdsAllList success");
			
		} catch (SQLException e) {
			System.out.println("getMyPdsAllList fail");
			e.printStackTrace();
		} finally {
			close(conn, psmt, rs);
		}
		
		return list;
	}
	
	

	
}
