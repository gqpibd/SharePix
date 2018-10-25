<%@page import="java.util.Iterator"%>
<%@page import="utils.CollenctionUtil"%>
<%@page import="java.util.HashMap"%>
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
	//String PATH = config.getServletContext().getRealPath("images") + "/";
	List<PdsBean> pdslist = null;
	if ((pdslist = (List<PdsBean>) request.getAttribute("list")) == null) {
		pdslist = PdsService.getInstance().getSearchPdsNull();
	}
	System.out.println(pdslist.size());
	HashMap<String,Integer> tagMap = CollenctionUtil.getHashMap(PdsService.getInstance().getSearchPds(""));	
	Iterator<String> it = CollenctionUtil.sortByValue(tagMap).iterator();
	PdsService pService = PdsService.getInstance();
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
<title>SaGong'sa</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<script src="js/imgGridFunction.js"></script>

<link rel="stylesheet" href="style/imageArrange.css">
<link rel="stylesheet" href="style/common.css">
<link rel="stylesheet" href="style/mainfooter.css">
<link rel="shortcut icon" href="images/icons/favicon.ico">
<!-- <link rel="shortcut icon" href="images/icons/favicon1.jpg"> -->
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua" rel="stylesheet">

</head>
<body bgcolor="#D5D5D5">
	<div class="left__heading" style="height: 100%">
		<!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="main.jsp" />
		</jsp:include>
	</div>
	<div style="margin-top: 9em"></div>
	<!-- 태그 출력 부분 -->
	<div class="container" id="tags" align="center">
		<%
	if(it!=null){
	int iter = 0; // 지금 위치가 몇 번째인지 갯수를 세자
	int size = 30; // 글자 크기
	int prevCount = -1; // 이전 갯수
	int currCount = -1; // 현재 갯수
	while(it.hasNext()) {
		String temp = (String) it.next();        
	    currCount = tagMap.get(temp);
		//System.out.println(temp + " : " + currCount); 확인용 출력
	    if(prevCount != -1 && prevCount > currCount){	    	
			size = size-3;
			if(size < 13){
				size=13;
			}
	    }
	    if(iter<10){
	%>
		<span class="tag"
			onclick="location.href='PdsController?command=keyword&choice=SEQ&tags=<%=temp%>'"
			style="font-size: <%=size%>px ">#<%=temp%></span>
		<%}else{%>
		<span class="tag" name="more"
			onclick="location.href='PdsController?command=keyword&choice=SEQ&tags=<%=temp%>'"
			style="font-size: <%=size%>px ">#<%=temp%></span>
		<%
		}
		prevCount=tagMap.get(temp);
		iter++;
		if(iter>20){ // 20개 까지만 보여줌
		 	break;
		}
	}}%>
	</div>

	<!-- 이미지 출력 부분 -->
	<div class="mcontainer">
		<%
		for (PdsBean Pdscust : pdslist) {
			String fSavename = Pdscust.getfSaveName();
			String smallSrc = fSavename.substring(0,fSavename.lastIndexOf('.')) + "_small" + fSavename.substring(fSavename.lastIndexOf('.'));

			File f = new File(config.getServletContext().getRealPath("/images/pictures") + "\\" + Pdscust.getfSaveName());
		    if (f.exists() && f.length()<300000) { // 300kb 이하의 이미지는 그냥 원본을 가져온다
		    	  smallSrc = fSavename;
		      	  System.out.println(smallSrc);
		    }	    
		    
		    boolean isLike = false;
			String like = "heart.png";
			String reverslike = "fullheart.png";
			if (ologin != null) {
				id = ologin.getId();
				int seq = Pdscust.getSeq();
				pService = PdsService.getInstance();
				isLike = pService.checkPdsLike(id, seq);
				if (isLike) {
					like = "fullheart.png";
					reverslike = "heart.png";
				}
			}
		%>
		<div class="item profilebox profilebox1">
			<img class="clickable" name="item"
				src="<%=PATH%>pictures/<%=smallSrc%>"
				onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300"
				onerror="$(this).parent().remove()">
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
			}
		%>
	</div>
	


	<div class="window1">
		<form action="PdsController?" method="get">
			<input type="hidden" name="nowPage" value="2"> 
			<input type="hidden" name="command" value="keyword"> 
			<input type="hidden" name="tags" value="">
			<input type="hidden" name="choice" value="LIKECOUNT">
			<button class="btn22" type="submit">더보기</button>
		</form>
	</div>
	
<section class="footer">
		<div class="footer_wrap">
			<div class="total_count">
				개인, 기업 누구나 쓸 수 있는 상업용 무료이미지 사진공유사이트				
				<span>사공사의 모든 이미지는 저작권 걱정없이 다운로드 및 수정, 배포할 수 있으며 상업적 용도로 어디에나 자유롭게 사용할 수 있습니다</span>
			</div>
			 <div class="f_menu">
	 				<span class="octolab"><strong>Sagong</strong> Inc.</span>

			</div>
		</div>
	</section>
	
	<div class="move"  style="position:fixed;display:none;bottom:0;padding-right:10px;padding-bottom:5px; right: 0px">
		<span id="top_move" style="float:right;">
			<img alt="" src="images/icons\\upblack.png"
			onmouseover="this.src='images/icons\\upwhite.png'"
			onmouseout="this.src='images/icons\\upblack.png'">
		</span>
	</div>
 


	<script type="text/javascript">
	function doLike(seq1, item){ // 좋아요 눌렀을 때			
		<%if (ologin == null) {%>
			loginView();
		<%} else {%> 
		 console.log(seq1);
		 var selector2 = "#likeCount_" + seq1;
			$.ajax({
				url:"PdsController", // 접근대상
				type:"get",		// 데이터 전송 방식
				data:"command=likeChange&id=<%=id%>&seq="+seq1, // 전송할 데이터
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
	  $(document).ready(function()
			    {
			        var speed = 700; // 스크롤되는 속도
			        $("#top_move").css("cursor", "pointer").click(function()
			        {
			            $('body, html').animate({scrollTop:0}, speed);
			        });
			        
			        $(window).scroll(function() {  //탑 메뉴 보이고 사라지게 하기

			        if($(this).scrollTop() > 50) {

			         $('.move').fadeIn();

			        } else {

			         $('.move').fadeOut();

			        }

			       });
			        
			    });
   </script>
</body>
</html>