<%@page import="model.service.PdsService"%>
<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Object ologin = session.getAttribute("login");
MemberBean mem = null;

if(ologin == null){	
	%>	
	<script type="text/javascript">
	alert("로그인 해 주십시오.");
	location.href = "./index.jsp";
	</script>
	<%
	return;
}

mem = (MemberBean)ologin;	// 로그인한 사람의 dto

String seqStr = request.getParameter("seq");
int seq = Integer.parseInt(seqStr);
PdsBean dto = PdsService.getInstance().getPdsDetail(seq);
	/* PdsBean dto = (PdsBean)request.getAttribute("pds");    
	MemberBean user = (MemberBean)session.getAttribute("login");
	if(user == null){
		user = new MemberBean();
		user.setId("11");
	}
	if(dto==null){
		dto = new PdsBean();
		dto.setSeq(100);
		dto.setCategory("인물");
		dto.setfSaveName("2.jpg");
		String arr[] = new String[2];
		arr[0] = "a";
		arr[1] = "b";
		dto.setTags(arr);
	} */
	
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>pdsUpdatePage</title>
</head>
<body>

<h2>psdUpdatePage</h2>
<div align="center">

<table border="1" bgcolor="white" style='border-left:0;border-right:0;border-bottom:0;border-top:0'>
<col width="200"><col width="500">

<tr align="center">
   <td colspan="2"><br>빈공간<br><br>
   </td>
</tr>

<tr align="left">
   <td colspan="2"><br><%=mem.getId() %>
      <br>
      <input type="hidden" name="id" value="<%=mem.getId() %>">
      <br>
   </td>
</tr>

<tr align="center">
   <td colspan="2">이미지 추가<br>
   </td>
</tr>

<tr>
	<td align="center">
		
	<img src = "images/pictures/<%=dto.getfSaveName() %>"	>
	
	
	</td>
	 <td border="1">
<!-- 	<div style="position:relative; float:left; width:410px; text-align:left;"> -->

	<form action="PdsController" method="get" id="pdsupdate">
	<input type="hidden" name="command" value="pdsupdate">
		<select name="category">

            <option value="카테고리" selected="selected"> 카테고리 </option>

     	    <option value="자연"> 자연 </option>
 
            <option value="인물"> 인물 </option>

            <option value="음식"> 음식 </option>
            
            <option value="과학"> 과학 </option>
            
            <option value="디자인"> 디자인 </option>
            
            <option value="기타"> 기타 </option>
            
            </select> <p>
            </p>
       <!--      </div> -->
	<br><br>
	<div style="position:relative; float:left; width:410px; text-align:left;">
   <textarea rows="2" cols="20" name="tags"><%for(int i=0;i<dto.getTags().length;i++){ %>#<%=dto.getTags()[i]%><%}%></textarea>
   
   
   </div>
   <input type="submit" value="수정하기">
  <!--  <input align="right" type="submit" id="btn_update" value="수정하기"> -->
   </form>
   <br><br><br><br><br><br><br><br><br><br><br><br>
   <div style="position:relative; float:right; width:410px;">
	<button onclick="location.href='PdsController?command=delete&seq=<%= dto.getSeq() %>'" >삭제하기</button>   
   <input align="right" type="button" id="btn_out" value="나가기" onclick = "location.href='index.jsp'">

   </div> 

   </td>
</tr>

</table>


</form>
</div>

<%-- <script type="text/javascript">
$(function () {
	$("select[name='category']").val('<%=dto.getCategory() %>');
	$(document).on("click", "#btn_update", function(){	// 수정
		if($("#btn_update").val()=="수정"){	// 수정하면 readonly 지워서 수정 가능하게
			$("input[category='category']").removeAttr("readonly");
			$("input[tags='tags']").removeAttr("readonly");
			$(this).attr("value", "수정 완료");
		}else if($("#btn_update").val()=="수정 완료"){		// 수정을 마치고 내용 변경 못하게 다시 readonly
			$("input[name='category']").attr("readonly", "readonly");
			$("input[name='tags']").attr("readonly", "readonly");
			$(this).attr("value", "수정");
				$("#updateForm").submit();
							
		}
	});
	$(document).on("keyup", "input[name='name']", function () { // (미수정) 닉네임 중복 검사하려고 써둔
		
	});
}); --%>
<!--  $(function () {
	$(document).on("click", "#btn_delete", function(){	// 수정
		if($("#btn_delete").val()=="삭제"){	
			$(this).attr("value", "삭제 완료");
			
			$("#deleteForm").submit(); 
		
		}
			
		});
	}); -->
	 
	
</script>



</body>
</html>