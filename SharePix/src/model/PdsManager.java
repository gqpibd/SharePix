package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.PdsBean;

public class PdsManager implements iPdsManager {
	

	public PdsManager() {
		DBConnection.initConnection();
	}
	
	 @Override
	   public PdsBean getSearchPds(String keyword) {
	      String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
	            + " FROM PDSALL "
	            + " WHERE (CATEGORY LIKE ? OR TAGS LIKE ?) ";   

	      Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;

	      PdsBean pds = null; // 결과를 저장할 목록

	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/6 getPdsDetail Success");

	         psmt = conn.prepareStatement(sql);
	         psmt.setString(1, "%" + keyword +"%");
	         psmt.setString(2, "%" + keyword +"%");
	         System.out.println("2/6 getPdsDetail Success");

	         rs = psmt.executeQuery();
	         System.out.println("3/6 getPdsDetail Success");
	         
	         if (rs.next()) {
	            String regdate = rs.getString("UPLOADDATE");
	            regdate = regdate.substring(0, regdate.lastIndexOf('.'));
	            // SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
	            pds = new PdsBean(rs.getInt("SEQ"), 
	                          rs.getString("ID"), 
	                          rs.getString("CATEGORY"), 
	                          rs.getString("TAGS").substring(1).split("#"),
	                          regdate, 
	                          rs.getString("FILENAME"), 
	                          rs.getInt("READCOUNT"), 
	                          rs.getInt("DOWNCOUNT"), 
	                          rs.getInt("LIKECOUNT"),
	                          rs.getInt("REPLYCOUNT"),
	                          rs.getString("FSAVENAME")
	                          );
	         }
	         System.out.println("4/6 getPdsDetail Success");

	      } catch (SQLException e) {
	         e.printStackTrace();
	         System.out.println("getPdsDetail Fail");
	      } finally {
	         DBClose.close(psmt, conn, rs);
	      }
	      return pds;
	   }
	@Override
	public PdsBean getPdsDetail(int seq) {
		// SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT
		String sql = " SELECT SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT, FSAVENAME, LIKECOUNT, REPLYCOUNT "
				+ " FROM PDSALL " + " WHERE SEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		PdsBean pds = null; // 결과를 저장할 목록

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getPdsDetail Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getPdsDetail Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getPdsDetail Success");
			
			if (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));
				// SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
				pds = new PdsBean(rs.getInt("SEQ"), 
								  rs.getString("ID"), 
								  rs.getString("CATEGORY"), 
								  rs.getString("TAGS").substring(1).split("#"),
								  regdate, 
								  rs.getString("FILENAME"), 
								  rs.getInt("READCOUNT"), 
								  rs.getInt("DOWNCOUNT"), 
								  rs.getInt("LIKECOUNT"),
								  rs.getInt("REPLYCOUNT"),
								  rs.getString("FSAVENAME")
								  );
			}
			System.out.println("4/6 getPdsDetail Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getPdsDetail Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return pds;
	}
	
	

}
