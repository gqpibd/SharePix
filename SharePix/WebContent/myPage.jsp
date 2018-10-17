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
<title>myPage.jsp</title>
<link rel="stylesheet" href="css/ksjTest.css">

</head>
<body>
<%
Object ologin = session.getAttribute("login");
MemberBean mem = null;
PdsBean pds = null;

mem = (MemberBean)ologin;
PdsService pdsService = PdsService.getInstance();
pds = pdsService.getMyPdsAll(mem.getId());
List<PdsBean> list = pdsService.getMyPdsAllList(mem.getId());
int totalDownCount = 0;
int totalLikeCount = 0; 
int totalReplyCount = 0;
int totalReadCount = 0;
if(list == null){
	System.out.println("list null");
}
for (int i = 0; i < list.size(); i++) {
	PdsBean dto = list.get(i);	
	totalDownCount += dto.getDownCount();
	totalLikeCount += dto.getLikeCount();
	totalReplyCount += dto.getReplyCount();
	totalReadCount += dto.getReadCount();
}

//편의로 그냥 쓰고 있음(삭제예정)
if(pds == null){	
	%>
	<script type="text/javascript">
	alert("pds가 null");
	location.href = "./main.jsp";
	</script>
	<%
	return;
}
/////

%>
	<div class="left__heading" style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="myPage.jsp" />
		</jsp:include>
	</div>

	<div style="margin-top: 10em">
	<h2><%=mem.getName()%>의 myPage.jsp</h2>	<!-- 출력 확인 -->
	<img alt="" src="./image/<%=pds.getfSaveName()%>" style="width: 50px">프로필 사진<br>
	<h1 style="font-size:32px;padding-top:25px"><%=mem.getName()%></h1>
	
	 <div id="stats" style="max-height:22px;overflow:hidden;padding:0 15px">
	                
	    <span title="이미지"><i class="icon icon_images"></i><%=list.size()%></span>
	    
	    <span title="다운로드"><i class="icon icon_download"></i>다운 수 : <%=totalDownCount%></span>
	    <span title="좋아요"><i class="icon icon_like_filled"></i>좋아요 수 : <%=totalLikeCount%></span>
	    <span title="즐겨찾기"><i class="icon icon_favorite_filled"></i>(미구현)즐겨찾기 : 0</span>
	    <span title="댓글" class="hide-lg"><i class="icon icon_comment_filled"></i>댓글 달린 수 : <%=totalReplyCount%></span>
	    <span title="팔로워" class="hide-lg"><i class="icon icon_followers"></i>(미구현)팔로워 : 0</span>
	</div>

	업로드한 이미지 총 갯수 : <%=list.size()%><br>
	다운로드된 횟수 : <%=totalDownCount%><br> 
	좋아요 받은 수 : <%=totalLikeCount%><br>
	댓글 달린 수 : <%=totalReplyCount%><br>
	조회수 : <%=totalReadCount%><br>
	팔로워 수 : 팔로우 테이블<br>
	
	<form action="MemberController">
	<input type="hidden" name="command" value="userUpdatePage">
	<button type="submit">개인정보 수정</button>
	</form>
	
	</div>
</body>
</html>