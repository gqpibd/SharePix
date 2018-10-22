package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.AlarmBean;

public class AlarmManager implements iAlarmManager {
	
	public AlarmManager() {
		DBConnection.initConnection();
	}
	
	@Override
	public List<AlarmBean> getAlarmList(String id) {	// 내가 좋아요한 리스트
		String sql  = " SELECT SEQ, TOID, FROMID, ATYPE, PDSSEQ, ADATE, CONTENT " 
					+ " FROM ALARM " 
					+ " WHERE TOID = ?"
					+ " ORDER BY ADATE DESC "; 
      
		List<AlarmBean> list = new ArrayList<>();
      
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
      
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getAlarmList Success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);

			rs = psmt.executeQuery();
			System.out.println("2/6 getAlarmList Success");

			while (rs.next()) {
				// TOID, FROMID, TYPE, PDSSEQ, ADATE
				String adate = rs.getString("ADATE");
				adate=adate.substring(0,adate.lastIndexOf(':'));
				AlarmBean bean = new AlarmBean(rs.getInt("SEQ"), 
											   rs.getString("TOID"), 
											   rs.getString("FROMID"),
											   rs.getInt("ATYPE"), 
											   rs.getInt("PDSSEQ"), 
											   adate, 
											   rs.getString("CONTENT"));
				list.add(bean);
			}
			System.out.println("3/6 getMyLikeList Success");
		} catch (SQLException e) {
			System.out.println("getAlarmList Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}    
		return list;
   }

	@Override
	public boolean insertAlarm(AlarmBean bean) {		
		String sql = " INSERT INTO ALARM "
				+ " (SEQ, TOID, FROMID, ATYPE, PDSSEQ, ADATE, CONTENT) "
				+ " VALUES((SELECT NVL(MAX(SEQ),0)+1 FROM ALARM), ?, ?, ?, ?, SYSDATE, ?) ";
		int count = 0;

		Connection conn = null;
		PreparedStatement psmt = null;
		
	    try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertAlarm Success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 insertAlarm Success");
			
			psmt.setString(1, bean.getToId());
			psmt.setString(2, bean.getFromId());
			psmt.setInt(3, bean.getType());
			psmt.setInt(4, bean.getPdsSeq());
			psmt.setString(5, bean.getContent());
			
			count = psmt.executeUpdate();
			System.out.println("3/6 insertAlarm Success");
	    	
		} catch (Exception e) {
			System.out.println("insertAlarm Fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}	
		return count>0?true:false;
	}

	@Override
	public boolean deleteAlarm(int seq) {
		String sql = "DELETE FROM ALARM " 
				  + " WHERE SEQ = ? ";
		int count = 0;

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deleteAlarm Success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 deleteAlarm Success");

			psmt.setInt(1, seq);

			count = psmt.executeUpdate();
			System.out.println("3/6 deleteAlarm Success");

		} catch (Exception e) {
			System.out.println("deleteAlarm Fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}
}
