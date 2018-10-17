<%@page import="model.service.PdsService"%>
<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	Object ologin = session.getAttribute("login");
	MemberBean mem = null;
	
	String seqStr = request.getParameter("seq");
	int seq = Integer.parseInt(seqStr);
	PdsBean dto = PdsService.getInstance().getPdsDetail(seq);

	
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>updatePds</title>
</head>
<body>

	<% if(ologin == null){ %>	
		<script type="text/javascript">
		alert("로그인 해 주십시오.");
		location.href = "./index.jsp";
		</script>
		<%
	}
	mem = (MemberBean)ologin;	// 로그인한 사람의 dto
	%>
	<div class="left__heading" style="height: 100%"> <!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>
	
	<div align="center" style="margin-top: 10em">
	<form action="PdsController" method="get" id="pdsupdate">
	<input type="hidden" name="command" value="pdsupdate">
	<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
	<table border="1" bgcolor="white" style='border-left:0;border-right:0;border-bottom:0;border-top:0'>
		<col width="500"><col width="200">

		
		<tr align="center">
		   <td colspan="2"><br>빈공간<br><br>
		   </td>
		</tr>
		
		<tr align="left">
		   <td colspan="2"><br><%=mem.getId() %></td>
		</tr>
		
		<tr align="center">
		   <td colspan="2">이미지 추가<br>
		   </td>
		</tr>
		
		<tr>
			<td align="center">				
				<img src = "images/pictures/<%=dto.getfSaveName() %>" width="500">			
			</td>
			<td border="1">		
				<select name="category">	
		            <option value="카테고리" selected="selected"> 카테고리 </option>	
		     	    <option value="자연"> 자연 </option>	 
		            <option value="인물"> 인물 </option>	
		            <option value="음식"> 음식 </option>	            
		            <option value="과학"> 과학 </option>	            
		            <option value="디자인"> 디자인 </option>	            
		            <option value="기타"> 기타 </option>	            
		            </select> 
			<br><br>
			<div style="position:relative; float:left; text-align:left;">
		    	<textarea rows="2" cols="20" name="tags"><%for(int i=0;i<dto.getTags().length;i++){ %>#<%=dto.getTags()[i]%><%}%></textarea>
		    </div>
		   </td>
		</tr>
	
	</table>
	<input class="fill sagongBtn" type="submit" value="수정하기">	
	<button class="fill sagongBtn" type="button" onclick="deletePds()" >삭제하기</button>   
	<button class="fill sagongBtn" type="button" onclick = "location.href='index.jsp'">나가기</button> 
	</form>	  	

</div>

<script type="text/javascript">
	$(function () {	// 카테고리 값 설정
		$("select[name='category']").val('<%=dto.getCategory() %>');	

	$(document).on("keyup", "input[name='name']", function () { // (미수정) 닉네임 중복 검사하려고 써둔
			
		});
	}); 

		
	function deletePds() {
		var check = confirm("정말 삭제하시겠습니까?");			
		if (check) {
			location.href = "PdsController?command=delete&seq=<%= dto.getSeq() %>";
		}
	}
</script>	
</body>
</html>