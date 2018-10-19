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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<title>updatePds</title>
<style>
.td1 {
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
  }
.re-img{ /* 댓글 프로필 */   
    float: left;
    width: 33px;
    height: 33px;
    border-radius: 33px;
    margin: 5px;
    vertical-align: middle;
}
.td2{
	border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
 font-size: 19px;
}

</style>
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
	<table border="0" bgcolor="white" style='border-left:0;border-right:0;border-bottom:0;border-top:0'>
		<col width="500"><col width="200">
	<tr align="center">
            <td class = "td2" colspan="2"><br>Image Update/Delete
            </td>
            </tr>
                <tr align="center">
            <td class = "td1" colspan="2" >
            <img src='images/profiles/<%=dto.getId()%>.png' width='100px'
            class='profile re-img' align='middle' onerror="this.src='images/profiles/default.png'">
            <br>
            </td>
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
		    	<textarea class="form-control" rows="3" cols="20" name="tags"><%for(int i=0;i<dto.getTags().length;i++){ %>#<%=dto.getTags()[i]%><%}%></textarea>
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