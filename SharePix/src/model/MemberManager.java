package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
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
	public MemberBean loginAf(String id, String pwd) {
		
		String sql  = " SELECT ID, PWD, NAME, EMAIL, PHONE, AUTH "
					+ " FROM MEMBER "
					+ " WHERE ID=? AND PWD=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberBean dto = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				int i = 1;
				dto = new MemberBean(  rs.getString(i++),		//id
									   rs.getString(i++),	//NAME
									   rs.getString(i++),	//PWD
									   rs.getString(i++),	//EMAIL
									   rs.getString(i++),	//PHONE
									   rs.getInt(i++));		//AUTH
				
				
				System.out.println("loginAf로부터 반환되는 dto = " + dto.toString());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt,conn, rs);
		}
		
		return dto;
	}

	@Override
	public boolean updateUser(MemberBean dto) {
		
		String sql  = " UPDATE MEMBER "
					+ " SET PWD=?, NAME=?, EMAIL=?, PHONE=? "
					+ " WHERE ID=? ";
		
		System.out.println("dto.toString() = " + dto.toString());
		int count = 0;
		
		Connection conn = null; 
		PreparedStatement psmt = null;
		
		try {
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
			DBClose.close( psmt, conn, null);
		}
		
		return count > 0 ? true : false;
	}
	
	
	
	
	
}
