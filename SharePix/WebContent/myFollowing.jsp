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

String pageId = request.getParameter("pageId");
List<FollowDto> myFList = memService.getMyfollowingList(pageId); // 내가 구독하는 사람들 리스트 받기
%>

<%if(myFList.size()!=0){%>
<div align="center">
<table style="margin: 20px;margin-right: 20px;margin-left:20px">
<col width="300px"><col width="300px"><col width="300px">
<tr style="height: 250px">
<%for (int i = 0; i < myFList.size(); i++) {
	FollowDto fDto = myFList.get(i);
	MemberBean memDto = memService.getUserInfo(fDto.getFolloweeId());
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
	<p>와! 여긴 사람 한명 없네요!</p>
	<p>새 친구를 팔로우 해봐요!</p>
	</div>
<%}%>
</div>