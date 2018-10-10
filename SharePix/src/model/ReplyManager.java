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
									  
		/*Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReplyBean> replyList = new ArrayList<>(); // 검색 결과를 저장할 목록
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsPagingList Success");
			
			String totalSql = " SELECT COUNT(SEQ) "
					+ " FROM BBS "
					+ " WHERE " + option + " LIKE '" + sWord + "' ";
			
			psmt = conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount=0;
			rs.next();
			totalCount = rs.getInt(1); // 검색된 글의 총 갯수
			paging.setTotalCount(totalCount);
			paging = PagingUtil.setPagingInfo(paging);
			System.out.println("총 글 수 :" + totalCount);
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
							+ " (SELECT * FROM "
											+ "(SELECT * FROM BBS"
											+ " WHERE " + option + " LIKE '" + sWord +"' "
											+ " ORDER BY REF ASC, STEP DESC) " // 우선 최신 글을 뒤로 보내고
							+ "  WHERE ROWNUM <= " + paging.getStartNum() + " ORDER BY REF DESC, STEP ASC) " // 시작 번호부터
					   + " WHERE ROWNUM <=" + paging.getCountPerpage(); // 페이지당 글 개수만큼 가져옴
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsPagingList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsPagingList Success");
			
			while(rs.next()) {
				String title = "";
				if(rs.getInt("DEL")==1) { // 삭제된 글을 표시해줍니다
					title = "삭제된 글입니다";
				}else {
					title = rs.getString("title");
				}
				
				BbsDto dto = new BbsDto(rs.getInt(1), 
										rs.getString(2),
										rs.getInt(3), 
										rs.getInt(4), 
										rs.getInt(5), 
										title, 
										rs.getString(7), 
										rs.getString(8),
										rs.getInt(9), 
										rs.getInt(10),
										rs.getInt(11));
				bbslist.add(dto);
			}
			System.out.println("4/6 getBbsPagingList Success");			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {		
			DBClose.close(psmt, conn, rs);
		}			  
			return bbslist;*/
		return null;
		}
}
