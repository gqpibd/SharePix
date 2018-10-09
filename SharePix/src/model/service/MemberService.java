package model.service;

import dto.MemberBean;
import model.MemberManager;
import model.iMemberManager;

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
