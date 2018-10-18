package model.service;

import java.util.ArrayList;
import java.util.List;

import dto.PagingBean;
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

	public List<PdsBean> getSearchPds(String keyword) {
		return pDao.getSearchPds(keyword);
	}

	public boolean checkPdsLike(String id, int pdsSeq) {
		return pDao.checkPdsLike(id,pdsSeq);
	}
	
	public boolean changeLike(String id, int pdsSeq) {
		return pDao.changeLike(id,pdsSeq);
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
	
	public List<PdsBean> getPdsPagingList(PagingBean paging, String keyword){
		
		return pDao.getPdsPagingList(paging, keyword);
	}

	public List<PdsBean> relatedList(String category, int seq) {
		List<PdsBean> list = pDao.relatedList(category,seq); // 일단 관련있는 목록을 다 가져오자
		
		int size = 8; // 그 중 최대 6개만 골라낼거야
		if(list.size() < size) {
			size = list.size();
		}
		System.out.println(size);
		boolean temp[] = new boolean[size+1];
		List<PdsBean> selectedList = new ArrayList<PdsBean>();
		int count =0 ;
		while(true) {
			int num = (int)(Math.random()*size);
			if(temp[num]==false) {
				selectedList.add(list.get(num));
				temp[num] = true;
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
	
	public boolean delPDS(int seq) {
		return pDao.delPDS(seq);

	}
	
	public PdsBean updatePDS(int seq, String category, String tags) {
		return pDao.getPdsDetail(seq);
	}


	public boolean updatePDS(PdsBean pds) {
		return pDao.updatePDS(pds);
	}

	
	public List<PdsBean> getMyLikeList(String id){
		return pDao.getMyLikeList(id);
	}

	public boolean increaseReadcount(int seq) {
		return pDao.increaseReadcount(seq);
		
	}
} 
