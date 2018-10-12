package model;

import dto.MemberBean;

public interface iMemberManager {
	
	public MemberBean getUserInfo(String id);
	
	public MemberBean loginAf(String id, String pwd);
	
	public boolean updateUser(MemberBean dto);
	
	
}
