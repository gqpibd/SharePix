<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
#top-menu {
  width: 100%;
  background-color: #ffffff;
  position: fixed;
  top: 0px;
  left: 0px;
}
</style> 


</head>
<body bgcolor="#D5D5D5">


<%
Object ologin = session.getAttribute("login");
MemberBean mem = null;
if(ologin == null)
{
%>

	<script type="text/javascript">
	alert("로그인 후 이용 가능합니다.");
	location.href = "index.jsp";
	</script>

<% 
	return;
}

mem = (MemberBean)ologin;

%>


<div id="top-menu">
<table border="0" align="center" width="100%">
<col width="100"><col width="500"><col width="100">
<tr>
	<td align="center">
	<p><font>sagong.com</font></p>
	</td>
	<td>
	<input type="text" title="search" size="50" maxlength="50"
	value="검색" onfocus="this.value=''" 
	onblur="if(this.value =='') this.value='검색';" 
	onkeydown="return fn_SubmitFromInput();" 	
	>
	</td>
	<td align="center">
	<h5><%=mem.getName() %>님 환영합니다. <a href="MemberController?command=logout"><font size="2">로그아웃</font></a> </h5>
	<!-- <input type="submit" value="로그인"> -->
</tr>
</table>
</div>


</body>
</html>