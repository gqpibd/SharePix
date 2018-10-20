package model.service;

import java.util.List;

import dto.AlarmBean;
import dto.FollowDto;
import dto.MemberBean;
import dto.PdsBean;
import dto.ReplyBean;
import model.AlarmManager;
import model.iAlarmManager;

public class AlarmService {
	private static AlarmService aService = null;
	
	private iAlarmManager manager;

	private AlarmService() {
		manager = new AlarmManager();
	}

	public static AlarmService getInstance() {
		if (aService == null) {
			aService = new AlarmService();
		}
		return aService;
	}

	public void insertAlarm(PdsBean pds) {
		List<FollowDto> followerList = MemberService.getInstance().getMyFollowerList(pds.getId());
		String fromId = pds.getId();
		int pdsSeq = pds.getSeq();
		for (int i = 0; i < followerList.size(); i++) {
			manager.insertAlarm(new AlarmBean(followerList.get(i).getFollowerId(),fromId,AlarmBean.NEWPOST,pdsSeq));
		}
	}
	
	public void insertAlarm(String fromId, String toId, int pdsSeq) {				
		String pdsWriter = PdsService.getInstance().getPdsDetail(pdsSeq).getId();
		if(toId!=null && !fromId.equals(toId)) { // toWhom이 있는 경우 && toWhom이 내가 아닌 경우
			manager.insertAlarm(new AlarmBean(toId,fromId,AlarmBean.NEWREPLY,pdsSeq));
		}
		if(!fromId.equals(pdsWriter) && !toId.equals(pdsWriter)) { // 게시글 작성자와 댓글작성자 댓글 받는사람이 모두 다른 경우 게시글 작성자에게 따로 알람 추가해줌
			manager.insertAlarm(new AlarmBean(pdsWriter,fromId,AlarmBean.NEWREPLY,pdsSeq));
		}
	}
	
	public List<AlarmBean> getAlarmList(String id){
		return manager.getAlarmList(id);
	}

	public void deleteAlarm(int alarmSeq) {
		manager.deleteAlarm(alarmSeq);
	}
}
