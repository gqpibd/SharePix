<%@page import="dto.MemberBean"%>
<%@page import="controller.FileController"%>
<%@page import="java.io.File"%>
<%@page import="model.PdsManager"%>
<%@page import="model.service.PdsService"%>
<%@page import="model.iPdsManager"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.PagingBean"%>
<!DOCTYPE html> 
<%
	request.setCharacterEncoding("utf-8");
	String PATH = "images/";
	// 검색어	
	String keyword = (String)request.getAttribute("keyword");	
	String choice = (String)request.getAttribute("choice");
%>

<!-- 페이징 처리 정보 교환 -->
<%
	PagingBean paging = new PagingBean();
	if (request.getParameter("nowPage") == null) {
		paging.setNowPage(1);
	} else {
		paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));
	}
%>

<%	
		
	// 검색어를 지정하지 않았을 경우, 빈 문자열로
	if (keyword == null) {
		keyword = "";		
	}
	iPdsManager pds = new PdsManager();
	List<PdsBean> pdslist = pds.getPdsPagingList(paging, keyword, choice);
	
	System.out.println(pdslist.size());
	MemberBean ologin = (MemberBean) session.getAttribute("login");
	String id = "";
	if (ologin != null) {
		id = ologin.getId();
	}
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<script src="js/imgGridFunction.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<link rel="stylesheet" href="style/pagingbtn.css">
<link rel="shortcut icon" href="images/icons/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Jua" rel="stylesheet">
</head>
<body style="background-color: #f6f6f6">
	<div style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="main.jsp" />
		</jsp:include>
	</div>
	<% if(ologin==null){ %>
	<div style="margin-top: 6em" >
	</div>
	<%}else{ %>
	<div style="margin-top: 8em" >
	</div>
	<%} %> 
		
	<% 
	String choicekey =  "";
	if(choice.equalsIgnoreCase("SEQ")){
		choicekey = "최신순"; 	
	}else if(choice.equalsIgnoreCase("LIKECOUNT")){
		choicekey = "좋아요수"; 	
	}else if(choice.equalsIgnoreCase("DOWNCOUNT")){
		choicekey = "다운로드수"; 
	}else if(choice.equalsIgnoreCase("READCOUNT")){
		choicekey = "읽은수"; 
	}
	String keywordkey = "카테고리";
	if(keyword.equalsIgnoreCase("자연")){
		keywordkey = "자연"; 	
	}else if(keyword.equalsIgnoreCase("인물")){
		keywordkey = "인물"; 	
	}else if(keyword.equalsIgnoreCase("과학")){
		keywordkey = "과학"; 
	}else if(keyword.equalsIgnoreCase("디자인")){
		keywordkey = "디자인"; 
	}else if(keyword.equalsIgnoreCase("기타")){
		keywordkey = "기타"; 
	}
	%>
	<div class="menubar">
                <ul>
<!--                  <li><a href="#">Home</a></li> -->
                 <li><a href="#" id="current"><%=choicekey %></a>
                    <ul>
                     <li><a href="PdsController?command=keyword&tags=<%=keyword %>&choice=SEQ">최신순</a></li>
                     <li><a href="PdsController?command=keyword&tags=<%=keyword %>&choice=LIKECOUNT">좋아요수</a></li>
                     <li><a href="PdsController?command=keyword&tags=<%=keyword %>&choice=DOWNCOUNT">다운로드수</a></li>
                     <li><a href="PdsController?command=keyword&tags=<%=keyword %>&choice=READCOUNT">읽은수</a></li>
                    </ul>
                 </li>
                 	<li><a href="#" id="current"><%=keywordkey %></a>
                    <ul>
                     <li><a href="PdsController?command=keyword&tags=자연&choice=<%=choice %>">자연</a></li>
                     <li><a href="PdsController?command=keyword&tags=인물&choice=<%=choice %>">인물</a></li>
                     <li><a href="PdsController?command=keyword&tags=음식&choice=<%=choice %>">음식</a></li>
                     <li><a href="PdsController?command=keyword&tags=과학&choice=<%=choice %>">과학</a></li>
                     <li><a href="PdsController?command=keyword&tags=디자인&choice=<%=choice %>">디자인</a></li>
                     <li><a href="PdsController?command=keyword&tags=기타&choice=<%=choice %>">기타</a></li>
                    </ul>
                 </li>
<!--                  <li><a href="#">Address</a></li> -->
                </ul>
           </div>
           <div style="margin-top: 1em" ></div>

	<!-- 검색된 사진들 -->
	
	<%
		if (pdslist==null ||pdslist.size() == 0) {
	%>
	
	<table style="width: 100%">
		<tr>
			<td colspan="3" align="center">검색 결과가 없습니다.</td>
		</tr>
	</table>
	<%
		} else {
	%>
	<div class="mcontainer">
				
		<%
		PdsService pService = PdsService.getInstance();
		for (PdsBean Pdscust : pdslist) {
			String fSavename = Pdscust.getfSaveName();
			String smallSrc = fSavename.substring(0,fSavename.lastIndexOf('.')) + "_small" + fSavename.substring(fSavename.lastIndexOf('.'));			
			File f = new File(config.getServletContext().getRealPath("/images/pictures") + "\\" + fSavename);
			 if (f.exists() && f.length()<300000) { // 300kb 이하의 이미지는 그냥 원본을 가져온다
		    	  smallSrc = fSavename;			     
		    }			 
		    boolean isLike = false;
			String like = "heart.png";
			String reverslike = "fullheart.png";
			if (id != null) {					
				int seq = Pdscust.getSeq();
				isLike = pService.checkPdsLike(id, seq);
				if (isLike) {
					like = "fullheart.png";
					reverslike = "heart.png";
				}
			}
			
		%>
		<div class="item profilebox profilebox1">
			<img class="img" name="item" src="images/pictures/<%=smallSrc%>"  
				onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300" onerror="$(this).parent().remove()" 
				style="cursor: pointer;">
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
	<%} %>
	</div>
	<%
		}
	%>

	
	<div class="notdivpaging">
		<jsp:include page="paging.jsp">
			<jsp:param name="actionPath" value="PdsController?" />
			<jsp:param name="nowPage"
				value="<%=String.valueOf(paging.getNowPage())%>" />
			<jsp:param name="totalCount"
				value="<%=String.valueOf(paging.getTotalCount())%>" />
			<jsp:param name="countPerPage"
				value="<%=String.valueOf(paging.getCountPerPage())%>" />
			<jsp:param name="blockCount"
				value="<%=String.valueOf(paging.getBlockCount())%>" />
			<jsp:param name="keyword" value="<%=keyword%>" />
		</jsp:include>
	</div>


	<script type="text/javascript">
	function doLike(seq1, item){ // 좋아요 눌렀을 때			
		<%if (ologin == null) {%>
			loginView();
		<%} else {
		%> 
		 console.log(seq1);
		 var selector2 = "#likeCount_" + seq1;
			$.ajax({
				url:"PdsController", // 접근대상
				type:"get",		// 데이터 전송 방식
				data:"command=likeChange&id=<%=id%>&seq="+seq1, // 전송할 데이터
				success:function(data, status, xhr){
					//console.log(data);
					var like = $(item).html(data).find("like").text();
					var count = $(item).html(data).find("count").text();
					//console.log("result(like) :" + like);
					//console.log("result(count) :" + count);
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
	</script>



</body>
</html>