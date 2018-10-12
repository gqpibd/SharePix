package model;

import dto.MemberBean;

public class MemberService {

	private static MemberService memberService = null;
	
	public iMemberManager manager;

	private MemberService() {
		manager = new MemberManager();
	}

	public static MemberService getInstance() {
		if (memberService == null) {
			memberService = new MemberService();
		}
		return memberService;
	}
	
	////////////////////////////////////
	
	public MemberBean loginAf(String id, String pwd) {
		return manager.loginAf(id, pwd);
	}
	
	public boolean updateUser(MemberBean dto) {
		return manager.updateUser(dto);
	}
	
	public MemberBean getUserInfo(String id) {
		return manager.getUserInfo(id);
	}
	
}
