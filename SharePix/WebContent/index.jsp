<%@page import="dto.MemberBean"%>
<%@page import="model.service.PdsService"%>
<%@page import="controller.PdsController"%>
<%@page import="java.util.List"%>
<%@page import="dto.PdsBean"%>
<%@page import="model.PdsManager"%>
<%@page import="model.iPdsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>SaGong</title>
<%
	List<PdsBean> pdslist = null;
	if((pdslist= (List<PdsBean>) request.getAttribute("list")) == null){		
		pdslist = PdsService.getInstance().getSearchPdsNull();   
	}
	System.out.println(pdslist.size());
	PdsBean pdsLike = (PdsBean) request.getAttribute("pds");
	String like = "heart.png";
	// 아이디 확인하고 받아서 like 확인하고 이미지 넣기
	MemberBean ologin = (MemberBean) session.getAttribute("login");
	if (ologin == null) {
		System.out.println("유저 없음");
	}
	boolean isLike = false;
	PdsService pService = null;
	String id = "";
	if (ologin != null) {
		id = ologin.getId();
		int seq = pdsLike.getSeq();
		pService = PdsService.getInstance();
		isLike = pService.checkPdsLike(id, seq);
		if (isLike) {
			like = "fullheart.png";
		}
	}
%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<style type="text/css">
.img{
	cursor: pointer;
}
</style>
</head>
<body bgcolor="#D5D5D5">
	<div class="left__heading" style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>

	<div style="margin-top: 10em"> <!-- 검색 -->
		<form action="PdsController" method="get">
		<input type="hidden" name="command" value="keyword"> 
		<input type="text" name="tags"> 
		<input type="submit" value="검색">
		</form>
	</div>
	<div class="container">
		<%
			for (PdsBean Pdscust : pdslist) {
		%>
		<div class="item profilebox profilebox1">
			<img class="img" name="item" src="images/pictures/<%=Pdscust.getfSaveName()%>" onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300">
			<div class="SocialIcons">
			<a>
				<img alt="" src="images/icons/<%=like %>" 
				onmouseover="this.src='images/icons/fullheart.png'"
				onmouseout="this.src='images/icons/<%=like %>'"
				onclick="doLike()" class="btn-like">
				<label><%=Pdscust.getLikeCount()%></label>
			</a>
			 <a href="#" style="text-decoration:none; color: white;">
				<img alt="" src="images/icons/openbook.png" 
				onmouseover="this.src='images/icons/fullopenbook.png'"
				onmouseout="this.src='images/icons/openbook.png'"
				>
				<label><%=Pdscust.getReadCount()%></label>
			</a>
			<a href="#" style="text-decoration:none; color: white;">
            	<img alt="" src="images/icons/contract.png" 
				onmouseover="this.src='images/icons/fullcontract.png'"
				onmouseout="this.src='images/icons/contract.png'"
				>
				<label><%=Pdscust.getReplyCount()%></label>
			</a>
		</div>
		<div class="profileInfo">
		<h3><a href= "MemberController?command=userPage&id=<%=Pdscust.getId()%>" style="text-decoration:none; color: white;"><%=Pdscust.getId()%></a></h3>
		</div>
		</div>
		<%
		}
		%>
	</div>

	<script type="text/javascript">
	
	var like = '<%=isLike%>';
	function doLike(){ // 좋아요 눌렀을 때			
		<%if (ologin == null) {%>
			alert("로그인해 주십시오");	
			location.href="index.jsp";
		<%} else {
			System.out.println(isLike);%>				
			$.ajax({
				url:"PdsController", // 접근대상
				type:"get",		// 데이터 전송 방식
				data:"command=likeChange&like="+like+"&id=<%=id%>&seq=<%=pdsLike.getSeq()%>", // 전송할 데이터
				success:function(data, status, xhr){
					/* console.log(data); */
					like = $("#ajax_hidden").html(data).find("like").text();
					var count = $("#ajax_hidden").html(data).find("count").text();
					if(like == "false"){
						$("#like").attr("src",'images/icons/heart.png');
						$("#likeCount").text(count);
					}else{
						$("#like").attr("src",'images/icons/fullheart.png');
						$("#likeCount").text(count);
					}
				},
				error:function(){ // 또는					 
					console.log("통신실패!");
				}
			});				
		<%}%>
	}
	
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