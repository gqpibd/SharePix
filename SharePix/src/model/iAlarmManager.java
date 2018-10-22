package model;

import java.util.List;

import dto.AlarmBean;

public interface iAlarmManager {

	public List<AlarmBean> getAlarmList(String id);
	
	public boolean insertAlarm(AlarmBean bean);
	
	public boolean deleteAlarm(int seq);

}
