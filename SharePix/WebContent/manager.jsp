<%@page import="controller.FileController"%>
<%@page import="java.io.File"%>
<%@page import="model.service.MemberService"%>
<%@page import="dto.FollowDto"%>
<%@page import="model.service.PdsService"%>
<%@page import="java.util.List"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
	MemberBean loginMemDto = (MemberBean)  session.getAttribute("login");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<link rel="shortcut icon" href="images/icons/favicon.ico">
<link rel="stylesheet" href="style/common.css">
</head>
<body>
	<div style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="main.jsp" />
		</jsp:include>
	</div>

	<div style="margin-top: 10em">
	<%if(PdsService.getInstance().getsingoPdsAllList().size()>0){ %>
		<h3 style="font-size: 30px; font-family: 'Do Hyeon', sans-serif; margin-left: 10px">신고글 목록</h3>	
		<div id="userCollect"> 
			<jsp:include page="imageGrid.jsp" flush="true">
				<jsp:param name="command" value="manager" />				
			</jsp:include>
		</div>
	<%}else{ %>
		<h3 style="font-size: 30px; font-family: 'Do Hyeon', sans-serif; margin-left: 10px">신고된 글이 없습니다</h3>	
	<%} %>		
	</div>
</body>

<script type="text/javascript">
	function veiwDetail(seq) { // 클릭했을 때 사진 상세 페이지로 이동해주는 부분
	   console.log(seq);
	   location.href="PdsController?command=detailview&seq=" + seq;
	}     	

 	$(document).ready(function() {	 // 이부분이 사진 정렬 원하는대로 해주는거니까 지우면 안 되요	
		var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
		$(".mcontainer").rowGrid(options);		
	});
</script>

</html>