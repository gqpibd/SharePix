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

	MemberService memService = MemberService.getInstance();

	String pageId = request.getParameter("id");	// 해당 유저 페이지의 유저 id                      
	                                                                              
	PdsBean pagePds 		= (PdsBean)request.getAttribute("pagePds");
	MemberBean pageMemDto	= (MemberBean)request.getAttribute("pageMemDto");
	List<PdsBean> list 		= (List<PdsBean>)request.getAttribute("list");      
	List<FollowDto> fList 	= (List<FollowDto>)request.getAttribute("fList");// 해당 페이지의 사용자를 팔로우 하는 사람 list
	List<FollowDto> sList 	= (List<FollowDto>)request.getAttribute("sList");// 페이지의 유저가 구독하는 사람 리스트
	List<PdsBean> lList 	= (List<PdsBean>)request.getAttribute("lList");// 페이지의 유저가 좋아요한 리스트 */
	
	if( pagePds == null || pageMemDto == null || list == null  || fList == null || sList == null  || lList == null ) {
		System.out.println("뭐가 됐든 null");
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
	
	String follow = "images/icons/like_empty.png";
	boolean isFollow = false;
	if(loginMemDto!=null){
		isFollow = memService.checkMemFollow(loginMemDto.getId(), pageId);
	}
	if (isFollow) {
		follow = "images/icons/like_fill.png";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="style/common.css">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua" rel="stylesheet">
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
<title></title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<link rel="shortcut icon" href="images/icons/favicon.ico">
</head>
<body>

	<div style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>

	<div style="margin-top: 8em">
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
	<tr><td style="height: 20px" align="center">
			<%if(loginMemDto != null && pageMemDto.getId().equals(loginMemDto.getId())){
			%>
			<img class="clickable" style="width: 40px; position: relative; bottom: 40px; left: 100px;" title="개인정보 수정" alt="" src="./images/icons/edit.png" onclick="location.href='MemberController?command=userUpdatePage'">
			
			<%
			}%>
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
		<span class="ifNotMeHide">
		<img title="<%=pageMemDto.getName()%>이(가) 좋아요한 사진 수" src="./images/icons/collection_empty.png" style="width: 25px">&nbsp;:&nbsp;<%=lList.size()%>&nbsp;&nbsp;</span>	
		</td>
	</tr>
	</table>
	
	<% if (ologin == null) { %> <!-- 로그인 하지 않았을 때 -->
		<div align="center">
		<button onclick="loginView()"> <!-- 팔로우 버튼 -->
			<img id="followImg" src="<%=follow%>" width="15"> 
		</button>
		<input type="hidden" id="ajax_follow">
		</div>
	<%} else if(loginMemDto != null && !pageMemDto.getId().equals(loginMemDto.getId())) {
		%>
		<div align="center">
		<button onclick="doFollow()"> <!-- 팔로우 버튼 -->
			<img id="followImg" src="<%=follow%>" width="15"> 
		</button>
		<input type="hidden" id="ajax_follow">
		</div>
		<%
	}%>
</div>
	<br>
	
	<hr>
	<div align="center">
	<a href="javascript:gotoPds()"><%=pageMemDto.getId()%>가 올린 이미지</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:gotoSub()">나를 구독한 사람들</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:gotoLike()">내 컬렉션</a>
	</div>
	<hr>	
	
	
	<div class="mcontainer" id="userPds">
		<%
		String PATH = "images/";
		List<PdsBean> pdslist = null;
		if ((pdslist = (List<PdsBean>) request.getAttribute("list")) == null) {
			pdslist = PdsService.getInstance().getSearchPdsNull();
		}
		String like = "heart.png";
		String reverslike = "fullheart.png";
		for (PdsBean Pdscust : pdslist) {
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
				<a style="text-decoration: none; color: white;">
					<img class="clickable" id="like_<%=Pdscust.getSeq()%>" alt="" src="<%=PATH%>icons\\<%=like%>"
					onmouseover="this.src='<%=PATH%>icons\\<%=reverslike %>'"
					onmouseout="this.src='<%=PATH%>icons\\<%=like%>'"
					onclick="doLike('<%=Pdscust.getSeq()%>', this)"
					style="vertical-align: middle; width: 40%; height: auto;" > 
					<p id ="likeCount_<%=Pdscust.getSeq()%>"><%=Pdscust.getLikeCount()%></p>
				</a><a href="#" style="text-decoration: none; color: white;"> 
					<img alt="" src="<%=PATH%>icons\\downloadC.png"
					onmouseover="this.src='<%=PATH%>icons\\fulldownloadC.png'"
					onmouseout="this.src='<%=PATH%>icons\\downloadC.png'"
					style="vertical-align: middle; width: 40%; height: auto;" > 
					<p><%=Pdscust.getDownCount()%></p>
				</a> <a href="#" style="text-decoration: none; color: white;"> 
					<img alt="" src="<%=PATH%>icons\\contract.png"
					onmouseover="this.src='<%=PATH%>icons\\fullcontract.png'"
					onmouseout="this.src='<%=PATH%>icons\\contract.png'"
					style="vertical-align: middle; width: 40%; height: auto;" > 
					<p><%=Pdscust.getReplyCount()%></p>
			</div>
			<div class="profileInfo">
				<h3>
					<a href="MemberController?command=userPage&id=<%=Pdscust.getId()%>"
						style="text-decoration: none; color: white;"><%=Pdscust.getId()%></a>
				</h3>
			</div>
		</div> 
		<%
			}
		%>
	</div> 
	
	<div id="userSub" class="ifNotMeHide" style="display: none"> <!-- 불러오긴 하나 숨김 -->
		<jsp:include page="follow.jsp" flush="true">
			<jsp:param name="followeeId" value="${pagePds.id }"/>
		</jsp:include>
	</div>
	
		<div id="userCollect">
			<jsp:include page="imageGrid.jsp" flush="true">
				<jsp:param name="command" value="favorites" />
				<jsp:param name="id" value="${pageMemDto.id }"/>
			</jsp:include>
		</div>
	</div>
</body>

<script type="text/javascript">
window.onload = function () {
	gotoPds();
}

var followChk = '<%=isFollow%>';
function doFollow(){ // 팔로우 눌렀을 때			
	<%if (ologin == null) {%>
		alert("로그인해 주십시오");
		loginView();
	<%} else {%>				
		$.ajax({
			url:"MemberController", // 접근대상
			type:"get",		// 데이터 전송 방식
			data:"command=follow&followeeId=" + <%=pageMemDto.getId()%> + "&followerId=<%=loginMemDto.getId()%>" +"&followChk=" + followChk, // 전송할 데이터
			success:function(data, status, xhr){
				/* console.log(data); */
				
				followChk = $("#ajax_follow").html(data).find("followChk").text();
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
function gotoPds(){
	$("#userSub").hide();
	$("#userCollect").hide();
	$("#userPds").show();	
}

function gotoSub() { 
	$("#userPds").hide();	
	$("#userCollect").hide();
	$("#userSub").show();
}

function gotoLike(){
	$("#userPds").hide();
	$("#userSub").hide();
	$("#userCollect").show();
	$("#userCollect").css("visibility","visible");
}

function veiwDetail(seq) { // 사진 상세 페이지로 이동
   console.log(seq);
   location.href="PdsController?command=detailview&seq=" + seq;
}     	

function doLike(){ // 좋아요 눌렀을 때			
<%if (ologin == null) {%>
	alert("로그인해 주십시오");	
	location.href="index.jsp";
<%} else {%>				
	$.ajax({
		url:"PdsController", // 접근대상
		type:"get",		// 데이터 전송 방식
		data:"command=likeChange&like="+like+"&id=<%=pageMemDto.getId()%>&seq=", // 전송할 데이터
		success:function(data, status, xhr){
			/* console.log(data); */
			like = $("#ajax_hidden").html(data).find("like").text();
			var count = $("#ajax_hidden").html(data).find("count").text();
			if(like == "false"){
				$("#like").attr("src",'<%=PATH%>icons\\heart.png');
				$("#likeCount").text(count);
			}else{
				$("#like").attr("src",'<%=PATH%>icons\\fullheart.png');
				$("#likeCount").text(count);
			}
		},
		error:function(){ // 또는					 
			console.log("통신실패!");
		}
	});				
<%}%>
}
<%--
// 이거 테스트하는 동안만 숨겨놓은 거라서 실제 사용시에는 주석 삭제해야 (미수정)
//로그인한 id 와  유저페이지의 id 가 다를 때 숨기는 코드
$(function () {
	$(document).ready(function () {
		var loginIdStr = '<%=loginMemDto.getId()%>';
		var pageIdStr = '<%=pageMemDto.getId()%>';
		if(loginIdStr != pageIdStr){	// 로그인한 id 와  유저페이지의 id 가 다를 때
			alert("야호");
			$(".ifNotMeHide").hide();	// 클래스로 한번에 숨기려고
		}
	});
});
 --%>
 $(document).ready(function() {
		$.noConflict();
		var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
		$(".mcontainer").rowGrid(options);		
	});
</script>

</html>