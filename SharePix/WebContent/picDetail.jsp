<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	PdsBean pds = (PdsBean) request.getAttribute("pds");
	// 로그인 아이디 받아서
	// 좋아요 한거면 채워진 하트 보여주기
	String like = "images/icons/like_empty.png";

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세 화면</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="style/picDetail.css"> 
</head>
<body>
	<main class="main">
		<section class="title-bar">    
			타이틀바---------------------------------------------------------------------------------------------
		</section> 
		<!-- 왼쪽 이미지랑 댓글 부분 -->
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
			<button onclick="doLike()" class="btn-like"><img src="<%=like %>" width="15" id="like">&nbsp;&nbsp; <font size="3"><%=pds.getLikeCount()%></font></button><br>
			<p><img src="images/icons/re_down.png" width="30" id="replyToggle">&nbsp;&nbsp;댓글&nbsp;<%=pds.getReplyCount() %>&nbsp;개</p>
			
			<div id="replies">
				댓글들
			</div> 
			<div class="wrap" align="center">
				<textarea id="writeReply" placeholder="댓글을 작성해 주세요"></textarea>
			</div>
			<div align=right style="padding:10px" >
				<button class="btn-like">등록</button>
			</div>
		</section> 
		
		<!-- 오른쪽 프로필이랑 다운로드 부분 -->
		<section class="rightbar">
		<div style="margin: 10px">
			<p>
				<img src="images/profiles/<%=pds.getId()%>.png" width="100" class="profile" align="middle">
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
			var src = $("#like").attr("src");
			if(src=="images/icons/like_empty.png"){
				$("#like").attr("src",'images/icons/like_fill.png');
			}else{
				$("#like").attr("src","images/icons/like_empty.png");
			}			
		}
		
		function doDownload(){ // 다운로드 눌렀을 때
			
		}
		$("#replies").hide();
		$(document).ready(function(){
			
			$("#replyToggle").click(function(){
				$("#replies").slideToggle("fast",function(){
					if($("#replyToggle").attr("src") == "images/icons/re_down.png"){
						$("#replyToggle").attr("src","images/icons/re_up.png");
					}else{
						$("#replyToggle").attr("src","images/icons/re_down.png");
					}
				});
			});
			
			//textarea 자동 크기 조절			
	      $('.wrap').on( 'keyup', 'textarea', function (e){
	        $(this).css('height', 'auto' );
	        $(this).height( this.scrollHeight );
	      });
	      $('.wrap').find( 'textarea' ).keyup();
		});
		
	</script>

</body>
</html>