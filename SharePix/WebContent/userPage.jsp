<%@page import="model.service.MemberService"%>
<%@page import="dto.FollowDto"%>
<%@page import="model.service.PdsService"%>
<%@page import="java.util.List"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object ologin = session.getAttribute("login");
	MemberBean loginMemDto = null;

 	loginMemDto = (MemberBean)ologin;// 세션에 담겨있던 로그인한 사람의 dto
 	if(loginMemDto != null){
 		System.out.println("loginMemDto : " + loginMemDto.toString());
 	}

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

	// 프로필 사진
	/* 아직 회원가입이 안 합쳐져 있어서 일단 미구현

	String fname = "";
	if(pds.getfSaveName() == null || pds.getfSaveName() == ""){
		fname = "default.png";
	} else {
		fname = pds.getfSaveName();
	}
	System.out.println("fname = " + fname);
	*/

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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>userPage.jsp</title>

</head>
<body>

<%
String follow = "images/icons/like_empty.png";
boolean isFollow = false;
if(loginMemDto!=null){
	isFollow = memService.checkMemFollow(loginMemDto.getId(), pageId);
}
if (isFollow) {
	follow = "images/icons/like_fill.png";
}
%>

<h2><%=pageMemDto.getName()%>의 userPage</h2>	<!-- 출력 확인 -->
<img alt="" src="./images/profiles/default.png" style="width: 50px">프로필 사진<br>
<h1 style="font-size:32px;padding-top:25px"><%=pageMemDto.getName()%></h1>
<br>
<button onclick="doFollow()" class="btn-follow"> <!-- 팔로우 버튼 -->
	<img id="followImg" src="<%=follow%>" width="15" id="follow">&nbsp;&nbsp; 
</button>
<input type="hidden" id="ajax_hidden">

<%-- 참고하려고 아직 안 지웠
<div id="stats" style="max-height:22px;overflow:hidden;padding:0 15px">
    <span title="이미지"><i class="icon icon_images">이미지 수 : <%=list.size()%></i></span>
    <span title="다운로드"><i class="icon icon_download">다운 수 : <%=totalDownCount%></i></span>
    <span title="좋아요"><i class="icon icon_like_filled">좋아요 수 : <%=totalLikeCount%></i></span>
    <span title="댓글" class="hide-lg"><i class="icon icon_comment_filled">댓글 달린 수 : <%=totalReplyCount%></i></span>
    <span title="즐겨찾기"><i class="icon icon_favorite_filled">즐겨찾기 수 : <%=lList.size()%></i></span>
    <span title="팔로워" class="hide-lg"><i class="icon icon_followers">나의팔로워  수: <%=fList.size()%></i></span><br>
    	내가 구독한 사람의 수 : <%=sList.size()%>
</div>
 --%>
업로드한 이미지 총 갯수 : <%=list.size()%><br>
다운로드된 횟수 : <%=totalDownCount%><br> 
좋아요 받은 수 : <%=totalLikeCount%><br>
댓글 달린 수 : <%=totalReplyCount%><br>
조회수 : <%=totalReadCount%><br>
나를 팔로우하는 사람의 수 : <%=fList.size()%><br>
내가 좋아요한 글 수 : <%=lList.size()%><br> 
<%if(loginMemDto!=null && pageMemDto.getId().equals(loginMemDto.getId())){
	%>
	<form action="MemberController">
	<input type="hidden" name="command" value="userUpdatePage">
	<button type="submit">개인정보 수정</button>
	</form>
	<%
}%>

<%for (int i = 0; i < sList.size(); i++){
	FollowDto sDto = sList.get(i);
	%>
	나를 구독한 사람들 : <a href="MemberController?command=userPage&id=<%=sDto.getFollowerId()%>"><%=sDto.getFollowerId()%></a><br>
	<%
}%>
</body>

<script type="text/javascript">
var followChk = '<%=isFollow%>';
function doFollow(){ // 좋아요 눌렀을 때			
	<%if (ologin == null) {%>
		alert("로그인해 주십시오");
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
</script>
</html>