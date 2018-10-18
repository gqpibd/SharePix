<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<PdsBean> list = (List<PdsBean>) request.getAttribute("list");
	System.out.println(list.size());
	Iterator<String> it = (Iterator<String>) request.getAttribute("sortedIter");
    HashMap<String,Integer> map = (HashMap<String,Integer>) request.getAttribute("map");
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>즐겨찾기 페이지</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<style type="text/css">
.img_clickable{
	cursor: pointer;
}

/* .mDiv{
	border: 1px solid #000;
	height: 200px;
	width: 400px;	
} */
.tag {
	margin : 5px;
	background-color: #ededed;	
	border-radius: 17px;
	border: 1px solid #dcdcdc;
	display: inline-block;
	cursor: pointer;
	color: #777777;
	font-family: Arial;
	font-size: 15px;
	padding: 5px 15px;
	text-decoration: none;
}

.tag:hover {
	background-color: #dfdfdf;
}
</style>
</head>
<body>
	<div class="left__heading" style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="myLikes.jsp" />
		</jsp:include>
	</div>

	<div align="center" class = "mDiv" style="margin-top: 10em">
	<div class="container" >
	<%	
	//25 20 15 10
	int iter = 0; // 지금 위치가 몇 번째인지 갯수를 세자
	int size = 25;
	int prevCount = -1; // 이전 갯수
	int currCount = -1; // 현재 갯수
	while(it.hasNext()) {		
        String temp = (String) it.next();        
        currCount = map.get(temp);
        if(prevCount != -1 && prevCount > currCount){
 			size = size-5;       	
        }
	%>
        <span class="tag" onclick="location.href='PdsController?command=keyword&tags=<%=temp%>'"style="font-size: <%=size%>px ">#<%=temp%></span>
    <% 
		prevCount=map.get(temp);
	    iter++;
	    if(iter>15){
	    	break;
	    }
    } %>
		
	</div>
	<div class="container" >
		<%for(PdsBean pds : list){ %>
		<div class="item">
			<img class="img img_clickable" name="item" src="images/pictures/<%=pds.getfSaveName()%>" onclick="veiwDetail(<%=pds.getSeq()%>)" height="400">
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