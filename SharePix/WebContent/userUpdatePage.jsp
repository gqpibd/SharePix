<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>userUpdatePage</title>
</head>
<body>
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

mem = (MemberBean)ologin;
%>
<h2><%=mem.getName()%>님의 userUpdatePage</h2>
<div align="center">
<form action="MemberController" method="post" id="updateForm">
<input type="hidden" name="command" value="userUpdateAf">
<table border="1">
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
</td>
</tr>
</table>
</form>
</div>
<br><hr><br>
ㅁ todolist(181009)<br>
- ★ 일단 기능부터 <strike>개인정보 수정</strike>, 좋아요 카운트<br>
- ★ 닉네임, 자기소개 컬럼 만들자<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 닉네임 중복되면 안 되니까 확인 (ajax)<br>
- ★ 컬럼들 not null, unique 해야 돼 (email 등)<br>
- ★ 개인사진 수정(사진 업로드)<br>
- ★ 닉네임 중복, 비밀번호 확인 안 되면 수정 완료버튼 비활성화<br> 
- 테이블 보더 지우기<br>
<strike>- 이거 왜 수정 두번 눌러야 되지</strike><br>
<strike>- 비밀번호 확인</strike><br><br>
+ (추가) 이메일 select option?<br>
+ (추가) 문자, 숫자 포함한 비밀번호로 저장?<br>
+ (추가) 휴대폰 번호 쓰면 자동으로 넘어가게?<br>
= (추가) 팔로우<br>
<strike>? userUpdateAf 에서 post로 받는 내용을 location.href 로  controller 에 보내도 되는가?</strike><br>
</body>

<script type="text/javascript">
$(function () {
	$(document).on("click", "#btn_Edit", function(){	// 수정
		if($("#btn_Edit").val()=="수정"){	// 수정하면 readonly 지워서 수정 가능하게
			$("input[name='name']").removeAttr("readonly");
			$("input[name='pwd']").removeAttr("readonly");
			$("input[name='pwdCheck']").removeAttr("readonly");
			$("input[name='email']").removeAttr("readonly");
			$("input[name='phone1']").removeAttr("readonly");
			$("input[name='phone2']").removeAttr("readonly");
			$("input[name='phone3']").removeAttr("readonly");
			$("textarea[name='introduce']").removeAttr("readonly");
			
			$(this).attr("value", "수정 완료");
			//$(this).attr('disabled',true);	// 비밀번호 확인되기 전까지 버튼 비활성화

			//alert("--- 시간 : Tue Oct 09 18:27:52 KST 2018 잘 나옴1");
		}else if($("#btn_Edit").val()=="수정 완료"){		// 수정을 마치고 내용 변경 못하게 다시 readonly
			$("input[name='name']").attr("readonly", "readonly");
			$("input[name='pwd']").attr("readonly", "readonly");
			$("input[name='pwdCheck']").attr("readonly", "readonly");
			$("input[name='email']").attr("readonly", "readonly");
			$("input[name='phone1']").attr("readonly", "readonly");
			$("input[name='phone2']").attr("readonly", "readonly");
			$("input[name='phone3']").attr("readonly", "readonly");
			$("textarea[name='introduce']").attr("readonly", "readonly");
			
			$(this).attr("value", "수정");
			
			//alert("--- 시간 : Tue Oct 09 18:27:52 KST 2018 잘 나옴2"); // 확인용
			
			//if(){	// (미수정) 닉네임 중복확인, 비밀번호 확인된 것만 보내야지
				// 비밀 번호 있는데 location 쓰면 안 되지 form submit post으로 보내야지
				$("#updateForm").submit(); // userUpdateAf 로 보내기
			//}
							
		}
	});
	
	$(document).on("keyup", "input[name='name']", function () { // (미수정) 닉네임 중복 검사하려고 써둔
		
	});
});

/* 
   $.ajax({ // 참고하려고 불러온 ajax
	url:"./data.xml",
	dataType:"xml",
	success:function(data){
		//alert("success");
		_xml = $(data).find("xmldata");
		var len = _xml.find("news").length;
		
		for (var i = 0; i < len; i++) {
			
			_arrTarget[i] = _xml.find("news").eq(i).find("target").text();
			_arrLink[i] = _xml.find("news").eq(i).find("link").text();
			_arrDesc[i] = _xml.find("news").eq(i).find("name").text();
			
			$("body").append( _arrTarget[i]).append( _arrLink[i]).append( _arrDesc[i]).append("<br>");
			
		}
	},
	error:function(){
		alert("error");
	}
	}); 
*/

function checkPwd(){ // 자바스크립트로 패스워드 입력 확인
	var pw1 = document.getElementsByName("pwd")[0].value;
	var pw2 = document.getElementsByName("pwdCheck")[0].value;
	if(pw1 != "" || pw2 != ""){	// 빈 문자로 동일한 경우 제외
		 if(pw1!=pw2){
			   document.getElementById('checkPwd').style.color = "red";
			   document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요."; 
		 } else{
			   document.getElementById('checkPwd').style.color = "blue";
			   document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하셨습니다."; 
		 }
	}
}
</script>
</html>