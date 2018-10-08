<%@page import="model.MemberService"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
//    	필요한 컬럼 : 이미지 총 수(list.size()), id로 join된 게시물
//		이미지에 필요한 컬럼 : 올린사람id, 좋아요, 다운카운트, 태그, 제목, 댓글테이블에 이어지는 FK, 해상도? 
//		개인정보 수정으로 이어지기
    %>
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
<h2><%=mem.getId()%>의 myPage.jsp</h2>	<!-- 출력 확인 -->
<form action="MemberController">
<input type="hidden" name="command" value="userUpdatePage">
<button type="submit">개인정보 수정</button>
</form>

</body>
</html>