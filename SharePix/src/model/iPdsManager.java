package model;

import dto.PdsBean;

public interface iPdsManager {
	
	public PdsBean getPdsDetail(int seq);

	public PdsBean getSearchPds(String keyword);

}
