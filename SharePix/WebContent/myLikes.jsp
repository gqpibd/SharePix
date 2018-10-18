<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<PdsBean> list = (List<PdsBean>) request.getAttribute("list");
	System.out.println(list.size());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>즐겨찾기 페이지</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<style type="text/css">
.img_clickable{
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="left__heading" style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="myLikes.jsp" />
		</jsp:include>
	</div>

	<div class="container" style="margin-top: 10em">
		<%for(PdsBean pds : list){ %>
		<div class="item">
			<img class="img img_clickable" name="item" src="images/pictures/<%=pds.getfSaveName()%>" onclick="veiwDetail(<%=pds.getSeq()%>)" height="400">
		</div>
		<%} %>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
		  var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
		  $(".container").rowGrid(options);
		});
		
		function veiwDetail(seq) {
			console.log(seq);
			location.href="PdsController?command=detailview&seq=" + seq;
		}		

	</script>
</body>
</html>