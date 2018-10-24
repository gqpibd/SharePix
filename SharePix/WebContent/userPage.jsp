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
	MemberBean loginMemDto = (MemberBean)session.getAttribute("login");// 세션에 담겨있던 로그인한 사람의 dto

	MemberService memService = MemberService.getInstance();

	String pageId = request.getParameter("id");	// 해당 유저 페이지의 유저 id                      
	                                                                   
	MemberBean pageMemDto	= (MemberBean)request.getAttribute("pageMemDto");
	List<PdsBean> list 		= (List<PdsBean>)request.getAttribute("list"); // 내가 올린 게시글 list     
	List<FollowDto> fList 	= (List<FollowDto>)request.getAttribute("fList");// 해당 페이지의 사용자를 팔로우 하는 사람 list
	List<FollowDto> sList 	= (List<FollowDto>)request.getAttribute("sList");// 페이지의 유저를 구독하는 사람 리스트
	List<PdsBean> lList 	= (List<PdsBean>)request.getAttribute("lList");// 페이지의 유저가 좋아요한 리스트 */
	
	if( pageMemDto == null || list == null  || fList == null || sList == null  || lList == null ) {
		System.out.println(" 유저 페이지 뭐가 됐든 null");
	} else {
		System.out.println("아무것도 null 아님");
	}
	
	/* System.out.println("pageMemDto.toString() : " + pageMemDto.toString()); */
	
	int totalDownCount = 0;	//	다운수 총합
	int totalLikeCount = 0; 
	int totalReplyCount = 0;
	int totalReadCount = 0;
	
	for (int i = 0; i < list.size(); i++) {
		PdsBean dto = list.get(i);
		totalDownCount += dto.getDownCount();
		totalLikeCount += dto.getLikeCount();
		totalReplyCount += dto.getReplyCount();
		totalReadCount += dto.getReadCount();
	}
	
	String fListName = "";	
	
	for (int i = 0; i < fList.size(); i++) {
		FollowDto dto = fList.get(i);
		if(dto != null){
			fListName += dto.getFollowerId() + " / "; 
		} 
	}
	 
	if(fList.size()==0){
		fListName = "나를 구독한 사람이 없습니다.";
	}
	
	String sListName = "";
	
	for (int i = 0; i < sList.size(); i++) {
		FollowDto dto = sList.get(i);
		if(dto != null){
			sListName += dto.getFolloweeId() + " / "; 
		} 
	}
	 
	if(sList.size()==0){
		sListName = "내가 구독한 사람이 없습니다.";
	}
	
	String follow = "images/icons/follower_empty.png";
	boolean isFollow = false;
	if(loginMemDto!=null){
		isFollow = memService.checkMemFollow(loginMemDto.getId(), pageId);
	}
	if (isFollow) {
		follow = "images/icons/following.png";
	}
	
	String whom = pageMemDto.getId();
	String who = pageMemDto.getId();
	if(loginMemDto != null && pageMemDto.getId().equals(loginMemDto.getId())){
		whom = "나";		
		who = "내";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<link rel="shortcut icon" href="images/icons/favicon.ico">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua">
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
.mybtn:focus{
	outline: none;
}
.tabs{
 	margin: 0;
    padding: 0;
    list-style: none;
    height: 32px;
    width: 100%;
    font-size:15px;
    
    text-align:center;
    cursor: pointer;
    height: 30px;
    line-height: 30px;
    font-weight: bold;
    overflow: hidden;
    position: relative;
/*     font-family: 'Nanum Gothic', sans-serif; */
    
}

.tab-box{
	margin: 0 auto 0 auto;
	width: 100%;
}

a:visited{
	text-decoration: none;
}

.tab-box li{
	float:left;
	width: auto;
	height:30px;      
	line-height:30px;          /* 중앙정렬 */
	text-align: center;
	/* border-radius:3px 3px 0 0; */
	cursor: pointer;
	font-family: 'Nanum Gothic', sans-serif;
}

.tab-box li.selected{
	background-color: #ccc;
	border-spacing: 100px 100px 20px 20px;
	border-top: 1px solid blue;
	border-bottom: 2px solid blue;
	text-decoration: none;
}

</style>
<title>유저 페이지</title>

</head>
<body>
	<div style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="MemberController?command=userPage&id=${pageMemDto.id}" />
		</jsp:include>
	</div>

	<div style="margin-top: 8em"></div>
	<!-- <div align=center> -->
	<!-- background-color: #92A8D1;  -->
	<div style="padding: 50px; padding-top: 50px; padding-bottom: 50px; background: linear-gradient(to bottom, #92A8D1, white)">
	<table align="center" style="margin-bottom: 10px" > <!-- border="1" -->
	<tr>
		<td class="td" align="center" style="height: 100px">
		<span class="nickname" style="font-size:3em; font-family:Malgun Gothic;"><%=pageMemDto.getName()%></span>
	</tr>
	<tr>
		<td class="td">
		<span>
			<img src='images/profiles/<%=pageMemDto.getId()%>.png' width='100px'
				class='profile' align='middle'
				onerror="this.src='images/profiles/default.png'">
		</span>
		</td>
	</tr>
	<tr>
		<td style="height: 20px" align="center">
			<%if(loginMemDto != null && pageMemDto.getId().equals(loginMemDto.getId())){%>
				<img class="clickable" style="width: 40px; position: relative; bottom: 40px; left: 100px;" title="개인정보 수정" alt="" src="./images/icons/edit.png" onclick="location.href='MemberController?command=userUpdatePage'">
			<%}%>
		</td>
	</tr>
	<tr>
		<td class="td">
		<span><img title="업로드한 사진 수" src="./images/icons/images.png" style="width: 25px">&nbsp;:&nbsp;<%=list.size()%></span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span><img title="다운된 사진 수" src="./images/icons/download.png" style="width: 25px">&nbsp;:&nbsp;<%=totalDownCount%></span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span><img title="좋아요 받은 수" src="./images/icons/good.png" style="width: 25px">&nbsp;:&nbsp;<%=totalLikeCount%></span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span><img title="댓글 수" src="./images/icons/comment.png" style="width: 25px">&nbsp;:&nbsp;<%=totalReplyCount%> </span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span><img title="조회 수" src="./images/icons/read.png" style="width: 25px">&nbsp;:&nbsp;<%=totalReadCount%> </span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span><img title="팔로워의 수" src="./images/icons/many_follower.png" style="width: 40px; height:auto">&nbsp;:&nbsp;<%=fList.size()%></span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span>
		<img title="<%=pageMemDto.getName()%>이(가) 좋아요한 사진 수" src="./images/icons/collection_empty.png" style="width: 25px">&nbsp;:&nbsp;<%=lList.size()%>&nbsp;&nbsp;</span>	
		</td>
	</tr>
	</table>
	
	<% if (loginMemDto == null) { %> <!-- 로그인 하지 않았을 때 -->
		<div align="center">
		<button onclick="loginView()" class="mybtn" > <!-- 팔로우 버튼 -->
			<img  id="followImg" src="<%=follow%>" width="20"> 
			&nbsp;&nbsp;팔로우
		</button>
		<input type="hidden" id="ajax_follow">
		</div>
	<%} else if(loginMemDto != null && !pageMemDto.getId().equals(loginMemDto.getId())) {
		%>
		<div align="center">
		<button id="follow_Btn" class="mybtn" onclick="javascript:doFollow()"> <!-- 팔로우 버튼 -->
			<img id="followImg" src="<%=follow%>" width="20">
			&nbsp;&nbsp;팔로우
		</button>
		<input type="hidden" id="ajax_follow">
		</div>
		<%
	}%>
</div>
	<br>
	
	<hr>
	<div class="tab-box" align="center">
		<ul class="ul_cls" style="text-align:center; list-style:none; display: inline-block;" ><br>
		<li id="li1">&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:gotoPds()" class="tabs"><%=who%>가 올린 이미지</a>&nbsp;&nbsp;&nbsp;&nbsp;</li>
		<%	
			if(loginMemDto != null && pageMemDto.getId().equals(loginMemDto.getId())){				
		%>	
			<li id="li2">&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:gotoMyFollow()" class="tabs" >내가 구독한 사람들</a>&nbsp;&nbsp;&nbsp;&nbsp;</li>
		<%}%>
		<li id="li3">&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:gotoSub()" class="tabs" ><%=whom %>를 구독한 사람들</a>&nbsp;&nbsp;&nbsp;&nbsp;</li>
		<li id="li4">&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:gotoLike()" class="tabs" ><%=who%>가 좋아요한 사진들</a>&nbsp;&nbsp;&nbsp;&nbsp;</li>
		</ul>
	</div>
	<hr>	
	
	<!-- 내가 올린 사진들 -->	
	<div class="mcontainer" id="userPds">
		<%
		if(list.size() == 0){ // 게시글이 없는 경우
			if(pageId.equals(loginMemDto.getId())){ // 다른사람 정보보기 일 때
		%>
			<h2 class="noNews">아직 게시글이 없네요. 사진을 올려주실래요?</h2>
			<h2 class="noNews" ><button class="fill sagongBtn" onclick="location.href='pdswrite.jsp'">사진 올리기</button></h2>		
		<%}else{ // 내 정보 보기 일 때
		%>
			<h2 class="noNews">게시글이 없습니다</h2>
		<%
		  }
		}else{	
		String PATH = "images/";		
		String like = "heart.png";
		String reverslike = "fullheart.png";
		for (PdsBean Pdscust : list) {
			String fSavename = Pdscust.getfSaveName();
			String smallSrc = fSavename.substring(0,fSavename.lastIndexOf('.')) + "_small" + fSavename.substring(fSavename.lastIndexOf('.'));
			File f = new File(config.getServletContext().getRealPath("/images/pictures") + "\\" +  fSavename);
			 if (f.exists() && f.length()<300000) { // 300kb 이하의 이미지는 그냥 원본을 가져온다
		    	  smallSrc = fSavename;			     
		    }
			 
		%>
		<div class="item profilebox profilebox1">
			<img class="img" name="item" src="<%=PATH%>pictures/<%=smallSrc%>"  
				onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300" onerror="$(this).parent().remove()"
				style="cursor: pointer">
			<div class="SocialIcons">
				<a style="text-decoration: none; color: white;"> <img
					class="clickable" id="like_<%=Pdscust.getSeq()%>" alt=""
					src="<%=PATH%>icons\\<%=like%>"
					onmouseover="this.src='<%=PATH%>icons\\<%=reverslike %>'"
					onmouseout="this.src='<%=PATH%>icons\\<%=like%>'"
					onclick="doLike('<%=Pdscust.getSeq()%>', this)"
					style="vertical-align: middle; width: 40%; height: auto;">
					<p id="likeCount_<%=Pdscust.getSeq()%>"><%=Pdscust.getLikeCount()%></p>
				</a><a style="text-decoration: none; color: white;"> 
					<img src="<%=PATH%>icons\\downloadC.png"
					class="clickable" onmouseover="this.src='<%=PATH%>icons\\fulldownloadC.png'"
					onmouseout="this.src='<%=PATH%>icons\\downloadC.png'"
					style="vertical-align: middle; width: 40%; height: auto;" 
					onclick="doDown(this,'<%=Pdscust.getSeq()%>','<%=Pdscust.getfSaveName()%>','<%=Pdscust.getFileName()%>')">
					<p><%=Pdscust.getDownCount()%></p>
				</a> <a style="text-decoration: none; color: white;"> <img alt=""
					src="<%=PATH%>icons\\contract.png"
					class="clickable" onmouseover="this.src='<%=PATH%>icons\\fullcontract.png'"
					onmouseout="this.src='<%=PATH%>icons\\contract.png'"
					style="vertical-align: middle; width: 40%; height: auto;"
					onclick="veiwDetail(<%=Pdscust.getSeq()%>)" >
					<p><%=Pdscust.getReplyCount()%></p>
				</a>
			</div>
			<div class="profileInfo">
				<h3>
					<a href="MemberController?command=userPage&id=<%=Pdscust.getId()%>"
						style="text-decoration: none; color: white;"><%=Pdscust.getId()%></a>
				</h3>
			</div>
		</div> 
		<%
			}// for문 끝
		} // else문 끝
		%>
	</div> 
	
	<div align="center" id="userSub"> <!-- 나를 구독하는 사람들. 불러오긴 하나 숨김 -->
		<jsp:include page="follow.jsp" flush="true">
			<jsp:param name="followeeId" value="${pageMemDto.id }"/>
		</jsp:include>
	</div>
	
	<div id="userCollect"> <!-- 컬렉션 -->
	<%
	if(lList.size() == 0){ // 게시글이 없는 경우
		if(pageId.equals(loginMemDto.getId())){ // 내 정보 보기 일 때
	%>
		<br>
		<h2 class="noNews">와! 여긴 먼지 하나 없네요!</h2>
		<h2 class="noNews">좋아하는 사진을 찾아 봐요!</h2>			
	<%}else{ // 다른사람 정보보기 일 때
	%>	
		<br>
		<h2 class="noNews">맘에 드는 사진이 없나봐요</h2>		
	<%}
	}else{%>
		<jsp:include page="imageGrid.jsp" flush="true">
			<jsp:param name="command" value="favorites" />
			<jsp:param name="id" value="${pageMemDto.id }"/>
		</jsp:include>
	<%} %>
	</div>
	<%if(loginMemDto != null && pageMemDto.getId().equals(loginMemDto.getId())){%>
	<div align="center" id="userFollowing"> <!-- 내가 구독하는 사람들 -->
		<jsp:include page="myFollowing.jsp" flush="true">
			<jsp:param name="pageId" value="${pageMemDto.id }"/>
		</jsp:include>
	</div>
	<%} %>
	
</body>

<script type="text/javascript">
window.onload = function () {
	gotoPds();
}

var followChk = '<%=isFollow%>';
function doFollow(){ // 팔로우 눌렀을 때			
	<%if (loginMemDto == null) {%>
		loginView();
	<%} else {%>				
		$.ajax({
			url:"MemberController", // 접근대상
			type:"get",		// 데이터 전송 방식
			data:"command=follow&followeeId=<%=pageMemDto.getId()%>&followerId=<%=loginMemDto.getId()%>&followChk=" + followChk, // 전송할 데이터
			success:function(data, status, xhr){
				/* console.log(data); */
				followChk = $("#ajax_follow").html(data).find("followChk").text();
				if(followChk == "false"){
					$("#followImg").attr("src",'images/icons/follower_empty.png');
				}else{
					$("#followImg").attr("src",'images/icons/following.png');
				}
			},
			error:function(){ // 또는					 
				console.log("통신실패!");
			}
		});				
	<%}%>
}
function gotoPds(){
	$("#userSub").hide();
	$("#userCollect").hide();
	$("#userFollowing").hide();
	$("#userPds").show();	
	$("#li2").removeClass("selected");
	$("#li3").removeClass("selected");
	$("#li4").removeClass("selected");
	$("#li1").addClass("selected");
}

function gotoSub() { 
	$("#userPds").hide();	
	$("#userCollect").hide();
	$("#userFollowing").hide();
	$("#userSub").show();
	$("#li1").removeClass("selected");
	$("#li2").removeClass("selected");
	$("#li4").removeClass("selected");
	$("#li3").addClass("selected");
}

function gotoLike(){
	$("#userPds").hide();
	$("#userSub").hide();
	$("#userFollowing").hide();
	$("#userCollect").show();
	$("#li1").removeClass("selected");
	$("#li2").removeClass("selected");
	$("#li3").removeClass("selected");
	$("#li4").addClass("selected");
	//$("#userCollect").css("visibility","visible");
}

function gotoMyFollow() {
	$("#userPds").hide();	
	$("#userCollect").hide();
	$("#userSub").hide();
	$("#userFollowing").show();
	$("#li1").removeClass("selected");
	$("#li3").removeClass("selected");
	$("#li4").removeClass("selected");
	$("#li2").addClass("selected");
}

function veiwDetail(seq) { // 사진 상세 페이지로 이동
   console.log(seq);
   location.href="PdsController?command=detailview&seq=" + seq;
}     	

function doLike(seq1, item){ // 좋아요 눌렀을 때			
	<%if (loginMemDto == null) {%>
		loginView();
	<%} else {%> 
	 console.log(seq1);
	 var selector2 = "#likeCount_" + seq1;
		$.ajax({
			url:"PdsController", // 접근대상
			type:"get",		// 데이터 전송 방식
			data:"command=likeChange&id=<%=loginMemDto.getId()%>&seq="+seq1, // 전송할 데이터
			success:function(data, status, xhr){
				var like = $(item).html(data).find("like").text();
				var count = $(item).html(data).find("count").text();
				if(like == "false"){
					$(item).attr("src",'images/icons/heart.png');
					$(item).attr("onmouseover","this.src='images/icons/fullheart.png'");
					$(item).attr("onmouseout","this.src='images/icons/heart.png'");
					$(selector2).text(count);
				}else{
					$(item).attr("src",'images/icons/fullheart.png');
					$(item).attr("onmouseover","this.src='images/icons/heart.png'");
					$(item).attr("onmouseout","this.src='images/icons/fullheart.png'");
					$(selector2).text(count);
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
		$(".mcontainer").rowGrid(options);		
	});
 	
 	function doDown(item, seq, fsavename, filename) {
 		location.href = "FileController?command=download&rate=100&pdsSeq=" + seq
 				+ "&fsavename=" + fsavename + "&filename=" + filename;
 		var dCount = parseInt($(item).siblings().text());
 		$(item).siblings().text(dCount + 1);
 	}
 	
	</script>

</html>