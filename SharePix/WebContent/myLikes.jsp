<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<PdsBean> list = (List<PdsBean>) request.getAttribute("list");
	System.out.println(list.size());
	String hStr = request.getParameter("height");
	int height = 380;
	if(hStr!=null){
		height = Integer.parseInt(hStr);
	}
	System.out.println(height);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>

<link rel="stylesheet" href="style/imageArrange.css">
</head>
<body>
	<div class="container">
		<%for(PdsBean pds : list){ %>
		<div class="item">	
			<img class="img" name="item" src="<%=PdsController.PATH%><%=pds.getfSaveName()%>" onclick="veiwDetail(<%=pds.getSeq()%>)" height="<%=height%>"> 
		</div>
		<%} %>
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