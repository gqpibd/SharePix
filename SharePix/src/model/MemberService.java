package model;

import dto.MemberBean;

public class MemberService {

	private static MemberService custUserService = null;
	
	public iMemberManager manager;

	private MemberService() {
		manager = new MemberManager();
	}

	public static MemberService getInstance() {
		if (custUserService == null) {
			custUserService = new MemberService();
		}
		return custUserService;
	}
	
	////////////////////////////////////
	
	public MemberBean loginAf(String id, String pwd) {
		return manager.loginAf(id, pwd);
	}
	
	public boolean updateUser(MemberBean dto) {
		return manager.updateUser(dto);
	}
	
}
