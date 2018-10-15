
<%@page import="model.PdsManager"%>
<%@page import="model.iPdsManager"%>
<%@page import="dto.PagingBean"%>
<%@page import="dto.PdsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
<link rel="stylesheet" href="mainCss.css" type="text/css">
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
	<section class="gallery">
		<div class="container">
			<div class="grid">

					<%
						for (PdsBean Pdscust : PdsList) {
					%>
						<div class="column-xs-10 column-md-4">
							<figure class="img-container">
							<a
								href="PdsController?command=detailView&seq=<%=Pdscust.getSeq()%>">
								<img class="c2" src="<%=Pdscust.getfSaveName()%>">

								<label><%=Pdscust.getId()%></label>
								<label><%=Pdscust.getLikeCount()%></label>
								<label><%=Pdscust.getReadCount()%></label>
								<label><%=Pdscust.getCategory()%></label>
								<label><%=Pdscust.getReplyCount()%></label>

							</a>
						</figure>
					</div>
							<%
						}
					%>
					</div>
				</div>
		
			</section>
				<%
			}
		%>
		<div></div>
	</div>
</body>
</html>