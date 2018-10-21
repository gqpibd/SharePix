<%@page import="controller.FileController"%> 
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
	String like = "images/icons/collection_empty.png";
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
			like = "images/icons/collection_fill.png";
		}
	}

	// 댓글목록 
	ReplyService rService = ReplyService.getInstance();
	List<ReplyBean> reList = rService.getReplyList(pds.getSeq());
	
	// 팔로우 
	String follow = "images/icons/follower_empty.png";
	boolean isFollow = false;
	if (ologin != null) {
		isFollow = MemberService.getInstance().checkMemFollow(ologin.getId(), pds.getId());
	}
	if (isFollow) {
		follow = "images/icons/following.png";
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
<link rel="stylesheet" href="style/common.css">
<link rel="shortcut icon" href="images/icons/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">

<style type="text/css">
.mybtn:focus, .btn:focus{
	outline: 0;
}
.btn.btn-navy.btn-border:focus {
	outline: none;
}
</style>
</head>
<body class="mbody" >
	<div style="height: 100%">
		<!-- jsp scriptlet을 쓰면 값이 안 넘어가짐. EL태그로 해결할 수 있음!! -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="PdsController?command=detailview&seq=${pds.seq}"/>
		</jsp:include>		
	</div>
	<div style="margin-top: 13rem"></div>
	<main class="main">	
	<!-- 왼쪽 이미지랑 댓글 부분 -->
	<section class="left">
		<div class="tagsContainer">
			<%
				for (int i = 0; i < pds.getTags().length; i++) { // 태그 표시 부분
			%>			
			<span class="tag" onclick="location.href='PdsController?command=keyword&choice=SEQ&tags=<%=pds.getTags()[i] %>'">#<%=pds.getTags()[i]%></span>
			<%
			}
			%>
		</div>

		<div class="wrapper" align=center> <!-- 사진 표시 부분 -->
			<img src="images/pictures/<%=pds.getfSaveName()%>" class="img" id="pdsImg"></img> 
		</div>
			
		<p> <!-- 댓글 창 숨기기/보기 버튼 -->
			<img src="images/icons/re_down.png" width="30" id="replyToggle" style="cursor: pointer; margin: 5px; vertical-align: middle;">&nbsp;&nbsp;댓글&nbsp;<%=pds.getReplyCount()%>&nbsp;개
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
					<% if (re.getReSeq() != re.getReRef()) { %> <!-- 대댓일 때 들여쓰기 -->
						<div style="margin-left: 30px">
					<%}else{ %>
						<div>
					<%} %>
						<div>
					 	<img src="<%=src%>" class="profile re-img img_clickable" width="10" align="middle"
					 	onerror="this.src='<%=srcError%>'" onclick="location.href='MemberController?command=userPage&id=<%= re.getId()%>'">
						<font style="font-size: 17px; font-weight: bold;" ><%=re.getId()%></font>
						<% if (re.getId().equals(pds.getId())) { // 게시글 작성자 표시 %> 
					 	<img src="images/icons/writer.png" width="60"> 
					 	<%} %> 	
					 	</div>
					 	<div class="reply_content"> 	
						 	<% if (re.getToWhom() != null & re.getToWhom() != "") { %> <!-- 다른 사람 호출하는 태그가 있을 때 --> 
						 	<b>@<%=re.getToWhom()%></b> 
						 	<% } %> 
						 	<%=re.getContent()%>
						<br> 
						<font style="font-size: 3px; color: graytext;"><%=re.getWdate()%></font><br> <!-- 날짜 -->
						<% if (ologin != null) { %>
							<button class="btn btn-navy btn-border" name="<%=re.getReRef()%>" onclick="addReply(this)" id="<%=re.getReSeq()%>" toWhom="<%=re.getId()%>">답변</button>
						<% } %>
						</div>
					</div>
				<% } %>
				</li>
			<%} // 여기까지 for loop%>
			<%} else { // list가 null 일 때 	%>
				<li>등록된 댓글이 없습니다. 첫 번째 댓글을 남겨주세요</li>
			<%}%>
		</ul>
		
		<div class="wrap" align="center" style="width: 90%; margin:auto">
			<% if (ologin == null) { %> <!-- 로그인 상태가 아니면 -->
				댓글을 작성하려면 <label style="cursor: pointer;" onclick="loginView()"><b>로그인</b></label>해주세요
			<% }else{ %>
			<form action="ReplyController">
				<input type="hidden" name="command" value="addReply"> 
				<input type="hidden" name="id" value="<%=ologin.getId()%>"> 
				<input type="hidden" name="pdsSeq" value="<%=pds.getSeq()%>">
				<div align=left style="margin-left:5px">
					<img src='images/profiles/<%=ologin.getId()%>.png' width='10'
						class='profile re-img' align='middle'
						onerror="this.src='images/profiles/default.png'" ><font style="font-size: 20px; font-weight: bold;"><%=ologin.getId()%></font>
				</div>
				<textarea id="new_reply_content" placeholder="댓글을 작성해 주세요" name="content"></textarea>
				<div align=right style="padding: 10px">
					<button class="mybtn" id="new_reply" type="submit">등록</button>
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
				<font style="font-size: 35px; font-weight: bold; font-family: sans-serif;"> <%=pds.getId()%>	</font>
			</p>
			
			<hr>
			<div align="center" style="vertical-align: middle;">
			<% if(ologin.getAuth() != 3){ %>
				<button onclick="doLike()" class="mybtn"> <!-- 좋아요 버튼 -->
					<img src="<%=like%>" width="20" id="like">&nbsp;&nbsp; 
					<span id="likeCount"><font size="3"><%=pds.getLikeCount()%></font></span>
				</button>&nbsp;&nbsp; 
			<%}%> 

				
				<%
				if((ologin != null && !pds.getId().equals(ologin.getId())&& ologin.getAuth() != 3) || ologin==null ){ //내가 로그인 한게 아닌 경우%>
					
					<button class="mybtn" onclick="doFollow()"><!-- 팔로우 버튼 -->
					<% if (isFollow ) { %>
						<img id="followImg" src="images/icons/following.png" 
						width="20" id="follow">&nbsp;&nbsp;팔로우
					<%}else{%>
						<img id="followImg" src="images/icons/follower_empty.png" width="20" id="follow">&nbsp;&nbsp;팔로우&nbsp;&nbsp;	
							
					<%} %>
					</button>&nbsp;&nbsp;
					<button class="mybtn" type="button" onclick="dosingo()">
						<span class="glyphicon glyphicon-flag" aria-hidden="true" width="20"></span>
						신고
					</button><!-- 신고 버튼  -->

				<%}%>	
				<% if(ologin != null && pds.getId().equals(ologin.getId())&& ologin.getAuth() != 3){ %>
						<button class="mybtn" onclick="location.href='updatePds.jsp?seq=<%=pds.getSeq()%>'">수  정</button>
				<%}	%>
				
	<%-- 			<% if(ologin.getAuth() == 3){ %>
				<button class="mybtn" onclick="deletePds()">삭제</button>
				<button class="mybtn" onclick="donosingo()">신고 해제</button>
			<%}//좋아요 다른데가요 ?네 근데 아이디를 굳이 안 보내도 될거같아요 끝되나 실행해볼까요 넵 !%>  --%>
			
			
			<% if(ologin.getAuth() == 3 && pds.getReport() == 1){ %>
				<button class="mybtn" onclick="deletePds()">삭제</button>
				<button class="mybtn" onclick="donosingo()">신고 해제</button>
			<%}%> 
			<% if(ologin.getAuth() == 3 && pds.getReport() != 1){ %>
				<button class="mybtn" onclick="deletePds()">삭제</button>
			<%}%> 
			

			
				
				
				
			</div>

			<input type="hidden" id="ajax_hidden"> <!-- ajax용 임시 태크 -->		
				
			<hr>
			<div class="downbox">
				<div class="selectSize" style="font-family: 'Noto Sans'; letter-spacing: 1.5px; margin-top: 0px; margin-bottom: 3px"></div> <!-- 사이즈 선택 슬라이더 -->
				<input type="range" min="20" max="100" step="20" value="100">
				<div align="center">
					<form action="FileController" id="imgDown">
						<input type="hidden" name="command" value="download">
						<input type="hidden" name="rate" value="100" >
						<input type="hidden" name="pdsSeq" value="<%=pds.getSeq()%>">
						<input type="hidden" name="fsavename" value="<%=pds.getfSaveName()%>">
						<input type="hidden" name="filename" value="<%=pds.getFileName()%>">
						<input class="download" style="margin-top: 20px;" type="button" onclick="doDown()" value="Download">					
					</form>			
				
					<img src="images/icons/down.png" height="20" align="top">					
					<font style="font-family: 'Noto Sans'; font-size: 20px;" id="dCount">  <%=pds.getDownCount()%></font> <!-- 다운로드 수 -->
				
			</div>
			<hr>
			<!-- 추천 사진들(카테고리로 추천함) -->	
			<div class="mcontainer" align="center">
				<p style="font-size: 20px; margin: 5px; font-weight: bold;">이런 사진은 어때요?</p>
				<%for(PdsBean bean : list){ 
					String fSavename = bean.getfSaveName();
					String smallSrc = fSavename.substring(0,fSavename.lastIndexOf('.')) + "_small" + fSavename.substring(fSavename.lastIndexOf('.'));

					File f = new File(FileController.PATH + "\\" + fSavename);
				    if (f.exists() && f.length()<300000) { // 300kb 이하의 이미지는 그냥 원본을 가져온다
				    	  smallSrc = fSavename;			     
				    }
				%>
				<div class="item">	
					<img class="img_clickable" src="images/pictures/<%=smallSrc%>"
					onclick="veiwDetail(<%=bean.getSeq()%>)" height="200"> 					
				</div>
				<%} %>
			</div>
			
		</div>
	</section>
	</main>

	<script type="text/javascript">	
		function doLike(){ // 좋아요 눌렀을 때			
			<%if (ologin == null) {%>
				loginView();
			<%} else {%>				
				$.ajax({
					url:"PdsController", // 접근대상
					type:"get",		// 데이터 전송 방식
					data:"command=likeChange&id=<%=id%>&seq=<%=pds.getSeq()%>", // 전송할 데이터
					success:function(data, status, xhr){
						/* console.log(data); */
						var like = $("#ajax_hidden").html(data).find("like").text();
						var count = $("#ajax_hidden").html(data).find("count").text();
						if(like == "false"){
							$("#like").attr("src",'images/icons/collection_empty.png');
							$("#likeCount").text(count);
						}else{
							$("#like").attr("src",'images/icons/collection_fill.png');
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
			
		//추천 이미지 배열
		$(document).ready(function() {
		  var options = {minMargin: 5, maxMargin: 20, itemSelector: ".item", firstItemClass: "first-item"};
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
					$(selector).last().parents().eq(2).after(data).trigger("create");
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
					//console.log(data.trim());
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
				loginView();
			<%} else {%>				
				$.ajax({
					url:"MemberController", // 접근대상
					type:"get",		// 데이터 전송 방식
					data:"command=follow&followeeId=<%=pds.getId()%>&followerId=<%=ologin.getId()%>" +"&followChk=" + followChk, // 전송할 데이터
					success:function(data, status, xhr){
						/* console.log(data); */
						followChk = $("#ajax_hidden").html(data).find("followChk").text();
						if(followChk == "false"){
							$("#followImg").attr({"src":"images/icons/follower_empty.png"});
						}else{
							$("#followImg").attr({"src":"images/icons/following.png"});							
						}
					},
					error:function(){ // 또는					 
						console.log("통신실패!");
					}
				});				
			<%}%>
		}
		
		function dosingo() { // 신고하기
			<%if (ologin == null) {%>
				loginView();
			<%} else {%>			
			var check = confirm("정말 신고하시겠습니까?");			
			if (check) {
				location.href = "PdsController?command=singo&seq=<%= pds.getSeq() %>";
			}
			<%}%>
		}
		
		function donosingo() { // 신고하기
			<%if (ologin == null) {%>
				loginView();
			<%} else {%>			
			var check = confirm("정말 신고취소하시겠습니까?");			
			if (check) {
				location.href = "PdsController?command=singono&seq=<%= pds.getSeq() %>";
			}
			<%}%>
		}
		
		function doDown(){ // 다운로드
			var downCount = parseInt($("#dCount").text().trim()); 
			$("#dCount").text(downCount+1);
			$("#imgDown").submit();
		}
		
		function deletePds() {
			var check = confirm("정말 삭제하시겠습니까?");			
			if (check) {
				location.href = "PdsController?command=delete&seq=<%= pds.getSeq() %>";
			}
		}
		
	</script>
	

</body>
</html>