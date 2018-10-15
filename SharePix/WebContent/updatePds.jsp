<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	PdsBean dto = (PdsBean)request.getAttribute("pds");    
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
	}
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
<form action="PdsController" method="post" id="updateForm">

<input type="hidden" name="command" value="pdsUpdateAf">


<%-- <table border="1">
<tr align="center">
<td colspan="2">개인사진 수정(사진 업로드)</td>
</tr>
<tr>
<th>아이디 : </th>
<td><input type="text" name="id" value="<%=mem.getId()%>" readonly="readonly"></td>
</tr>
<tr>
<th>이름(닉네임) : </th>
<td><input type="text" name="name" value="<%=mem.getName()%>" readonly="readonly"></td>
</tr>
<tr>
<th>비밀번호 : </th>
<td><input type="password" name="pwd" value="" readonly="readonly" onkeyup="checkPwd()"></td>
</tr>
<tr>
<th>비밀번호 확인 : </th>
<td><input type="password" name="pwdCheck" value="" readonly="readonly" onkeyup="checkPwd()"></td>
</tr>
<tr>
<td colspan="2" align="center"><div id="checkPwd">동일한 비밀번호를 작성해주세요</div></td>
</tr>
<tr>
<th>이메일 : </th> 
<td><input type="text" name="email" placeholder="placeholder 이메일" value="" readonly="readonly"></td>
</tr>
<tr>
<th>휴대폰 번호 : </th>
<td>
	<input type="text" name="phone1" style="width: 50px" value="<%=mem.getPhone().substring(0, 3)%>" readonly="readonly">&nbsp;-&nbsp;
	<input type="text" name="phone2" style="width: 50px" value="<%=mem.getPhone().substring(3, 7)%>" readonly="readonly">&nbsp;-&nbsp;
	<input type="text" name="phone3" style="width: 50px" value="<%=mem.getPhone().substring(7)%>" readonly="readonly">
</td>
</tr>
<tr>
<th>자기 소개 : </th>
<td><textarea name="introduce" rows="3" cols="20" readonly="readonly"></textarea></td>
</tr>
<tr>
<td colspan="2" align="center">
	<input type="button" id="btn_Edit" value="수정">
	<input type="button" id="btn_delete" value="삭제">
	<input type="button" id="btn_out" value="나가기">
	
</td>
</tr>
</table> --%>
<table border="1" bgcolor="white" style='border-left:0;border-right:0;border-bottom:0;border-top:0'>
<col width="200"><col width="500">

<tr align="center">
   <td colspan="2"><br>빈공간<br><br>
   </td>
</tr>

<tr align="left">

   <td colspan="2"><br><%=user.getId() %>
      <br>
      <input type="hidden" name="id" value="<%=user.getId() %>">
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
	<select name="category">
	
<%-- 	<td colspan="2"><br><%=user.getId() %>
      <br>
      <input type="hidden" name="id" value="<%=user.getId() %>">
      <br>
   </td> --%>
   

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
   <textarea rows="2" cols="20" name="tags"><%= dto.getTags() %></textarea>
   
  
   
   
   </div>
   <br><br><br><br><br><br><br><br><br><br><br><br>
   <div style="position:relative; float:right; width:410px;">
   <form action="PdsController" >
   <input align="right" type="button" id="btn_update" value="수정하기">
   </form>
   <form action="PdsController" >
   <input type = "hidden" name = "command" value = "delete">
   <input align="right" type="button" id="btn_delete" value="삭제하기">
   <input type="hidden" name = "seq" value = "<%= dto.getSeq() %>">
   </form>
   
   <input align="right" type="button" id="btn_out" value="나가기" onclick = "location.href='index.jsp'">

   </div> 

   </td>
</tr>

</table>


</form>
</div>

<script type="text/javascript">
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
});
/* $(function () {
	$(document).on("click", "#btn_delete", function(){	// 수정
		if($("#btn_delete").val()=="삭제"){	
			$(this).attr("value", "삭제 완료");
			
			$("#deleteForm").submit(); 
		
		}
			
		});
	});
	 */
	
</script>



</body>
</html>