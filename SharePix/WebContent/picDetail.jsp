<%@page import="java.io.File"%>
<%@page import="controller.ReplyController"%>
<%@page import="model.service.ReplyService"%>
<%@page import="dto.ReplyBean"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberBean"%>
<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	PdsBean pds = (PdsBean) request.getAttribute("pds");
	// 로그인 아이디 받아서
	// 좋아요 한거면 채워진 하트 보여주기
	MemberBean ologin = (MemberBean) session.getAttribute("login");
	
	//String id = ologin.getId();
	// 아이디 확인하고 받아서 like 확인하고 이미지 넣기
	String like = "images/icons/like_empty.png";	
	// 댓글목록 
	ReplyService rService = ReplyService.getInstance();
	List<ReplyBean> reList = rService.getReplyList(pds.getSeq());
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
				<img src="<%=PdsController.PATH %><%=pds.getfSaveName()%>" class="img" id="pdsImg"></img>
							
			</div>
			<button onclick="doLike()" class="btn-like"><img src="<%=like %>" width="15" id="like">&nbsp;&nbsp; <font size="3"><%=pds.getLikeCount()%></font></button><br>
			<p><img src="images/icons/re_down.png" width="30" id="replyToggle">&nbsp;&nbsp;댓글&nbsp;<%=pds.getReplyCount() %>&nbsp;개</p>
			
			<ul id="replies" class="list_reply">
				<% if(reList!=null){
				for(ReplyBean re : reList){
					String src = "images/profiles/"+re.getId()+".png";
					String srcError="images/profiles/default.png";
					
					%>
					<%if(re.getReSeq() == re.getReRef()){%>
					<li class="reply">
					<%}else{ %>
						<li class="reply re_reply">
					<%} %>
						<img src="<%=src%>" class="profile re-img" width="10" onerror="this.src='<%=srcError%>'" >
						<span class="reply_content">
							<span class="nickname"><%=re.getId()%>  <font style="size: 1px; color:graytext;"><%=re.getWdate() %></font></span>
							<span><%=re.getContent() %></span><br>							
						</span>
					</li>
					<%
				} }else{%>
					<li>
						등록된 댓글이 없습니다. 첫 번째 댓글을 남겨주세요
					</li>
				<%} %>
			</ul>
			 
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
			<form id="input-form" role="form" method="post" name="f" action="https://img-resize.com/resize" enctype="multipart/form-data">
					
				
				<button class="download" onclick="doDownload()">다운로드</button>
			</form>
			</div>
					
			<div class="selectSize"></div>
			<input type="range" min="20" max="100" step="20" value="100">
				
		</div>	
		</section> 
		</main>

	<script type="text/javascript">	
	  	var width = document.getElementById("pdsImg").naturalWidth;
	  	var height = document.getElementById("pdsImg").naturalHeight;
	  	
		document.querySelector('.selectSize').innerHTML = width + " x " + height;
		var elem = document.querySelector('input[type="range"]');
	
		var rangeValue = function(){			
		  var rate = elem.value;
		  width = Math.round(width  * (rate/100));
		  height = Math.round(height  * (rate/100));
		  var target = document.querySelector('.selectSize');
		  target.innerHTML = width + " x " + height;
		}
	
		elem.addEventListener("input", rangeValue);
	
		function doLike(){ // 좋아요 눌렀을 때
			var src = $("#like").attr("src");
			if(src=="images/icons/like_empty.png"){
				$("#like").attr("src",'images/icons/like_fill.png');
			}else{
				$("#like").attr("src","images/icons/like_empty.png");
			}			
		}
		
		
		function doDownload(){ // 다운로드 눌렀을 때
			 
			<input type="hidden" id="percentage" name="op" value="percentage"> 
			축소 비율 <input id="percent"	name="percent" size="3" value="25"> 
			<input type="submit" value="올리기">
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