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
									  
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReplyBean> replyList = new ArrayList<>(); // 검색 결과를 저장할 목록
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getReplyList Success");
			// pdsseq, reseq, id, content, reref, wdate, del
			String totalSql = " SELECT COUNT(SEQ) "
							+ " FROM PDSREPLY "
							+ " WHERE PDSSEQ = ?";
			
			psmt = conn.prepareStatement(totalSql);
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();
			
			int totalCount=0;
			if(rs.next()) {
				totalCount = rs.getInt(1); // 검색된 글의 총 갯수
			}			
			System.out.println("총 댓글 수 :" + totalCount);
			
			psmt.close();
			rs.close();
			
			String sql =  " SELECT * FROM PDSREPLY "
						+ " WHERE PDSSEQ = ? "
						+ " ORDER BY REREF ASC, RESEQ ASC "; 
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsPagingList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsPagingList Success");
			
			while(rs.next()) {
				String content = "";
				if(rs.getInt("DEL")==1) { // 삭제된 글을 표시해줍니다
					content = "삭제된 글입니다";
				}else {
					content = rs.getString("content");
				}
				// pdsseq, reseq, id, content, reref, wdate, del
				ReplyBean bean = new ReplyBean(
											  rs.getInt("PDSSEQ"),
											  rs.getInt("RESEQ"),
											  rs.getString("ID"),
											  rs.getString("CONTENT"),
											  rs.getInt("REREF"),
											  rs.getString("WDATE"),
											  rs.getInt("DEL")
											  );
				replyList.add(bean);
			}
			System.out.println("4/6 getBbsPagingList Success");			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {		
			DBClose.close(psmt, conn, rs);
		}			  
		return null;
		}
}
