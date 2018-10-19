<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String id = request.getParameter("id");
if(id == null || id.equals("")){
	id="";
}
%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="IdSearchAf.jsp" method="post">
<input type="email" name="email" value="" placeholder="e-mail 입력" required="required">
<input type="submit" value="ID찾기">
</form>

<br>

<form action="IdPwSearchAf.jsp" method="post">
<input type="text" name="id" value="<%=id %>" placeholder="ID확인 후 입력" required="required">
<input type="text" name="phone" value="" placeholder="휴대폰 번호 입력" required="required">
<input type="submit" value="PW찾기">
</form>

</body>
</html>