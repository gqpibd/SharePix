<%@page import="java.util.List"%>
<%@page import="dto.PdsBean"%>
<%@page import="model.PdsManager"%>
<%@page import="model.iPdsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Picturebay</title>

<link rel="stylesheet" href="mainCss.css" type="text/css">

<%
	iPdsManager pds = new PdsManager();

	List<PdsBean> pdslist = pds.getSearchPdsNull();	
%>

</head>
<body>

	<nav>
		<div class="container">
			<div class="grid">
				<div class="column-xs-12 column-md-10">
					<form action="PdsController" method="get">
						<input type="hidden" name="command" value="keyword"> 
						<input type="text" name="tags"> 
						<input type="submit" value="검색">
					</form>
				</div>

				<div class="column-xs-12 column-md-2">
					<ul>
						<li><a href="#" class="active">gagang</a></li>
						<li><a href="#">Login</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>


	<section class="gallery">
		<div class="container">
			<div class="grid">

				<%
					for (PdsBean Pdscust : pdslist) {
				%>

				<div class="column-xs-10 column-md-4">
					<figure class="img-container">

						<a
							href="PdsController?command=detailView&seq=<%=Pdscust.getSeq()%>">

							<input type="hidden" name="command" value="keyword"> <img
							class="c2" src="<%=Pdscust.getfSaveName()%>">
						</a>
					</figure>
				</div>

				<%
					}
				%>
			</div>
		</div>

	</section>

	<div></div>
</body>
</html>