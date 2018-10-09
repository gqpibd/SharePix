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
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
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
				dto = new MemberBean(rs.getString(i++),
									   rs.getString(i++),
									   rs.getString(i++),
									   rs.getString(i++),
									   rs.getString(i++),
									   rs.getInt(i++));
				
				System.out.println("dto = " + dto.toString());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt,conn, rs);
		}
		
		return dto;
	}
	
	
	
}
