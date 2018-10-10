<%@page import="model.MemberService"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>myPage.jsp</title>
</head>
<body>
<%
Object ologin = session.getAttribute("login");
MemberBean mem = null;

if(ologin == null){	
	%>	
	<script type="text/javascript">
	alert("로그인 해 주십시오.");
	location.href = "./index.jsp";
	</script>
	<%
	return;
}

mem = (MemberBean)ologin;
%>

<h2><%=mem.getName()%>의 myPage.jsp</h2>	<!-- 출력 확인 -->
프로필 사진<br>
<h2><%=mem.getName()%></h2>
총 이미지 갯수<br>
다운로드된 횟수<br>
좋아요 받은 수<br>
댓글 달린 수<br>
팔로워 수<br>
개인 소개?<br>

<form action="MemberController">
<input type="hidden" name="command" value="userUpdatePage">
<button type="submit">개인정보 수정</button>
</form>

</body>
</html>