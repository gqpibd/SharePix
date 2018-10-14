<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<PdsBean> list = (List<PdsBean>) request.getAttribute("list");   
	System.out.println(list.size());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<style type="text/css">
.container {
  background: #eee;
}
/* clearfix */
.container:before,
.container:after {
    content: "";
    display: table;
}
.container:after {
    clear: both;
}

.item {
  float: left;
  margin-bottom: 10px; 
}
.item img {
  max-width: 100%;
  max-height: 100%;
  vertical-align: bottom;
}
.first-item {
  clear: both;
}
/* remove margin bottom on last row */
.last-row, .last-row ~ .item {
  margin-bottom: 0;
}

</style>
</head>
<body>
	<div class="container">
		<%for(PdsBean pds : list){ %>
		<div class="item">	
			<img class="img" name="item" src="<%=PdsController.PATH%><%=pds.getfSaveName()%>" onclick="veiwDetail(<%=pds.getSeq()%>)" height="200"> 
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