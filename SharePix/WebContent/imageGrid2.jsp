<%@page import="java.io.File"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.MemberBean"%>
<%@page import="model.service.PdsService"%>
<%@page import="java.util.List"%>
<%@page import="model.PdsManager"%>
<%@page import="model.iPdsManager"%>
<%@page import="dto.PagingBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	// 검색어	
	String keyword = (String)request.getAttribute("keyword");	
	String choice = (String)request.getAttribute("choice");
	
	/* 페이징 처리 정보 교환 */ 
	PagingBean paging = new PagingBean();
	if (request.getParameter("nowPage") == null) {
		paging.setNowPage(1);
	} else {
		paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));
	}	
		
	// 검색어를 지정하지 않았을 경우, 빈 문자열로
	if (keyword == null) {
		keyword = "";		
	}
	iPdsManager pds = new PdsManager();
	List<PdsBean> pdslist = pds.getPdsPagingList(paging, keyword, choice);
		
	MemberBean ologin = (MemberBean) session.getAttribute("login");
	String id = "";
	if (ologin != null) {
		id = ologin.getId();
	}
%>

<script src="js/jquery.row-grid.min.js"></script>
<link rel="stylesheet" href="style/imageArrange.css">
<!-- 검색된 사진들 -->
<% if (pdslist==null ||pdslist.size() == 0) { %>	
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
			<a style="text-decoration: none; color: white;">
				<img class="clickable" id="like_<%=Pdscust.getSeq()%>" alt="" src="images/icons\\<%=like%>"
				onmouseover="this.src='images/icons\\<%=reverslike %>'"
				onmouseout="this.src='images/icons\\<%=like%>'"
				onclick="doLike('<%=Pdscust.getSeq()%>', this)"
				style="vertical-align: middle; width: 40%; height: auto;" > 
				<p id ="likeCount_<%=Pdscust.getSeq()%>"><%=Pdscust.getLikeCount()%></p>
				
            <a href="#" style="text-decoration:none; color: white;">
				<img alt="" src="images/icons\\downloadC.png"
				onmouseover="this.src='images/icons\\fulldownloadC.png'"
				onmouseout="this.src='images/icons\\downloadC.png'"
				style="width: 40%; height: auto;">
				<p><%=Pdscust.getDownCount()%></p>
			</a>
			
            <a href="#" style="text-decoration:none; color: white;">
            	<img alt="" src="images/icons/contract.png" 
				onmouseover="this.src='images/icons/fullcontract.png'"
				onmouseout="this.src='images/icons/contract.png'"
				style="width: 40%; height: auto;">
				<p><%=Pdscust.getReplyCount()%></p>
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

$(document).ready(function() {
  var options = {minMargin: 5, maxMargin: 15, itemSelector: ".item", firstItemClass: "first-item"};
  $(".mcontainer").rowGrid(options);
});


function veiwDetail(seq) {
	console.log(seq);
	location.href="PdsController?command=detailview&seq=" + seq;
}		

</script>
