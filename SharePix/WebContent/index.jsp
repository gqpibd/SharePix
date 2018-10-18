<%@page import="controller.FileController"%>
<%@page import="java.io.File"%>
<%@page import="dto.MemberBean"%>
<%@page import="model.service.PdsService"%> 
<%@page import="controller.PdsController"%>
<%@page import="java.util.List"%>
<%@page import="dto.PdsBean"%>
<%@page import="model.PdsManager"%>
<%@page import="model.iPdsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String PATH = "images/";
	List<PdsBean> pdslist = null;
	if ((pdslist = (List<PdsBean>) request.getAttribute("list")) == null) {
		pdslist = PdsService.getInstance().getSearchPdsNull();
	}
	System.out.println(pdslist.size());
	//PdsBean pdsLike = (PdsBean) request.getAttribute("pds");	
	String like = "heart.png";
	PdsService pService = PdsService.getInstance();
	// 아이디 확인하고 받아서 like 확인하고 이미지 넣기
	MemberBean ologin = (MemberBean) session.getAttribute("login");
	String id = "";
	if (ologin != null) {
		id = ologin.getId();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>SaGong</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<style type="text/css">
.img {
	cursor: pointer;
}
</style>
</head>
<body bgcolor="#D5D5D5">
	<div class="left__heading" style="height: 100%">
		<!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>
	
	<div class="mcontainer"  style="margin-top: 10em">
		<%
			for (PdsBean Pdscust : pdslist) {
				String fSavename = Pdscust.getfSaveName();
				String smallSrc = fSavename.substring(0,fSavename.lastIndexOf('.')) + "_small" + fSavename.substring(fSavename.lastIndexOf('.'));

				File f = new File(FileController.PATH + "\\" + Pdscust.getfSaveName());
			    if (f.exists()) {
			      long len = f.length();
			      System.out.println(len);
			      if(len<300000){ // 300kb 이하의 이미지는 그냥 원본을 가져온다
			    	  smallSrc = fSavename;
			      }
			    }			
		%>
		<div class="item profilebox profilebox1">
			<%-- <img class="img" name="item"
				src="<%=PATH%>pictures/<%=Pdscust.getfSaveName()%>"
				onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300"> --%>
			<img class="img" name="item" src="<%=PATH%>pictures/<%=smallSrc%>"  
				onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300" alt="이미지 못 찾음" >
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

	<script type="text/javascript">


	function doLike(){ // 좋아요 눌렀을 때			
		<%if (ologin == null) {%>
			alert("로그인해 주십시오");	
			location.href="index.jsp";
		<%} else {%>				
			$.ajax({
				url:"PdsController", // 접근대상
				type:"get",		// 데이터 전송 방식
				data:"command=likeChange&like="+like+"&id=<%=id%>&seq=", // 전송할 데이터
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
	
    $(document).ready(function() {
      var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
      $(".mcontainer").rowGrid(options);
    });
    
    
    function veiwDetail(seq) {
       console.log(seq);
       location.href="PdsController?command=detailview&seq=" + seq;
    }    

   </script>
</body>
</html>