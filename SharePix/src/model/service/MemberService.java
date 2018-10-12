package model.service;

import dto.MemberBean;
import model.MemberManager;
import model.iMemberManager;

public class MemberService {

	private static MemberService mService = null;
	
	public iMemberManager manager;

	private MemberService() {
		manager = new MemberManager();
	}

	public static MemberService getInstance() {
		if (mService == null) {
			mService = new MemberService();
		}
		return mService;
	}
	
	////////////////////////////////////
	
	public MemberBean loginAf(String id, String pwd) {
		return manager.loginAf(id, pwd);
	}
	
}
