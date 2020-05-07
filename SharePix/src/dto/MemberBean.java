package dto;

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

public class MemberBean {
	
	private String id;
	private String name;
	private String password;
	private String email;
	private String phone;
	private int auth;
	
	public MemberBean() { }
	
	public MemberBean(String id, String name, String password, String email, String phone, int auth) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.auth = auth;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", name=" + name + ", password=" + password + ", email=" + email + ", phone="
				+ phone + ", auth=" + auth + "]";
	} 
	
}
