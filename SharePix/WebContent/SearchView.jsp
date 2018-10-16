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
	List<PdsBean> PdsList = (List<PdsBean>) request.getAttribute("searchList");
%>

<%
	String choice = request.getParameter("choice");
	// 검색어
	String keyword = request.getParameter("keyword");
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
	System.out.println("choice = " + choice);

	if (choice == null || choice.equals("")) {
		choice = "sel";
	}
	if (choice.equals("sel")) {
		keyword = "";
	}

	// 검색어를 지정하지 않았을 경우, 빈 문자열로
	if (keyword == null) {
		keyword = "";
		choice = "sel";
	}
	iPdsManager pds = new PdsManager();
	// List<BbsDto> bbslist = dao.getBbsList();
	List<PdsBean> pdslist = pds.getPdsPagingList(paging, keyword);
	//PdsService.getPdsPagingList(paging, findWord);
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<link rel="stylesheet" href="style/imagehover.css">
</head>
<body>
	<h1>Search View</h1>
	<div>
		<div>
			<div>
				<p>그림</p>
				<form action="PdsController" method="get">
					<input type="hidden" name="command" value="keyword"> <input
						type="text" name="tags"> <input type="submit" value="검색">
				</form>
			</div>

		</div>
		<div>
			<p>메뉴</p>
			<p>카테고리</p>
			<jsp:include page="paging.jsp">
				<jsp:param name="actionPath" value="bbslist.jsp" />
				<jsp:param name="nowPage"
					value="<%=String.valueOf(paging.getNowPage())%>" />
				<jsp:param name="totalCount"
					value="<%=String.valueOf(paging.getTotalCount())%>" />
				<jsp:param name="countPerPage"
					value="<%=String.valueOf(paging.getCountPerPage())%>" />
				<jsp:param name="blockCount"
					value="<%=String.valueOf(paging.getBlockCount())%>" />

				<jsp:param name="keyword" value="<%=keyword%>" />
				<jsp:param name="choice" value="<%=choice%>" />
			</jsp:include>
		</div>
		<!-- 검색된 사진들 -->

		<%
			if (PdsList.size() == 0) {
		%>
		<tr>
			<td colspan="3" align="center">검색 결과가 없습니다.</td>
		</tr>
		<%
			} else {
		%>


		<div class="container">

			<%
				for (PdsBean Pdscust : PdsList) {
			%>
			<div class="item profilebox profilebox1">

				<img class="img" name="item" src="images/pictures/<%=Pdscust.getfSaveName()%>" onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300">
				<div class="SocialIcons">
						<a>
						<img alt="" src="images/icons/heart.png" 
						onmouseover="this.src='images/icons/fullheart.png'"
						onmouseout="this.src='images/icons/heart.png'"
						onclick="doLike()" class="btn-like">
						<label><%=Pdscust.getLikeCount()%></label>
						</a>
						
		            <a href="#" style="text-decoration:none; color: white;">
						<img alt="" src="images/icons/openbook.png" 
						onmouseover="this.src='images/icons/fullopenbook.png'"
						onmouseout="this.src='images/icons/openbook.png'"
						>
						<label><%=Pdscust.getReadCount()%></label>
					</a>
					
		            <a href="#" style="text-decoration:none; color: white;">
		            	<img alt="" src="images/icons/contract.png" 
						onmouseover="this.src='images/icons/fullcontract.png'"
						onmouseout="this.src='images/icons/contract.png'"
						>
						<label><%=Pdscust.getReplyCount()%></label>
					</a> 
				</div>
				<div class="profileInfo">
		        	<h3><a href= "MemberController?command=userPage&id=<%=Pdscust.getId()%>"><%=Pdscust.getId()%></a></h3>
		    	</div>

	</div>
	<%} %>
	</div>


	<%
		}
	%>
	<div></div>

	<script type="text/javascript">
		$(document).ready(function() {
		  var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
		  $(".container").rowGrid(options);
		});
		
		
		function veiwDetail(seq) {
			console.log(seq);
			location.href="PdsController?command=detailview&seq=" + seq;
		}		

	</script>

</body>
</html>