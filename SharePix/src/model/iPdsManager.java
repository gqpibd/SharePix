package model;

import dto.PdsBean;

public interface iPdsManager {
	
	public PdsBean getPdsDetail(int seq);

	public PdsBean getSearchPds(String keyword);

	public boolean checkPdsLike(String id, int pdsSeq);

	public boolean chageLike(String id, int pdsSeq, boolean isLike);

	public int getLikeCount(int pdsSeq);

}
