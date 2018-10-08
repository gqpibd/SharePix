package model;

import dto.MemberBean;

public class MemberService {

	private static MemberService custUserService = null;
	
	public iMemberManager dao;

	private MemberService() {
		dao = new MemberManager();
	}

	public static MemberService getInstance() {
		if (custUserService == null) {
			custUserService = new MemberService();
		}
		return custUserService;
	}
	
	////////////////////////////////////
	
	public MemberBean loginAf(String id, String pwd) {
		return dao.loginAf(id, pwd);
	}
	
}
