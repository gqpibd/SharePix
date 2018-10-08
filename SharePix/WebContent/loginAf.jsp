<%@page import="dto.MemberBean"%>
<%@page import="model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberService service = MemberService.getInstance();
MemberBean mem = service.loginAf(id, pwd);

if(mem != null && !mem.getId().equals("")){
	session.setAttribute("login", mem);
	session.setMaxInactiveInterval(30*60);
%>
	<script type="text/javascript">
	alert("안녕하세요 <%=mem.getId() %> 님");
	location.href = "main.jsp";
	</script>	
<%
}
%> 

</body>
</html>