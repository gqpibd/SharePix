<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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

/////////////////////////



%>
<h2>userUpdateAf.jsp</h2>
<script type="text/javascript">
alert("수정되었습니다.");
location.href = "userUpdatePage.jsp";
</script>
</body>
</html>