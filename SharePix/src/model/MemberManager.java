package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.FollowDto;
import dto.MemberBean;

public class MemberManager implements iMemberManager {

	public MemberManager() {
		DBConnection.initConnection();
	}
	
	/////////////////////////////////////////////////////
	
	//DROP TABLE MEMBER
	//CASCADE CONSTRAINTS;
	//
	//CREATE TABLE MEMBER(
	//   ID VARCHAR2(50) PRIMARY KEY,
	//   PWD VARCHAR2(50) NOT NULL,
	//   NAME VARCHAR2(50) NOT NULL,
	//   EMAIL VARCHAR2(50) UNIQUE,
	//   PHONE VARCHAR2(50) UNIQUE,
	//   AUTH NUMBER(1) NOT NULL
	//);
	
	/////////////////////////////////////////////////////
	
	@Override
	public MemberBean getUserInfo(String id) {
		
		String sql  = " SELECT ID, NAME, PWD, EMAIL, PHONE, AUTH "
					+ " FROM MEMBER "
					+ " WHERE ID = ? "; 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberBean dto = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getIdInfo success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			System.out.println("2/6 getIdInfo success");
			if (rs.next()) {
				dto = new MemberBean(	rs.getString("ID"),
										rs.getString("NAME"),
										rs.getString("PWD"),
										rs.getString("EMAIL"),
										rs.getString("PHONE"),
										rs.getInt("AUTH"));
			}
			System.out.println("3/6 getIdInfo success");
			
		} catch (SQLException e) {
			System.out.println("getIdInfo fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	@Override
	public MemberBean loginAf(String id, String pwd) {
		
		String sql  = " SELECT ID, NAME, PWD, EMAIL, PHONE, AUTH "
					+ " FROM MEMBER "
					+ " WHERE ID=? AND PWD=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberBean dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 loginAf success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 loginAf success");
			
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			
			rs = psmt.executeQuery();
			System.out.println("3/6 loginAf success");
			
			if(rs.next()) {
				int i = 1;
				dto = new MemberBean(  rs.getString(i++),		//id
									   rs.getString(i++),	//NAME
									   rs.getString(i++),	//PWD
									   rs.getString(i++),	//EMAIL
									   rs.getString(i++),	//PHONE
									   rs.getInt(i++));		//AUTH
			}
			System.out.println("4/6 loginAf success");
			
		} catch (Exception e) {
			System.out.println("loginAf Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}

	@Override
	public boolean updateUser(MemberBean dto) {
		
		String sql  = " UPDATE MEMBER "
					+ " SET PWD=?, NAME=?, EMAIL=?, PHONE=? "
					+ " WHERE ID=? ";
		
		System.out.println("(in updateUser) dto.toString() = " + dto.toString());
		int count = 0;
		
		Connection conn = null; 
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateUser success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 updateUser success");
			psmt.setString(1, dto.getPassword());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getEmail());
			psmt.setString(4, dto.getPhone());
			psmt.setString(5, dto.getId());
			
			System.out.println("3/6 updateUser success");
			count = psmt.executeUpdate();
			System.out.println("4/6 updateUser success");
		} catch (SQLException e) {
			System.out.println("updateUser Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count > 0 ? true : false;
	}

	@Override
	public List<FollowDto> getMyFollowerList(String myId) {	// 나를 구독한 사람들 구하기
		
		List<FollowDto> list = new ArrayList<>();
		
		String sql = " SELECT FOLLOWERID, FOLLOWEEID "
			       + " FROM FOLLOW "
			       + " WHERE FOLLOWEEID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, myId);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				FollowDto dto = new FollowDto(rs.getString(1), rs.getString(2));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}

	@Override
	public List<FollowDto> getMySubscribeList(String myId) {	//	내가 구독한 사람들 구하기
		List<FollowDto> list = new ArrayList<>();
		
		String sql = " SELECT FOLLOWERID, FOLLOWEEID "
			       + " FROM FOLLOW "
			       + " WHERE FOLLOWERID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, myId);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				FollowDto dto = new FollowDto(rs.getString(1), rs.getString(2));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}
	
	@Override
	public boolean checkMemFollow(String followerId, String followeeId) {
		String sql = " SELECT * "
				   + " FROM FOLLOW " 
				   + " WHERE FOLLOWERID = ? AND FOLLOWEEID = ?";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;


		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 checkMemFollow Success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, followerId);
			psmt.setString(2, followeeId);
			System.out.println("2/6 checkMemFollow Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 checkMemFollow Success");

			if (rs.next()) {
				System.out.println("팔로우 했음");
				return true;
			}
			System.out.println("팔로우 안 했음");
			System.out.println("4/6 checkMemFollow Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("checkMemFollow Fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return false;
	}
	
	@Override
	public boolean changeFollow(String followerId, String followeeId, boolean isFollow) {
		String sql = "";
		if (isFollow) { // 구독을 누르면 row 추가
			sql = " INSERT INTO FOLLOW " + " VALUES (?, ?) ";
		} else {
			sql = " DELETE FROM FOLLOW " + " WHERE FOLLOWERID = ? AND FOLLOWEEID = ? ";
		}

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 changeFollow Success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, followerId);
			psmt.setString(2, followeeId);
			System.out.println("2/6 changeFollow Success");

			count = psmt.executeUpdate();
			System.out.println("3/6 changeFollow Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("changeFollow Fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0 ? true : false;
	}
	
}
