<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("utf-8");%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style type="text/css">
.center{ 
	margin: auto;
	width: 19%;
	border: 3px solid #24FCFF;
	padding: 10px; 
	text-align: center;
}
</style>

</head>
<body>


<div align="center"> 
<h1>Wellcome SharePix</h1>
<p>MEMBER JOIN VIEW</p>
</div>


<div class="center"> 
<form action="MemberController" method="post">

<input type="hidden" name="command" value="regi"> 

<table border="0">
<tr>
	<td valign="top">ID</td>
	<td align="left">
	<input type="text" name="id" id="id" size="20">	
	<p id="idcheck" style="font-size: 8px"></p> 	
	</td>
	<td valign="top">
	<input type="button" id="btn" value="ID확인">		
	</td>
</tr>
<tr>
	<td valign="top">PW</td>
	<td colspan="2" align="left"><input type="text" name="pwd" size="20"><p></p>
	</td>
	<!-- <td></td> -->
</tr>
<tr>
	<td valign="top">NAME</td>
	<td colspan="2" align="left"><input type="text" name="name" size="20"><p></p>
	</td>
	<!-- <td></td> -->
</tr>
<tr>
	<td valign="top">EMAIL</td>
	<td colspan="2" align="left"><input type="text" name="email" size="20"><p></p>
	</td>
	<!-- <td></td> -->
</tr>
<tr>
	<td valign="top">PHONE</td>
	<td colspan="2" align="left"><input type="text" name="phone" size="20"><p></p>
	</td>
	<!-- <td></td> -->
</tr>
<tr>
	<td colspan="3" align="center">
		<input type="submit" value="회원가입">
	</td>
	<!-- <td></td> -->
	<!-- <td></td> -->
</tr>

</table>
</form>
</div>


<div align="center">
<br>
<a href="index.jsp"><font size="2">Home으로 돌아가기</font></a>
</div>


<script type="text/javascript">
$(function () {
	$("#btn").click(function () {
		$.ajax({
			type:"get",
			url:"./idcheck.jsp",
			data:"id=" + $('#id').val(),
			
			success:function(data){
				if(data.trim() == "OK"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").html("사용할 수 있는 id입니다.");
				}else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").html("사용 중인 id입니다.");
					$("#id").val("");
				}
			}
		});
	});
});
</script>


</body>
</html>