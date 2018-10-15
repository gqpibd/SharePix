<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberBean user = (MemberBean) session.getAttribute("login");
	String goBackTo = request.getParameter("goBackTo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>


<style type="text/css">
#top-menu {
  width: 100%;
  background-color: #ffffff;
  top: 0px;
  left: 0px;
  position: fixed;
}

</style> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div id="top-menu">
<table border="1" align="center" width="100%">
<col width="100"><col width="500"><col width="100">
<tr>
	<td align="center">
	<p><font>sagong.com</font></p>
	</td>
	<td>
	<input type="text" title="search" size="50" maxlength="50" value="검색" onfocus="this.value=''"
		   onblur="if(this.value =='') this.value='검색';" onkeydown="return fn_SubmitFromInput();">
	</td>
	<td align="center">
	<% if(user==null){ %>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" style="margin-right: 5px;">로그인</button>
		<button type="button" class="btn btn-primary" onclick="location.href='regi.jsp'" style="margin-left: 5px;">회원가입</button>
	<%}else{ %>
		<h5><%=user.getName() %>님 환영합니다. <a href="MemberController?command=logout"><font size="2">로그아웃</font></a> </h5>
		<button onclick="location.href='myPage.jsp'">마이페이지</button>
		<button onclick="location.href='pdswrite.jsp'">사진 올리기</button>
		<button onclick="location.href='PdsController?command=myLikePdsList&id=<%=user.getId()%>'">즐겨찾기</button>
	<%} %>
	<!-- <input type="submit" value="로그인"> -->
</tr>
</table>
</div> 

<script>
window.onscroll = function() {myFunction()};

var header = document.getElementById("top-menu");
var sticky = header.offsetTop;

</script>
 
 
<form method="post" action="MemberController">
	<input type="hidden" name="command" value="login"> 	
	<input type="hidden" name="goBackTo" value="<%=goBackTo%>"> 		
	 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="exampleModalLabel">로그인</h4>
	      </div>
	      <div class="modal-body">		       
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">아이디:</label>
	            <input type="text" class="form-control" id="recipient-name" name="id" title="Username">
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label">패스워드:</label>
	            <input type="password" class="form-control" id="message-text" name="pwd" title="Password">
	          </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='regi.jsp'">회원가입</button>
		        <button type="submit" class="btn btn-primary" value="로그인">로그인</button>
		      </div>
	    </div>
	  </div>
	</div>
</form>

</body>
</html>
