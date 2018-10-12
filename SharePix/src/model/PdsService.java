package model;

import java.util.List;

import dto.PdsBean;

public class PdsService { // 싱글턴
	
	private static PdsService pdsService = null;
	
	public iPdsManager manager;

	private PdsService() { 
		manager = new PdsManager();
	}
	
	public static PdsService getInstance() {
		if (pdsService == null) {
			pdsService = new PdsService();
		}
		return pdsService;
	}
	
	//////////////////
	
	public PdsBean getMyPdsAll(String id) {
		return manager.getMyPdsAll(id);
	}
	
	public List<PdsBean> getMyPdsAllList(String id){
		return manager.getMyPdsAllList(id);
	}
}
