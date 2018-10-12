package model;

import java.util.List;

import dto.PdsBean;

public interface iPdsManager {
	
	public PdsBean getMyPdsAll(String id);
	
	public List<PdsBean> getMyPdsAllList(String id);
}
