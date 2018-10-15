package model;

import java.util.List;

import dto.PagingBean;
import dto.PdsBean;

public interface iPdsManager {
	
	public PdsBean getPdsDetail(int seq);

	public PdsBean getSearchPds(String keyword);
	
	public boolean checkPdsLike(String id, int pdsSeq);

	public boolean chageLike(String id, int pdsSeq, boolean isLike);

	public int getLikeCount(int pdsSeq);
	
	public PdsBean getMyPdsAll(String id);
	
	public List<PdsBean> getMyPdsAllList(String id);
	
	public List<PdsBean> getSearchPdsNull();

	public List<PdsBean> getPdsPagingList(PagingBean paging, String keyword);
	
	public boolean writePds(PdsBean pds);
	
	public boolean delPDS(int seq);

	public boolean updatePDS(PdsBean pds);
}
