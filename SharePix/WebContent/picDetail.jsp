<%@page import="model.MemberManager"%>
<%@page import="model.service.MemberService"%>
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

	List<PdsBean> list = (List<PdsBean>) request.getAttribute("list");

	// 로그인 아이디 받아서
	// 기본적으로 비워진 하트임
	String like = "images/icons/like_empty.png";
	// 아이디 확인하고 받아서 like 확인하고 이미지 넣기
	MemberBean ologin = (MemberBean) session.getAttribute("login");
	
	boolean isLike = false;
	PdsService pService = null;
	String id = "";
	if (ologin != null) {
		id = ologin.getId();
		int seq = pds.getSeq();
		pService = PdsService.getInstance();
		isLike = pService.checkPdsLike(id, seq);
		if (isLike) {
			like = "images/icons/like_fill.png";
		}
	}

	// 댓글목록 
	ReplyService rService = ReplyService.getInstance();
	List<ReplyBean> reList = rService.getReplyList(pds.getSeq());
	
	// 팔로우 
	String follow = "images/icons/like_empty.png";
	boolean isFollow = false;
	if (ologin != null) {
		isFollow = MemberService.getInstance().checkMemFollow(ologin.getId(), pds.getId());
	}
	if (isFollow) {
		follow = "images/icons/like_fill.png";
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세 화면</title><!-- 타이틀바 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/picDetail.css">
<link rel="stylesheet" href="style/imageArrange.css">
<style type="text/css">
.img_clickable{
	cursor: pointer;
}
</style>
</head>
<body class="mbody">
	<div class="left__heading" style="height: 100%">
		<!-- jsp scriptlet을 쓰면 값이 안 넘어가짐. EL태그로 해결할 수 있음!! -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="PdsController?command=detailview&seq=${pds.seq}"/>
		</jsp:include>		
	</div>
	<main class="main">	
	<!-- 왼쪽 이미지랑 댓글 부분 -->
	<section class="left">
		<h2 class="left__heading">
			<%
				for (int i = 0; i < pds.getTags().length; i++) { // 태그 표시 부분
			%>
			<span class="tag">#<%=pds.getTags()[i]%></span>
			<%
			}
			%>
		</h2>

		<div class="wrapper" align=center> <!-- 사진 표시 부분 -->
			<img src="images/pictures/<%=pds.getfSaveName()%>" class="img" id="pdsImg"></img> 
		</div>
		<button onclick="doLike()" class="btn-like"> <!-- 좋아요 버튼 -->
			<img src="<%=like%>" width="15" id="like">&nbsp;&nbsp; 
			<span id="likeCount"><font size="3"><%=pds.getLikeCount()%></font></span>
		</button>
		<br> <input type="hidden" id="ajax_hidden"> <!-- ajax용 임시 태크 -->		
		<p> <!-- 댓글 창 숨기기/보기 버튼 -->
			<img src="images/icons/re_down.png" width="30" id="replyToggle">&nbsp;&nbsp;댓글&nbsp;<%=pds.getReplyCount()%>&nbsp;개
		</p>
		
		<!-- 댓글 창 -->
		<ul id="replies" class="list_reply"> 
			<%
			if (reList != null) {
				for (ReplyBean re : reList) {
					String src = "images/profiles/" + re.getId() + ".png";
					String srcError = "images/profiles/default.png";
				%>
				<li class="reply">
				<% if (re.getReSeq() != re.getReRef()) { %> <!-- 대댓일 때 표시 --> 
				<img src="images/icons/rere.png" style="float: left; width: 20px; margin-right: 13px"> 
				<%}if (re.getDel() == 1) { %>
					<div class="reply_content">삭제된 댓글입니다</div> 
				<%} else { // 댓글 표시
			 		if (ologin != null && re.getId().equals(ologin.getId())) { %> <!-- 작성자일 때 수정, 삭제 가능하게 -->
					<div class="mtooltip" align="right">
						<img src="images/icons/more.png" width="3px" align="right" class="more img_clickable" > 
						<span class="mtooltiptext"> 
						<label onclick="modify('<%=re.getReSeq()%>','<%=re.getContent() %>')" id="<%=re.getReSeq()%>" class="aTag">수정</label><br> 
						<label onclick="deleteReply(<%=re.getReSeq()%>)" class="aTag">삭제</label><br>
						</span>
					</div> 
					<%}%>
				 	<img src="<%=src%>" class="profile re-img img_clickable" width="10" onerror="this.src='<%=srcError%>'" onclick="location.href='MemberController?command=userPage&id=<%= re.getId()%>'">
					<div class="reply_content">
						<span class="nickname"><%=re.getId()%> 
					<% if (re.getId().equals(pds.getId())) { // 게시글 작성자 표시
				 	%> 
				 	<img src="images/icons/writer.png" width="60" style="vertical-align: middle"> 
				 	<%} %> 
				 	</span> 
				 	<span id="content_<%=re.getReSeq()%>"> <!-- 댓글 내용 부분 -->
					 	<% if (re.getToWhom() != null & re.getToWhom() != "") { %> <!-- 다른 사람 호출하는 태그가 있을 때 --> 
					 	<b>@<%=re.getToWhom()%></b> 
					 	<% } %> 
					 	<%=re.getContent()%>
					</span><br> 
					<font style="font-size: 3px; color: graytext;"><%=re.getWdate()%></font><br> <!-- 날짜 -->
					<% if (ologin != null) { %>
						<button name="<%=re.getReRef()%>" onclick="addReply(this)" id="<%=re.getReSeq()%>" toWhom="<%=re.getId()%>">답변</button>
					<% } %>
					</div>
				<% } %>
				</li>
			<%} // 여기까지 for loop%>
			<%} else { // list가 null 일 때 	%>
				<li>등록된 댓글이 없습니다. 첫 번째 댓글을 남겨주세요</li>
			<%}%>
		</ul>
		
		<div class="wrap" align="center">
			<% if (ologin == null) { %> <!-- 로그인 상태가 아니면 -->
				댓글을 작성하려면 <label style="cursor: pointer;" onclick="loginView()"><b>로그인</b></label>해주세요
			<% }else{ %>
			<form action="ReplyController">
				<input type="hidden" name="command" value="addReply"> 
				<input type="hidden" name="id" value="<%=ologin.getId()%>"> 
				<input type="hidden" name="pdsSeq" value="<%=pds.getSeq()%>">
				<div align=left>
					<img src='images/profiles/<%=ologin.getId()%>.png' width='10'
						class='profile re-img' align='middle'
						onerror="this.src='images/profiles/default.png'" > 
					<span class="nickname"><%=ologin.getId()%></span>
				</div>
				<textarea id="new_reply_content" placeholder="댓글을 작성해 주세요" name="content"></textarea>
				<div align=right style="padding: 10px">
					<button class="btn-like" id="new_reply" type="submit">등록</button>
				</div>
			</form>
			<%}%>
		</div>

	</section>

	<!-- 오른쪽 프로필이랑 다운로드 부분 -->
	<section class="rightbar">
		<div style="margin: 10px">
			<p>
				<img src="images/profiles/<%=pds.getId()%>.png" width="100"	class="profile img_clickable" align="middle"
					 onerror="this.src='images/profiles/default.png'"
					 onclick="location.href='MemberController?command=userPage&id=<%= pds.getId()%>'"> <!-- 작성자의 프로필 사진 -->
					 <%=pds.getId()%>				
			</p>
				
				
			<img src="images/icons/down.png" width="20"><font size="5">&nbsp;&nbsp;<%=pds.getDownCount()%></font><br> <!-- 다운로드 수 -->
			<%-- <div align="center">
				<a href="#" class="download" id="downBtn"  download="<%=pds.getFileName()%>">다운로드</a>
				<img  id="downloadImg" name="imgData" width="0"></img>				
			</div> --%>
			<% if(ologin != null && pds.getId().equals(ologin.getId()) ){ %>
				<button onclick="location.href='updatePds.jsp?seq=<%=pds.getSeq()%>'">수정</button>
			<%} %>
	
	<%-- 		<% if(pds.getId().auth==3 ){ %>
				<button onclick="location.href='updatePds.jsp?seq=<%=pds.getSeq()%>'">수정</button>
			<%} %> --%>
			
			<% if(ologin != null && !pds.getId().equals(ologin.getId())){ %>
				<button onclick="doFollow()">
					<img id="followImg" src="<%=follow%>" width="15" id="follow">&nbsp;&nbsp;팔로우
				</button>
			<%} %>
			<div align="center">
				<form action="FileController">
					<input type="hidden" name="command" value="download">
					<input type="hidden" name="rate" value="100">
					<input type="hidden" name="pdsSeq" value="<%=pds.getSeq()%>">
					<input type="hidden" name="fsavename" value="<%=pds.getfSaveName()%>">
					<input type="hidden" name="filename" value="<%=pds.getFileName()%>">
					<input class="download" type="submit" value="다운로드">					
				</form>				
			</div>

			<div class="selectSize"></div> <!-- 사이즈 선택 슬라이더 -->
			<input type="range" min="20" max="100" step="20" value="100">
			<!-- 추천 사진들(카테고리로 추천함) -->
			<div class="mcontainer" align="center">
				<p style="font-size: 20px; margin: 10px; font-weight: bold;">이런 사진은 어때요?</p>				
				 
				<%for(PdsBean bean : list){ %>
				<div class="item">	
					<img class="img_clickable" src="images/pictures/<%=bean.getfSaveName()%>" onclick="veiwDetail(<%=bean.getSeq()%>)" height="300"> 
				</div>
				<%} %>
			</div>
			
		</div>
	</section>
	</main>

	<script type="text/javascript">	
	
		var like = '<%=isLike%>';
		function doLike(){ // 좋아요 눌렀을 때			
			<%if (ologin == null) {%>
				loginView();
			<%} else {
				System.out.println(isLike);%>				
				$.ajax({
					url:"PdsController", // 접근대상
					type:"get",		// 데이터 전송 방식
					data:"command=likeChange&like="+like+"&id=<%=id%>&seq=<%=pds.getSeq()%>", // 전송할 데이터
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
			<%}%>
		}
		$(document).ready(function () {						
			var OriginWidth = document.getElementById("pdsImg").naturalWidth; // 원본 이미지 사이즈
			var OriginHeight = document.getElementById("pdsImg").naturalHeight; // 원본 이미지 사이즈
		  	var width = OriginWidth; // 다운받을 이미지 사이즈
		  	var height = OriginHeight; // 다운받을 이미지 사이즈
	  	
			document.querySelector('.selectSize').innerHTML = width + " x " + height;
			var elem = document.querySelector('input[type="range"]');
		
			var rangeValue = function(){
				var rate = elem.value;
				width = Math.round(OriginWidth  * (rate/100));
				height = Math.round(OriginHeight  * (rate/100));
				var target = document.querySelector('.selectSize');
				target.innerHTML = width + " x " + height;
				$("input[name='rate']").val(rate);
			}
		
			elem.addEventListener("input", rangeValue);
		
		
		
		                                                                          
		                                                                             
		// 답변 보기/ 숨기기                                                                
		$("#replies").hide();           
			$("#replyToggle").click(function(){
				$("#replies").slideToggle("fast",function(){
					if($("#replyToggle").attr("src") == "images/icons/re_down.png"){
						$("#replyToggle").attr("src","images/icons/re_up.png");
					}else{
						$("#replyToggle").attr("src","images/icons/re_down.png");
					}
				});
			});
	
		// textarea 자동 크기 조절			
		// 동적으로 생성된 태그에 이벤트를 적용하기 위해서는 $(document).on()으로 해줘야 한다.
		// $(".wrap").on('keyup', 'textarea',function(e){ --> 이렇게 하면 원래 있던 태그에만 적용됨
		$(document).on('keyup', 'textarea',".wrap",function(e){
			$(this).css('height', 'auto' );
			$(this).height( this.scrollHeight );
		});
		$('.wrap').find( 'textarea' ).keyup();
	});			
		
	</script>
	
	<script type="text/javascript">
		//추천 이미지 배열
		$(document).ready(function() {
		  var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
		  $(".mcontainer").rowGrid(options);
		});
		
		
		function veiwDetail(seq) {
			console.log(seq);
			location.href="PdsController?command=detailview&seq=" + seq;
		}		
		
		function addReply(re_btn){       // 댓글 추가
			$("#rere_write").remove();
			var name = $(re_btn).attr('name');
			var toWhom = $(re_btn).attr('toWhom');
			var selector = "[name='" + name +"']";
						
			$.ajax({
				url:"reply.jsp", // 접근대상
				type:"get",		// 데이터 전송 방식
				data:"command=rere&id=<%=id%>&pdsSeq=<%=pds.getSeq()%>&toWhom="+toWhom+"&reRef="+name, 
				success:function(data, status, xhr){
					console.log(data);
					$(selector).last().parent().parent().after(data).trigger("create");
				},
				error:function(){ // 또는					 
					console.log("통신실패!");
				}
			});	
		
		}  
		
		// 취소
		function cancel(item,reSeq) {
			$.ajax({
				url:"reply.jsp", // 접근대상
				type:"get",		// 데이터 전송 방식
				data:"command=cancel&loginId=<%=id%>&pdsWriter=<%=pds.getId()%>&reSeq="+reSeq, 
				success:function(data, status, xhr){
					//console.log(data.trim());
					console.log($(this).parents().eq(5));
					$(item).parents().eq(4).replaceWith(data.trim());
				},
				error:function(){ // 또는					 
					console.log("통신실패!");
				}
			});	
		}
		
		// 댓글 삭제
		function deleteReply(reSeq) {
			var check = confirm("정말 삭제하시겠습니까?");			
			if (check) {
				location.href = "ReplyController?command=delete&reSeq=" + reSeq + "&pdsSeq=" + <%=pds.getSeq()%>;
			}
		}
		
		// 댓글 수정
		function modify(reSeq,content){ 			
			console.log(reSeq);
			var selector = "label[id='" + reSeq +"']";		
		
			
			$.ajax({
				url:"reply.jsp", // 접근대상
				type:"get",		// 데이터 전송 방식
				data:"command=modify&id=<%=id%>&pdsSeq=<%=pds.getSeq()%>&content="+content +"&reSeq="+reSeq, 
				success:function(data, status, xhr){
					console.log(data.trim());
					$(selector).parents().eq(2).replaceWith(data.trim());
				},
				error:function(){ // 또는					 
					console.log("통신실패!");
				}
			});			
		}
		
		// 팔로우
		var followChk = '<%=isFollow%>';
		function doFollow(){ // 좋아요 눌렀을 때			
			<%if (ologin == null) {%>
				alert("로그인해 주십시오");	
				location.href="index.jsp";
			<%} else {%>				
				$.ajax({
					url:"MemberController", // 접근대상
					type:"get",		// 데이터 전송 방식
					data:"command=follow&followeeId=<%=pds.getId()%>&followerId=<%=ologin.getId()%>" +"&followChk=" + followChk, // 전송할 데이터
					success:function(data, status, xhr){
						/* console.log(data); */
						followChk = $("#ajax_hidden").html(data).find("followChk").text();
						if(followChk == "false"){
							$("#followImg").attr("src",'images/icons/like_empty.png');
						}else{
							$("#followImg").attr("src",'images/icons/like_fill.png');
						}
					},
					error:function(){ // 또는					 
						console.log("통신실패!");
					}
				});				
			<%}%>
		}
	</script>
	

</body>
</html>