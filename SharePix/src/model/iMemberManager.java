package model;

import dto.MemberBean;

public interface iMemberManager {
	
	public boolean addMember(MemberBean dto);
	
	public MemberBean login(MemberBean dto);
	
	public MemberBean getUserInfo(String id);
	
	public MemberBean loginAf(String id, String pwd);
	
	public boolean updateUser(MemberBean dto);

	public boolean getId(String id);
}
