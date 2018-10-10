<%@page import="controller.PdsController"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>main</title>
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

//System.out.println("mem.toString() = " + mem.toString()); // 잘 출력됨.
%>
<h2>main.jsp</h2>

<form action="PdsController" method="get">
   <input type="hidden" name="command" value="keyword">
   <input type="text" name="tags" > 
   <input type="submit" value="검색">
</form>

<form action="MemberController" method="get">
<input type="hidden" name="command" value="myPage">
<input type="submit" value="개인 페이지">
</form>

<a href="MemberController?command=logout">로그아웃</a><br>
<img src="<%=PdsController.PATH%>test.jpg" onclick="veiwDetail(this)" seq="1" width="200">
<script type="text/javascript">
	function veiwDetail(img) {
		var seq = $(img).attr("seq")
		console.log(seq);
		location.href="PdsController?command=detailview&seq=" + seq;
	}
</script>

</body>
</html>