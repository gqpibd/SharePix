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
				+ " FROM PDSALL " + " WHERE (CATEGORY LIKE ? OR TAGS LIKE ?) ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		PdsBean pds = null; // 결과를 저장할 목록

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getPdsDetail Success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, "%" + keyword + "%");
			psmt.setString(2, "%" + keyword + "%");
			System.out.println("2/6 getPdsDetail Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getPdsDetail Success");

			if (rs.next()) {
				String regdate = rs.getString("UPLOADDATE");
				regdate = regdate.substring(0, regdate.lastIndexOf('.'));
				// SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE
				pds = new PdsBean(rs.getInt("SEQ"), rs.getString("ID"), rs.getString("CATEGORY"),
						rs.getString("TAGS").substring(1).split("#"), regdate, rs.getString("FILENAME"),
						rs.getInt("READCOUNT"), rs.getInt("DOWNCOUNT"), rs.getInt("LIKECOUNT"), rs.getInt("REPLYCOUNT"),
						rs.getString("FSAVENAME"));
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
		// SEQ, ID, CATEGORY, TAGS, UPLOADDATE, FILENAME, READCOUNT, DOWNCOUNT,
		// FSAVENAME, LIKECOUNT, REPLYCOUNT
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
				pds = new PdsBean(rs.getInt("SEQ"), rs.getString("ID"), rs.getString("CATEGORY"),
						rs.getString("TAGS").substring(1).split("#"), regdate, rs.getString("FILENAME"),
						rs.getInt("READCOUNT"), rs.getInt("DOWNCOUNT"), rs.getInt("LIKECOUNT"), rs.getInt("REPLYCOUNT"),
						rs.getString("FSAVENAME"));
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
	public boolean checkPdsLike(String id, int pdsSeq) {
		String sql = " SELECT * " + " FROM PDSLIKE " + " WHERE PDSSEQ = ? AND ID = ?";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 checkPdsLike Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsSeq);
			psmt.setString(2, id);
			System.out.println("2/6 checkPdsLike Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 checkPdsLike Success");

			if (rs.next()) {
				System.out.println("있음");
				return true;
			}
			System.out.println("없음");
			System.out.println("4/6 checkPdsLike Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("checkPdsLike Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return false;
	}

	@Override
	public boolean chageLike(String id, int pdsSeq, boolean isLike) {
		String sql = "";
		if (isLike) { // 좋아요를 누르면 row 추가
			sql = " INSERT INTO PDSLIKE " + " VALUES (?, ?) ";
		} else {
			sql = " DELETE FROM PDSLIKE " + " WHERE PDSSEQ = ? AND ID = ? ";
		}

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 chageLike Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsSeq);
			psmt.setString(2, id);
			System.out.println("2/6 chageLike Success");

			count = psmt.executeUpdate();
			System.out.println("3/6 chageLike Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("chageLike Fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}

	@Override
	public int getLikeCount(int pdsSeq) {
		String sql = " SELECT count(*) " + " FROM PDSLIKE " + " WHERE PDSSEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getLikeCount Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsSeq);
			System.out.println("2/6 getLikeCount Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getLikeCount Success");

			if (rs.next()) {
				count = rs.getInt(1);
			}
			System.out.println("4/6 getLikeCount Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getLikeCount Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return count;

	}

	@Override
	public boolean increaseDowncount(int pdsSeq) {
		String sql = " UPDATE PICPDS " 
				   + " SET DOWNCOUNT = DOWNCOUNT+1 " 
				   + " WHERE SEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 increaseDowncount Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsSeq);
			System.out.println("2/6 increaseDowncount Success");

			count = psmt.executeUpdate();
			System.out.println("3/6 increaseDowncount Success");

		} catch (SQLException e) {
			System.out.println("increaseDowncount Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}

}
