<%@page import="dto.MemberBean"%>
<%@page import="model.service.PdsService"%>
<%@page import="controller.PdsController"%>
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
<title>sagong</title>
<%
	List<PdsBean> pdslist = null;
	if((pdslist= (List<PdsBean>) request.getAttribute("list")) == null){		
		pdslist = PdsService.getInstance().getSearchPdsNull();   
	}
	System.out.println(pdslist.size());
	MemberBean user = (MemberBean) request.getAttribute("login");
%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">

</head>
<body bgcolor="#D5D5D5">
	<div> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>
	
	<div> <!-- 검색 -->
		<form action="PdsController" method="get">
		<input type="hidden" name="command" value="keyword"> 
		<input type="text" name="tags"> 
		<input type="submit" value="검색">
		</form>
	</div>
	<div class="container">
		<%
			for (PdsBean Pdscust : pdslist) {
		%>
		<div class="item">
			<img class="img" name="item" src="images/pictures/<%=Pdscust.getfSaveName()%>" onclick="veiwDetail(<%=Pdscust.getSeq()%>)" height="300">
		</div>
		<%
		}
		%>
	</div>

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