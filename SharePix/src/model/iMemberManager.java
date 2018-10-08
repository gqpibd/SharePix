package model;

import dto.MemberBean;

public interface iMemberManager {
	public MemberBean loginAf(String id, String pwd);
}
