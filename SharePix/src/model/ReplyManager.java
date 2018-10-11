package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.ReplyBean;

public class ReplyManager implements iReplyManager {
	
	@Override	
	public List<ReplyBean> getReplyList(int seq){
		String sql =  " SELECT * FROM PDSREPLY "
				+ " WHERE PDSSEQ = ? "
				+ " ORDER BY REREF ASC, RESEQ ASC "; 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReplyBean> replyList = new ArrayList<>(); // 검색 결과를 저장할 목록
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getReplyList Success");			
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getReplyList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getReplyList Success");
			
			while(rs.next()) {
				String content = "";
				if(rs.getInt("DEL")==1) { // 삭제된 글을 표시해줍니다
					content = "삭제된 글입니다";
				}else {
					content = rs.getString("content");
				}
				String wdate = rs.getString("WDATE");
				wdate = wdate.substring(0,wdate.lastIndexOf('.'));
				// pdsseq, reseq, id, content, reref, wdate, del
				ReplyBean bean = new ReplyBean(
											  rs.getInt("PDSSEQ"),
											  rs.getInt("RESEQ"),
											  rs.getString("ID"),
											  content,
											  rs.getInt("REREF"),
											  wdate,
											  rs.getInt("DEL")
											  );
				replyList.add(bean);
			}
			System.out.println("4/6 getReplyList Success");			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {		
			DBClose.close(psmt, conn, rs);
		}			  
		return replyList;
	}

	@Override
	public boolean addReply(String id, String content, int pdsSeq, int refSeq) {
		String sql = "";
			
		Connection conn = null;
		PreparedStatement psmt = null; 
		int count=0;

		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/6 addReply Success");
			
			// PDSSEQ, RESEQ, ID, CONTENT, REREF, WDATE, DEL
			if (refSeq > 0) { // 새 댓글일 때
				sql = " INSERT INTO PDSREPLY "
					+ " VALUES (?, PDSREPLY_RESEQ.NEXTVAL, ?, ?, ?, SYSDATE, 0) ";
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, pdsSeq);
				psmt.setString(2, id);
				psmt.setString(3, content);
				psmt.setInt(4, refSeq);
			}else { // 대댓일 때
				sql = " INSERT INTO PDSREPLY "
						+ " VALUES (?, PDSREPLY_RESEQ.NEXTVAL, ?, ?, PDSREPLY_RESEQ.CURRVAL, SYSDATE, 0) ";
					psmt = conn.prepareStatement(sql);
					psmt.setInt(1, pdsSeq);
					psmt.setString(2, id);
					psmt.setString(3, content);
			}
			
			System.out.println("2/6 addReply Success");

			count = psmt.executeUpdate();
			System.out.println("3/6 addReply Success");

			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}
}
