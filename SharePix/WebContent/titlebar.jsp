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

<!--  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--  -->

<!--  -->
<style type="text/css">
#top-menu {
  width: 100%;
  background-color: #EAEAEA;
  position: fixed;
  top: 0px;
  left: 0px;
}

/*  */

table {
	margin-top: 10px;
	margin-bottom: 10px;
}

.search__input {
        width: 50%;
        padding: 12px 24px;

        background-color: transparent;
        transition: transform 250ms ease-in-out;
        font-size: 14px;
        line-height: 18px;
        
        color: #575756;
        background-color: transparent;
        background-image: url(http://mihaeltomic.com/codepen/input-search/ic_search_black_24px.svg);
        background-repeat: no-repeat;
        background-size: 18px 18px;
        background-position: 95% center;
        border-radius: 50px;
        border: 1px solid #575756;
        transition: all 250ms ease-in-out;
        backface-visibility: hidden;
        transform-style: preserve-3d;
    }
    
.search__input::placeholder {
            color: rgba(87, 87, 86, 0.8);
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

.search__input:hover,
        .search__input:focus {
            padding: 12px 0;
            outline: 0;
            border: 1px solid transparent;
            border-bottom: 1px solid #575756;
            border-radius: 0;
            background-position: 100% center;
        }

/*  */

</style> 
<!--  -->

</head>
<body>

<div id="top-menu">
<table border="0" align="center" width="100%">
<col width="100"><col width="500"><col width="100">
<tr>
	<td align="center">
	<p><font style="text-transform: uppercase; 
					letter-spacing: 1.5px;" size="5">
					SaGong'ssi</font></p>
	</td>
	<td>
	<input class="search__input" type="text" placeholder="Search">
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
