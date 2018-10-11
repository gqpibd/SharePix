<%@page import="model.service.PdsService"%>
<%@page import="model.iPdsManager"%>
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
	// 기본적으로 비워진 하트임
	String like = "images/icons/like_empty.png";
	// 아이디 확인하고 받아서 like 확인하고 이미지 넣기
	MemberBean ologin = (MemberBean) session.getAttribute("login");
	if(ologin==null){
		System.out.println("유저 없음");
	}
	boolean isLike = false;
	PdsService pService = null;
	if(ologin!=null){
		String id = ologin.getId();
		int seq = pds.getSeq();
		pService = PdsService.getInstance();
		isLike = pService.checkPdsLike(id, seq);
		if(isLike){
			like = "images/icons/like_fill.png";
		}
	}
	
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
<script src="https://scripts.sirv.com/sirv.js"></script>
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
			<button onclick="doLike()" class="btn-like"><img src="<%=like %>" width="15" id="like">&nbsp;&nbsp; <span id="likeCount"><font size="3"><%=pds.getLikeCount()%></font></span></button><br>
			<input type="hidden" id="ajax_hidden">
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
						<div class="reply_content">
							
							<span class="nickname"><%=re.getId()%>
							<% if(re.getId().equals(pds.getId())){ %>
							<img src="images/icons/writer.png" width="60" style="vertical-align: middle">
							<%} %>  
							</span>
							<span><%=re.getContent() %></span><br>
							<font style="font-size: 3px; color:graytext;"><%=re.getWdate() %></font><br>
							<button name="<%=re.getReRef()%>" onclick="addReply(this)" id="<%=re.getReSeq()%>" toWhom="<%=re.getId()%>">답변</button>							
						</div>
					</li>
					<%
				} }else{%>
					<li>
						등록된 댓글이 없습니다. 첫 번째 댓글을 남겨주세요
					</li>
				<%} %>
			</ul>
			 
			<form action="ReplyController">
				<input type="hidden" name="command" value="addReply">
				<input type="hidden" name="id" value="<%=ologin.getId() %>">
				<input type="hidden" name="pdsSeq" value="<%=pds.getSeq() %>">
				<div class="wrap" align="center">
					<textarea id="new_reply_content" placeholder="댓글을 작성해 주세요" name="content"></textarea>			
					<div align=right style="padding:10px">
						<button class="btn-like" id="new_reply" type="submit">등록</button>
					</div>
				</div>
			</form>
		</section> 
		
		<!-- 오른쪽 프로필이랑 다운로드 부분 -->
		<section class="rightbar">
		<div style="margin: 10px">
			<p>
				<img src="images/profiles/<%=pds.getId()%>.png" width="100" class="profile" align="middle">
				<%=pds.getId()%></p>			
			<img src="images/icons/down.png" width="20"><font size="5">&nbsp;&nbsp;<%=pds.getDownCount()%></font><br>
			<div align="center">		
				
				<button class="download" onclick="doDownload()">다운로드</button>
			</div>
					
			<div class="selectSize"></div>
			<input type="range" min="20" max="100" step="20" value="100">
				
		</div>	
		</section> 
		</main>

	<script type="text/javascript">	
		var like = <%=isLike%>;
	  	var width = document.getElementById("pdsImg").naturalWidth;
	  	var height = document.getElementById("pdsImg").naturalHeight;
	  	
		document.querySelector('.selectSize').innerHTML = width + " x " + height;
		var elem = document.querySelector('input[type="range"]');
	
		var rangeValue = function(){			
		  var rate = elem.value;
		  width = Math.round(document.getElementById("pdsImg").naturalWidth  * (rate/100));
		  height = Math.round(document.getElementById("pdsImg").naturalHeight  * (rate/100));
		  var target = document.querySelector('.selectSize');
		  target.innerHTML = width + " x " + height;
		}
	
		elem.addEventListener("input", rangeValue);
	
		function doLike(){ // 좋아요 눌렀을 때			
			<%if(ologin == null){	%>
				alert("로그인해 주십시오");	
				location.href="index.jsp";
			<%		
			}else{
				System.out.println(isLike);
				%>				
				$.ajax({
					url:"PdsController", // 접근대상
					type:"get",		// 데이터 전송 방식
					data:"command=likeChange&like=" + like + "&id=<%=ologin.getId()%>&seq=<%=pds.getSeq()%>", // 전송할 데이터
					success:function(data, status, xhr){
						/* console.log(data); */
						like = $("#ajax_hidden").html(data).find("like").text();
						var count = $("#ajax_hidden").html(data).find("count").text();
						if(like == "false"){
							$("#like").attr("src",'images/icons/like_empty.png');
							$("#likeCount").text(count);
						}else{
							$("#like").attr("src",'images/icons/like_fill.png');
							$("#likeCount").text(count);
						}
					},
					error:function(){ // 또는					 
						console.log("통신실패!");
					}
				});				
				<%				
			}%>
		}
		
		
		function doDownload(){ // 다운로드 눌렀을 때
			 
			
		}
		
		function addReply(re_btn){            
			$("#rere_wrtie").remove();
			var name = $(re_btn).attr('name');
			var toWhom = $(re_btn).attr('toWhom');
			var selector = "[name='" + name +"']";		
			
			var element ="<div class='wrap' align='center' id='rere_write'>";
			element +=		"<form action='ReplyController'>"; 
			element +=			"<input type='hidden' name='command' value='addReply'>";
			element +=			"<input type='hidden' name='id' value='<%=ologin.getId() %>'>";
			element +=			"<input type='hidden' name='pdsSeq' value='<%=pds.getSeq() %>'>";
			element +=			"<input type='hidden' name='refSeq' value=" + name + ">";
			element += 			"<input type='hidden' name='toWhom' value=" + toWhom + ">";
			element += 			"<textarea id='writeReply' placeholder='"+toWhom+"님에게 댓글 작성' name='content'></textarea>";
			element += 			"<div align=right style='padding:10px' >";
			element += 			"<button class='btn-like' type='submit'>등록</button>";
			element +=			"</div>";
			element +=		"</form>";
			element +=	"</div>";
			$(selector).last().parent().parent().after(element);
			                                                                         
		}                                                                            
		                                                                             
		// 답변 보기/ 숨기기                                                                
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