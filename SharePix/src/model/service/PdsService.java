package model.service;

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
}
