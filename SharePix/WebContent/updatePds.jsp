<%@page import="java.util.Iterator"%>
<%@page import="utils.CollenctionUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.service.PdsService"%>
<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	Object ologin = session.getAttribute("login");
	MemberBean mem = null;	
	String seqStr = request.getParameter("seq");
	int seq = Integer.parseInt(seqStr);
	PdsBean dto = PdsService.getInstance().getPdsDetail(seq);	
%>

<%
   MemberBean user = (MemberBean)session.getAttribute("login"); // 로그인 정보
   HashMap<String,Integer> tagMap = CollenctionUtil.getHashMap(PdsService.getInstance().getSearchPds(dto.getCategory())); // 전체 게시글의 태그 정보	
   Iterator<String> it = CollenctionUtil.sortByValueReverse(tagMap).iterator(); // 중 갯수가 가장 적은 애들
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>updatePds</title>
<style>
.td1 {
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
  }
.td2{
	border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
 font-size: 19px;
}

</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="shortcut icon" href="images/icons/favicon.ico">
</head>
<body>

	<% if(ologin == null){ %>	
		<script type="text/javascript">
			loginView();
		</script>
		<%
	}
	mem = (MemberBean)ologin;	// 로그인한 사람의 dto
	%>
	<div class="left__heading" style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="main.jsp" />
		</jsp:include>
	</div>
	
	<div align="center" style="margin-top: 10em">
	<form action="PdsController" method="get" id="pdsupdate">
	<input type="hidden" name="command" value="pdsupdate">
	<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
	<table border="0" bgcolor="white" style='border-left:0;border-right:0;border-bottom:0;border-top:0'>
		<col width="500"><col width="300">
	<tr align="center">
    	<td class = "td2" colspan="2"><br>Image Update/Delete</td>
	</tr>               
	<tr>
		<td class = "td1" align="center">				
			<img src = "images/pictures/<%=dto.getfSaveName() %>" width="500">			
		</td>
		<td class = "td1" border="1">		
			<select name="category" class="btn btn-default dropdown-toggle">	
	            <option disabled value="카테고리" selected="selected"> 카테고리 </option>	
	     	    <option value="자연"> 자연 </option>	 
	            <option value="인물"> 인물 </option>	
	            <option value="음식"> 음식 </option>	            
	            <option value="과학"> 과학 </option>	            
	            <option value="디자인"> 디자인 </option>	            
	            <option value="기타"> 기타 </option>	            
	            </select> 
		<br><br>
		<div style="position:relative; float:left; text-align:left;">
	    	<textarea class="form-control" id="tagArea" rows="3" cols="50" name="tags" style="overflow-x:hidden; overflow-y:auto"><%for(int i=0;i<dto.getTags().length;i++){ %>#<%=dto.getTags()[i]%><%}%></textarea>
	    </div><br><br><br><br>
					<p style="margin-top: 5px; margin-bottom: 5px; font-weight: bold;">이런 태그가 필요해요</p><br>
				<div id="tags" align="center">
						
						<%
						if(it!=null){
						int iter = 0; // 지금 위치가 몇 번째인지 갯수를 세자
						while(it.hasNext()) {		
							String temp = (String) it.next();
						%>
							<span class="tag" onclick="addTag('<%=temp%>')" style="font-size: 15px; padding: 7px; margin: 2px">#<%=temp%></span>	
						<%
							iter++;
							if(iter>18){ 
							 	break;
							}
						}
					}%>
				</div>	
	   </td>
	</tr>
	
	</table>
	<input class="fill sagongBtn" type="submit" value="수정하기">	
	<button class="fill sagongBtn" type="button" onclick="deletePds()" >삭제하기</button>   
	<button class="fill sagongBtn" type="button" onclick = "history.back()">나가기</button> 

	
	</form>	  	

</div>

<script type="text/javascript">
	$(function () {	// 카테고리 값 설정
		$("select[name='category']").val('<%=dto.getCategory() %>');
	}); 
		
	function deletePds() {
		var check = confirm("정말 삭제하시겠습니까?");			
		if (check) {
			location.href = "PdsController?command=delete&seq=<%= dto.getSeq() %>";
		}
	}
	
	function addTag(tagName) {
		$("#tagArea").val($("#tagArea").val() + "#" + tagName);
	}
	function checkAndSubmit(){
		if($("select[name='category']").val() == "카테고리"){
			alert("카테고리를 입력해 주세요");
			$("select[name='category']").focus();
			return;
		}else{
			$("#pdswrite").submit();
		}
	}
	
	$("select[name='category']").change(function(){
		var category = $("select[name='category']").val();
		$.ajax({
			url:"PdsController", // 접근대상
			type:"get",		// 데이터 전송 방식
			data:"command=getCategoryTags&category=" + category, // 전송할 데이터
			success:function(data, status, xhr){					
				var tags = data.split("#");
				for(var i=0;i<tags.length;i++){
					console.log(tags[i]);
					$("#tags").children().eq(i).text("#" + tags[i]);						
				}
			},
			error:function(){ // 또는					 
				console.log("통신실패!");
			}
		});	
	});
	
	
	
</script>	
</body>
</html>