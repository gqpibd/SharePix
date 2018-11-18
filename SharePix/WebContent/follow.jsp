<%@page import="dto.MemberBean"%>
<%@page import="model.service.PdsService"%>
<%@page import="dto.FollowDto"%>
<%@page import="java.util.List"%>
<%@page import="model.service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberService memService = MemberService.getInstance();
PdsService pdsService = PdsService.getInstance();

String followeeId = request.getParameter("followeeId");
List<FollowDto> sList = memService.getMySubscribeList(followeeId); // 나를 구독하는 사람들 리스트 받기
%>

<%if(sList.size()!=0){%>
	<table style="margin: 20px;margin-right: 20px;margin-left:20px">
	<col width="300px"><col width="300px"><col width="300px">
<tr style="height: 250px">
<%for (int i = 0; i < sList.size(); i++) {
	FollowDto fDto = sList.get(i);
	MemberBean memDto = memService.getUserInfo(fDto.getFollowerId());
	%>
		<td align="center" class="profiles_td">
			<img src="images/profiles/<%=memDto.getId()%>.png" title="<%=memDto.getName()%>님" width="100"	class="profile img_clickable" align="middle"
				 onerror="this.src='images/profiles/default.png'" style="cursor:pointer"
				 onclick="location.href='MemberController?command=userPage&id=<%=memDto.getId()%>'"> <!-- 작성자의 프로필 사진 -->
			 <br><br><p><%=memDto.getName()%>님</p><br>
		</td>
	<%if(i%3==2){%>
	</tr><tr style="height: 250px">
	<%}
}%>
</tr>
	</table>
<%}else{%>
	<div align="center" class="noNews">
	<br>
	<p>와! 여긴 쌀 한 톨도 없네요!</p>
	<p>새로운 친구를 사귀어봐요!</p>
	</div>
<%}%>