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
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<style type="text/css">
.img {
	cursor: pointer;
}

td {
	text-align: center;
}
</style>

<title>userPage.jsp</title>

</head>
<body>
<%
	Object ologin = session.getAttribute("login");
	MemberBean loginMemDto = null;
 	loginMemDto = (MemberBean)ologin;// 세션에 담겨있던 로그인한 사람의 dto
 	
 	System.out.println("loginMemDto : " + loginMemDto.toString());
	MemberService memService = MemberService.getInstance();
//	String pageId = request.getParameter("id");	// 해당 유저 페이지의 유저 id 
//	PdsService pdsService = PdsService.getInstance();
//	PdsBean pagePds = pdsService.getMyPdsAll(pageId); // 해당 유저 페이지의 유저 id로 찾은 pdsDto
//	
//	MemberBean pageMemDto = memService.getUserInfo(pageId);	//해당 페이지의 사용자 정보 가져온 memDto 
//	List<PdsBean> list = pdsService.getMyPdsAllList(pageId); // 해당 페이지의 사용자 정보 list

	String pageId = request.getParameter("id");	// 해당 유저 페이지의 유저 id                      
	                                                                              
	PdsBean pagePds 		= (PdsBean)request.getAttribute("pagePds");
	MemberBean pageMemDto	= (MemberBean)request.getAttribute("pageMemDto");
	List<PdsBean> list 		= (List<PdsBean>)request.getAttribute("list");      
	List<FollowDto> fList 	= (List<FollowDto>)request.getAttribute("fList");// 해당 페이지의 사용자를 팔로우 하는 사람 list
	List<FollowDto> sList 	= (List<FollowDto>)request.getAttribute("sList");// 페이지의 유저가 구독하는 사람 리스트
	List<PdsBean> lList 	= (List<PdsBean>)request.getAttribute("lList");// 페이지의 유저가 좋아요한 리스트
	
	if( pagePds == null || pageMemDto == null || list == null  || fList == null || sList == null || lList == null) {
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
	isFollow = memService.checkMemFollow(loginMemDto.getId(), pageId);
	if (isFollow) {
		follow = "images/icons/like_fill.png";
	}
%>

<h2><%=pageMemDto.getName()%>의 userPage</h2>	<!-- 출력 확인 -->
<!-- <div align=center> -->
<%if(pageMemDto.getId().equals(loginMemDto.getId())){
	%>
	<form action="MemberController">
		<input type="hidden" name="command" value="userUpdatePage">
		<button type="submit">개인정보 수정</button>
	</form>
	<%
}%>
<table border="1" align="center">
<tr>
<td>
	<img src='images/profiles/<%=pageMemDto.getId()%>.png' width='100px'
		class='profile re-img' align='middle'
		onerror="this.src='images/profiles/default.png'">
</td>
</tr>
<tr>
<td><span class="nickname"><%=pageMemDto.getId()%></span></td>
<tr>
<td>
<span><img title="업로드한 사진 수" src="./images/icons/images.png" style="width: 15px">&nbsp;:&nbsp;<%=list.size()%></span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="다운된 사진 수" src="./images/icons/download.png" style="width: 15px">&nbsp;:&nbsp;<%=totalDownCount%></span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="좋아요 받은 수" src="./images/icons/like.png" style="width: 15px">&nbsp;:&nbsp;<%=totalLikeCount%></span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="댓글 수" src="./images/icons/comment.png" style="width: 15px">&nbsp;:&nbsp;<%=totalReplyCount%> </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="조회 수" src="./images/icons/read.png" style="width: 15px">&nbsp;:&nbsp;<%=totalReadCount%> </span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="팔로워의 수" src="./images/icons/star.png" style="width: 15px; height:auto">&nbsp;:&nbsp;<%=fList.size()%></span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span class="ifNotMeHide">
<img title="<%=pageMemDto.getName()%>이(가) 좋아요한 사진 수" src="./images/icons/collection_empty.png" style="width: 15px">&nbsp;:&nbsp;<%=lList.size()%>&nbsp;&nbsp;</span><br>
</td>
</tr>
</table>
<div align="center">
<button onclick="doFollow()" class="btn-follow"> <!-- 팔로우 버튼 -->
	<img id="followImg" src="<%=follow%>" width="15" id="follow"> 
</button>
<input type="hidden" id="ajax_follow">
</div>
<!-- </div> -->

<%-- <span class="ifNotMeHide">
나를 구독한 사람들  : 
<%for (int i = 0; i < sList.size(); i++){
	FollowDto sDto = sList.get(i);
	%>
	<a href="MemberController?command=userPage&id=<%=sDto.getFollowerId()%>"><%=sDto.getFollowerId()%></a> ,
	<%
}%>
</span> --%>
<br>

<hr>
<div align="center">
<a href="javascript:gotoPds()">user가 올린 이미지</a>&nbsp;&nbsp;<a href="javascript:gotoSub()">나를 구독한 사람들</a>&nbsp;&nbsp;<a href="javascript:gotoLike()">내 컬렉션</a>
</div>
<hr>

	<div class="mcontainer userPds">
		<%
		String PATH = "images/";
		List<PdsBean> pdslist = null;
		if ((pdslist = (List<PdsBean>) request.getAttribute("list")) == null) {
			pdslist = PdsService.getInstance().getSearchPdsNull();
		}
		String like = "heart.png";
			for (PdsBean Pdscust : pdslist) {
				System.out.println(PATH + Pdscust.getfSaveName());
		%>
		<div class="item profilebox profilebox1">
			<img class="img" name="item"
				src="<%=PATH%>/pictures/<%=Pdscust.getfSaveName()%>"
				onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300">
			<div class="SocialIcons">
				<a> <img alt="" src="<%=PATH%>icons\\<%=like%>"
					onmouseover="this.src='<%=PATH%>icons\\fullheart.png'"
					onmouseout="this.src='<%=PATH%>icons\\<%=like%>'"
					onclick="doLike()" class="btn-like"> <label><%=Pdscust.getLikeCount()%></label>
				</a> <a href="#" style="text-decoration: none; color: white;"> <img
					alt="" src="<%=PATH%>icons\\openbook.png"
					onmouseover="this.src='<%=PATH%>icons\\fullopenbook.png'"
					onmouseout="this.src='<%=PATH%>icons\\openbook.png'"> <label><%=Pdscust.getReadCount()%></label>
				</a> <a href="#" style="text-decoration: none; color: white;"> <img
					alt="" src="<%=PATH%>icons\\contract.png"
					onmouseover="this.src='<%=PATH%>icons\\fullcontract.png'"
					onmouseout="this.src='<%=PATH%>icons\\contract.png'"> <label><%=Pdscust.getReplyCount()%></label>
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
			}
		%>
	</div>
<div class="userPds">
<%-- <jsp:include page="userPagePds.jsp" flush="true">
    <jsp:param name="id" value="<%=pagePds.getId()%>"/>
</jsp:include> --%>
</div>

<div class="userSub ifNotMeHide" style="display: none"> <!-- 불러오긴 하나 숨김 -->
	<jsp:include page="follow.jsp" flush="true">
		<jsp:param name="followeeId" value="<%=pagePds.getId()%>"/>
	</jsp:include>
</div>

	<div class="mcontainer userCollect" style="display: none">
		<%
		PATH = "images/";
		like = "heart.png";
			for (PdsBean Pdscust : lList) {
				System.out.println("내 컬렉션" + PATH + Pdscust.getfSaveName());
		%>
		<div class="item profilebox profilebox1">
			<img class="img" name="item"
				src="<%=PATH%>/pictures/<%=Pdscust.getfSaveName()%>"
				onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300">
			<div class="SocialIcons">
				<a> <img alt="" src="<%=PATH%>icons\\<%=like%>"
					onmouseover="this.src='<%=PATH%>icons\\fullheart.png'"
					onmouseout="this.src='<%=PATH%>icons\\<%=like%>'"
					onclick="doLike()" class="btn-like"> <label><%=Pdscust.getLikeCount()%></label>
				</a> <a href="#" style="text-decoration: none; color: white;"> <img
					alt="" src="<%=PATH%>icons\\openbook.png"
					onmouseover="this.src='<%=PATH%>icons\\fullopenbook.png'"
					onmouseout="this.src='<%=PATH%>icons\\openbook.png'"> <label><%=Pdscust.getReadCount()%></label>
				</a> <a href="#" style="text-decoration: none; color: white;"> <img
					alt="" src="<%=PATH%>icons\\contract.png"
					onmouseover="this.src='<%=PATH%>icons\\fullcontract.png'"
					onmouseout="this.src='<%=PATH%>icons\\contract.png'"> <label><%=Pdscust.getReplyCount()%></label>
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
			}
		%>
	</div>

</body>

<script type="text/javascript">
var followChk = '<%=isFollow%>';
function doFollow(){ // 팔로우 눌렀을 때			
	<%if (ologin == null) {%>
		alert("로그인해 주십시오");	
		location.href="index.jsp";
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
	$(".userSub").hide();
	$(".userCollect").attr('css', 'display: none');
	$(".userPds").show();	
}

function gotoSub() { // 
	$(".userPds").hide();	
	$(".userCollect").attr('css', 'display: none');
	$(".userSub").show();
}

function gotoLike(){
	$(".userPds").hide();
	$(".userSub").hide();
	$(".userCollect").removeAttr("style");
}

$(document).ready(function() {
    var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
    $(".mcontainer").rowGrid(options);
});
  
  
function veiwDetail(seq) {
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
// 이거 테스트하는 동안만 숨겨놓은 거라서 실제 사용시에는 주석 삭제해야 
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
 
</script>
</html>