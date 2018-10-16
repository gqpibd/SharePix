package model.service;

import java.util.List;

import dto.FollowDto;
import dto.MemberBean;
import model.MemberManager;
import model.iMemberManager;

public class MemberService {

	private static MemberService mService = null;
	
	private iMemberManager manager;

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
	
	public MemberBean getUserInfo(String id) {
		return manager.getUserInfo(id);
	}	
	public boolean getId(String id) {
		return manager.getId(id);
	}
	public boolean updateUser(MemberBean dto) {
		return manager.updateUser(dto);
	}
	
	public List<FollowDto> getMyFollowerList(String myId){
		return manager.getMyFollowerList(myId);
	}
	
	public List<FollowDto> getMySubscribeList(String myId) {
		return manager.getMyFollowerList(myId);
	}
	
	public boolean checkMemFollow(String followerId, String followeeId) {
		return manager.checkMemFollow(followerId, followeeId);
	}
	
	public boolean changeFollow(String followerId, String followeeId, boolean isFollow) {
		return manager.changeFollow(followerId, followeeId, isFollow);
	}
	
}
