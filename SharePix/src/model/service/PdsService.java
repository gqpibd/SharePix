package model.service;

import java.util.ArrayList;
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
	
	public boolean increaseDowncount(int pdsSeq) {
		return pDao.increaseDowncount(pdsSeq);		
	}

	public List<PdsBean> myLikePdsList(String id) {
		return pDao.myLikePdsList(id);
	}
	
	public List<PdsBean> getSearchPdsNull(){
		return pDao.getSearchPdsNull();
	}

	public List<PdsBean> relatedList(String category, int seq) {
		List<PdsBean> list = pDao.relatedList(category); // 일단 관련있는 목록을 다 가져오자
		
		int size = 6; // 그 중 최대 6개만 골라낼거야
		if(list.size() < size) {
			size = list.size();
		}
		System.out.println(size);
		boolean temp[] = new boolean[size];
		List<PdsBean> selectedList = new ArrayList<PdsBean>();
		int count =0 ;
		while(true) {
			int num = (int)(Math.random()*size);
			if(temp[num]==false) {
				if(list.get(num).getSeq() != seq) { // 지금 보고 있는 사진은 빼야됨
					selectedList.add(list.get(num));
					temp[num] = true;
				}
				count++;
			}
			if(count == size) {
				break;
			}			
		}	
		return selectedList;
	}
	
	public PdsBean getMyPdsAll(String id) {
		return pDao.getMyPdsAll(id);
	}
	
	public List<PdsBean> getMyPdsAllList(String id){
		return pDao.getMyPdsAllList(id);
	}
	
	public boolean writePds(PdsBean pds) {
		return pDao.writePds(pds);
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
	
	public List<PdsBean> getMyLikeList(String id){
		return pDao.getMyLikeList(id);
	}
}
