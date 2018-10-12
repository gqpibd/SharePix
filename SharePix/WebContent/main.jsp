<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main</title>
</head>
<body>
<h2>main.jsp</h2>

<form action="MemberController" method="get">
<input type="hidden" name="command" value="myPage">
<input type="submit" value="개인 페이지">
</form>

<a href="MemberController?command=logout">로그아웃</a>


</body>
</html>