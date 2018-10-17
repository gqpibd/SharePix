package dto;

import java.io.Serializable;

public class FollowDto implements Serializable{

	private static final long serialVersionUID = -1898647744407218143L;

	private String followerId;
	private String followeeId;

	public FollowDto() { }

	public FollowDto(String followerId, String followeeId) {
		super();
		this.followerId = followerId;
		this.followeeId = followeeId;
	}

	public String getFollowerId() {
		return followerId;
	}

	public void setFollowerId(String followerId) {
		this.followerId = followerId;
	}

	public String getFolloweeId() {
		return followeeId;
	}
	
	public void setFolloweeId(String followeeId) {
		this.followeeId = followeeId;
	}

	@Override
	public String toString() {
		return "FollowDto [followerId=" + followerId + ", followeeId=" + followeeId + "]";
	}
	
	
}
