<%@page import="model.service.MemberService"%>
<%@page import="dto.FollowDto"%>
<%@page import="model.service.PdsService"%>
<%@page import="java.util.List"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>userPage.jsp</title>

</head>
<body>
<%
	Object ologin = session.getAttribute("login");
	MemberBean loginMemDto = null;

 	loginMemDto = (MemberBean)ologin;// 세션에 담겨있던 로그인한 사람의 dto
 	
 	System.out.println("loginMemDto : " + loginMemDto.toString());

	String pageId = request.getParameter("id");	// 해당 유저 페이지의 유저 id 
	PdsService pdsService = PdsService.getInstance();
	PdsBean pagePds = pdsService.getMyPdsAll(pageId); // 해당 유저 페이지의 유저 id로 찾은 pdsDto
	
	MemberService memService = MemberService.getInstance();
	MemberBean pageMemDto = memService.getUserInfo(pageId);	//해당 페이지의 사용자 정보 가져온 memDto 
	List<PdsBean> list = pdsService.getMyPdsAllList(pageId); // 해당 페이지의 사용자 정보 list
	
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

	//	해당 유저를 구독한 사람의 수 : fList.size()	
	List<FollowDto> fList = memService.getMyFollowerList(pageId);
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
		
	// 페이지의 유저가 구독하는 사람 리스트 ( 비밀로 ? )
	List<FollowDto> sList = memService.getMySubscribeList(pageId);
	
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
	
	// 페이지의 유저가 좋아요한 리스트 ( 비밀로? )
	List<PdsBean> lList = pdsService.getMyLikeList(pageId);
	
	
	String follow = "images/icons/like_empty.png";
	boolean isFollow = false;
	isFollow = memService.checkMemFollow(loginMemDto.getId(), pageId);
	if (isFollow) {
		follow = "images/icons/like_fill.png";
	}
%>

<h2><%=pageMemDto.getName()%>의 userPage</h2>	<!-- 출력 확인 -->
<div align=left>
	<img src='images/profiles/<%=pageMemDto.getId()%>.png' width='100px'
		class='profile re-img' align='middle'
		onerror="this.src='images/profiles/default.png'"> 
	<span class="nickname"><%=pageMemDto.getId()%></span>
</div>
<br>
<button onclick="doFollow()" class="btn-follow"> <!-- 팔로우 버튼 -->
	<img id="followImg" src="<%=follow%>" width="15" id="follow">&nbsp;&nbsp; 
</button>
<input type="hidden" id="ajax_hidden"><br>


<span><img title="업로드한 사진 수" src="./images/icons/images.png" style="width: 15px">&nbsp;:&nbsp;<%=list.size()%></span>
&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="다운된 사진 수" src="./images/icons/download.png" style="width: 15px">&nbsp;:&nbsp;<%=totalDownCount%></span>
&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="좋아요 받은 수" src="./images/icons/like.png" style="width: 15px">&nbsp;:&nbsp;<%=totalLikeCount%></span>
&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="댓글 수" src="./images/icons/comment.png" style="width: 15px">&nbsp;:&nbsp;<%=totalReplyCount%> </span>
&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="조회 수" src="./images/icons/read.png" style="width: 15px">&nbsp;:&nbsp;<%=totalReadCount%> </span>
&nbsp;&nbsp;&nbsp;&nbsp;
<span><img title="팔로워의 수" src="./images/icons/star.png" style="width: 15px; height:auto">&nbsp;:&nbsp;<a href="javascript:goto()"><%=fList.size()%></a></span>
&nbsp;&nbsp;&nbsp;&nbsp;
<span class="ifNotMeHide">
<img title="<%=pageMemDto.getName()%>이(가) 좋아요한 사진 수" src="./images/icons/collection_empty.png" style="width: 15px">&nbsp;:&nbsp;<%=lList.size()%><br>
&nbsp;&nbsp;&nbsp;&nbsp; 
</span>
<%if(pageMemDto.getId().equals(loginMemDto.getId())){
	%>
	<form action="MemberController">
	<input type="hidden" name="command" value="userUpdatePage">
	<button type="submit">개인정보 수정</button>
	</form>
	<%
}%>
<span class="ifNotMeHide">
나를 구독한 사람들  : 
<%for (int i = 0; i < sList.size(); i++){
	FollowDto sDto = sList.get(i);
	%>
	<a href="MemberController?command=userPage&id=<%=sDto.getFollowerId()%>"><%=sDto.getFollowerId()%></a> ,
	<%
}%>
</span>
<br>
<%for (int i = 0; i < sList.size(); i++){
	FollowDto sDto = sList.get(i);
	%>
	<jsp:include page="./follow.jsp" flush="true">
	    <jsp:param name="id" value="<%=pagePds.getId()%>"/>
	</jsp:include>
	<%	
}%>

</body>

<script type="text/javascript">
var followChk = '<%=isFollow%>';
function doFollow(){ // 좋아요 눌렀을 때			
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

function goto() { // 
	
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