<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	PdsBean pds = (PdsBean) request.getAttribute("pds");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="style/picDetail.css">
<style type="text/css">

</style>
</head>
<body>
	<main class="main">
		<section class="title-bar">    
			타이틀바---------------------------------------------------------------------------------------------
		</section> 
		<section class="left">
			<h2 class="left__heading">
				<% for(int i=0;i<pds.getTags().length;i++){
				%>
					<span class="tag">#<%=pds.getTags()[i] %></span>
				<% } %>
			</h2>
			<div class="wrapper">
				<img src="<%=PdsController.PATH %><%=pds.getfSaveName()%>" class="img"></img>
			</div>
			<button onclick="doLike()"><img src="images/icons/like.png" width="20"> <%=pds.getLikeCount()%></button>
				
		</section> 
		<section class="rightbar">
		<div style="margin: 10px">
			<p>
				<img src="images/profiles/<%=pds.getId()%>.png" width="100"
					class="profile" align="middle">
				<%=pds.getId()%></p>
			<%-- 프로필 사진 보여주는 다른 방식  --%>
			<%-- <div class="profile-container">
				<img src="images/profiles/<%=pds.getId()%>.png" class="profile-img">
				<div class="bottomleft">
					<h2 class="profile-text"><%=pds.getId()%></h2>
				</div>
			</div> --%>
			<img src="images/icons/down.png" width="20"><font size="5">&nbsp;&nbsp;<%=pds.getDownCount()%></font><br>
			<div align="center">
				<button class="download" onclick="doDownload()">다운로드</button>
			</div>
			
		</div>
	
		</section> 
		</main>
	
	<script language="JavaScript" type="text/javascript">	
		function doLike(){ // 좋아요 눌렀을 때
			
		}
		
		function doDownload(){ // 다운로드 눌렀을 때
			
		}
	</script>

</body>
</html>