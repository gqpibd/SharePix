package model.service;

import java.util.List;

import dto.PdsBean;
import model.PdsManager;
import model.iPdsManager;

public class PdsService {
	private static PdsService pdsService = new PdsService();
	private iPdsManager pDao;

	private PdsService() {
		pDao = new PdsManager();
	}

	public static PdsService getInstance() {
		return pdsService;
	}

	public PdsBean getPdsDetail(int seq) {
		return pDao.getPdsDetail(seq);		
	}

	public PdsBean getSearchPds(String keyword) {
		return pDao.getSearchPds(keyword);
	}

	public boolean checkPdsLike(String id, int pdsSeq) {
		return pDao.checkPdsLike(id,pdsSeq);
	}
	
	public void chageLike(String id, int pdsSeq, boolean isLike) {
		pDao.chageLike(id,pdsSeq,isLike);
	}
	
	public int getLikeCount(int pdsSeq) {
		return pDao.getLikeCount(pdsSeq);
	}
	public PdsBean getMyPdsAll(String id) {
		return pDao.getMyPdsAll(id);
	}
	
	public List<PdsBean> getMyPdsAllList(String id){
		return pDao.getMyPdsAllList(id);
	}
	
	public boolean writePds(PdsBean pds) {
		return false;
	}
	
	public PdsBean delPDS(int seq) {
		return pDao.getPdsDetail(seq);
	}
	
	public PdsBean updatePDS(int seq, String category, String tags) {
		return pDao.getPdsDetail(seq);
	}

	public boolean updatePDS(PdsBean dto) {
		return pDao.updatePDS(dto);
	}
}
