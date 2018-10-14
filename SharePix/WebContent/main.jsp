<%@page import="controller.PdsController"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Object ologin = session.getAttribute("login");
	MemberBean mem = null;
	mem = (MemberBean) ologin;
%>
<!DOCTYPE html>
<html>
<head>
<title>main</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<style type="text/css">
.container {
  background: #eee;
}
/* clearfix */
.container:before,
.container:after {
    content: "";
    display: table;
}
.container:after {
    clear: both;
}

.item {
  float: left;
  margin-bottom: 10px; 
}
.item img {
  max-width: 100%;
  max-height: 100%;
  vertical-align: bottom;
}
.first-item {
  clear: both;
}
/* remove margin bottom on last row */
.last-row, .last-row ~ .item {
  margin-bottom: 0;
}

</style>
</head>
<body>
	<h2>main.jsp</h2>

	<form action="PdsController" method="get">
		<input type="hidden" name="command" value="keyword"> <input
			type="text" name="tags"> <input type="submit" value="검색">
	</form>

	<form action="MemberController" method="get">
		<input type="hidden" name="command" value="myPage"> 
		<input type="submit" value="개인 페이지">
	</form>
	<% if(ologin!=null){ %>
	<form action="PdsController" method="get" id="likes">
		<input type="hidden" name="command" value="myLikePdsList"> 
		
		<input type="hidden" name="id" value="<%=((MemberBean)ologin).getId()%>">
		 
		<input type="submit" value="즐겨찾기"> 
	</form>
	<%} %>
	
	<a href="MemberController?command=logout">로그아웃</a><br> 
	<div class="container">
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>수원화성.jpg"onclick="veiwDetail(this)" seq="1" height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>totaleclipse.jpg" onclick="veiwDetail(this)" seq="22"  height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>moon.jpg" onclick="veiwDetail(this)" seq="23" height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>food.jpg" onclick="veiwDetail(this)" seq="24" height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>eclipse.jpg" onclick="veiwDetail(this)" seq="25" height="200"> </div>	
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>watch.jpg" onclick="veiwDetail(this)" seq="26" height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>snow1.png" onclick="veiwDetail(this)" seq="27" height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>snow2.png" onclick="veiwDetail(this)" seq="28" height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>snow3.png" onclick="veiwDetail(this)" seq="29" height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>boat.png" onclick="veiwDetail(this)" seq="30" height="200"> </div>
		<div class="item">	<img class="img" name="item" src="<%=PdsController.PATH%>graffiti.png" onclick="veiwDetail(this)" seq="31" height="200"> </div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
		  var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
		  $(".container").rowGrid(options);
		});
		
		
		function veiwDetail(img) {
			var seq = $(img).attr("seq")
			console.log(seq);
			location.href="PdsController?command=detailview&seq=" + seq;
		}		

	</script>


</body>
</html>