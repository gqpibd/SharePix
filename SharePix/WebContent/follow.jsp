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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title></title>
</head>
<body>
<%for (int i = 0; i < sList.size(); i++) {
	FollowDto fDto = sList.get(i);
	MemberBean memDto = memService.getUserInfo(fDto.getFollowerId());
	//out.println("memDto : " + (i+1) + "번째 " + memDto.toString() + "<br><br>");
	%>
	<table border="1">
	<tr> 
		<td>
		<%-- <img src='images/profiles/<%=memDto.getId()%>.png' width='100px'
			class='profile re-img' align='middle'
			onerror="this.src='images/profiles/default.png'"> --%> 
		<span class="nickname"><%=memDto.getId()%></span>
		
		<p>
			<img src="images/profiles/<%=memDto.getId()%>.png" width="100"	class="profile img_clickable" align="middle"
				 onerror="this.src='images/profiles/default.png'"
				 onclick="location.href='userPage.jsp?id=<%= memDto.getId()%>'"> <!-- 작성자의 프로필 사진 -->
		</p>
		
		</td>
	</tr>
	</table>
	<%
}%>

</body>
</html>