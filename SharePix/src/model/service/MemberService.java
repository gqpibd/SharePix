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
	
	public boolean getEmail(String email) {
		return manager.getEmail(email);
	}
	
	public boolean getId(String id) {
		return manager.getId(id);
	}
	
	public MemberBean getEmail(MemberBean dto){
		return manager.getEmail(dto);
	}
	
	public MemberBean getPwd(MemberBean dto){
		return manager.getPwd(dto);
	}
	
	public MemberBean getIdpwd(MemberBean dto){
		return manager.getIdpwd(dto);
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
	
	public boolean addMember(MemberBean dto){
		return manager.addMember(dto);
	}
	
	public MemberBean login(MemberBean dto){
		return manager.login(dto);
	}
	
	public List<FollowDto> getMyfollowingList(String myId){
		return manager.getMyfollowingList(myId);
	}
	
}
