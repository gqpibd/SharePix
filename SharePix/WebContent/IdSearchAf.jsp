
<%@page import="dto.MemberBean"%>
<%@page import="model.service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String email = request.getParameter("email");
	
    MemberService dao = MemberService.getInstance();
    MemberBean mem = dao.getEmail(new MemberBean(null, null, null, email, null, 0));
    %>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
if(mem != null && !mem.getId().equals("")){
	session.setAttribute("IdSearchAf", mem);
	session.setMaxInactiveInterval(30*60);
%>
	<script type="text/javascript">
	alert("당신의 id는 <%=mem.getId() %>입니다.");
	location.href = "IdPwSearch.jsp?id=" + "<%=mem.getId() %>";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("id를 찾지 못했습니다.");
	location.href = "IdPwSearch.jsp";
	</script>
<%
}
%>



</body>
</html>