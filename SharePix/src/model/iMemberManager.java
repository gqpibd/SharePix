package model;

import java.util.List;

import dto.FollowDto;
import dto.MemberBean;


public interface iMemberManager {
	
	public boolean addMember(MemberBean dto);
	
	public MemberBean login(MemberBean dto);
	
	public MemberBean getUserInfo(String id);
	
	public MemberBean loginAf(String id, String pwd);
	
	public boolean updateUser(MemberBean dto);

	public boolean getId(String id);
	
	public List<FollowDto> getMyFollowerList(String myId);	//	나를 팔로우 하는 사람들의 리스트
	
	public List<FollowDto> getMySubscribeList(String myId);
	
	public boolean checkMemFollow(String followerId, String followeeId);
	
	public boolean changeFollow(String followerId, String followeeId, boolean isFollow);

	public MemberBean getEmail(MemberBean dto);
	
	public MemberBean getPwd(MemberBean dto);
	
	public MemberBean getIdpwd(MemberBean dto);
	
}
