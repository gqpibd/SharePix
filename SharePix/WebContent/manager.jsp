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

	// 비회원로그인시 정해주어야. 
	Object ologin = session.getAttribute("login");
	MemberBean loginMemDto = null;
	
 	loginMemDto = (MemberBean)ologin;// 세션에 담겨있던 로그인한 사람의 dto

 	// 관리자페이지 버튼 클릭했을 때 바로 여기로 넘어오게 해줘야겠네요 다시ㄷ
	
	
	/* System.out.println("pageMemDto.toString() : " + pageMemDto.toString()); */
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="style/common.css">
<style type="text/css">
.td {
	text-align: center;
	padding: 10px;
}
.profile {
    width: 200px; 
    height: 200px;
    object-fit: cover;
    border-radius: 50%;
    border: 0.1em solid grey;
}
</style>
<title>manager</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<link rel="shortcut icon" href="images/icons/favicon.ico">
</head>
<body>

	<div style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="main.jsp" />
		</jsp:include>
	</div>

	<div style="margin-top: 8em">

	<hr>		
	<!-- 여기부터 -->
		<div id="userCollect"><!-- 대신 그 내용이 imageGrid.jsp에 있어요  --><!-- 커맨드바꿔주세요 -->
			<jsp:include page="imageGrid.jsp" flush="true">
				<jsp:param name="command" value="manager" />				
			</jsp:include>
		</div>
		<!-- 여기까지가 이거에요  이게 짧으니까 이걸 쓸거에요 넵 진짜 짧네요; 위에는 버리죠 ㄴ네 -->
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