<%@page import="model.service.MemberService"%>
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
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="style/loginModal.css">
<title>userUpdatePage</title>
<style type="text/css">
.profile {
    width: 200px; 
    height: 200px;
}
.imgbox{
	position: relative;
	width: 200px;
	height: 200px;
	vertical-align: middle;
}
.holder{
	max-height: 200px;
	max-width: 200px;	
	position: relative;
	z-index: -1;	
}
.upload {
	width: 100px;
	height: 100px;
	opacity: 10;
	background-color:red;
	cursor: pointer; 
	position: absolute;
	top: 0;
	left: 0;
	z-index: 1;
} 
</style>
<script type="text/javascript">
var fileReader = new FileReader();
var filterType = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
fileReader.onload = function (event) { // 파일이 로드 되었을 때
	var image = new Image(); // 새로운 이미지를 생성한다.
	image.onload = function() {		
		document.getElementById("original-Img").src = image.src;
	}
	image.src = event.target.result;
	$("#mlabel").hide();
};
var loadImageFile = function () {
	  var uploadImage = document.getElementById("upload-Image"); //파일 요소 가져와서
	  
	  //check and retuns the length of uploded file.
	  if (uploadImage.files.length === 0) {  // 업로드 된게 있는지 확인하고
	    return; 
	  }
	  
	  //Is Used for validate a valid file.
	  var uploadFile = document.getElementById("upload-Image").files[0]; // 업로드된 파일중 첫 번째를 가져온다.
	  console.log(uploadFile);
	  if (!filterType.test(uploadFile.type)) {
	    alert("Please select a valid image."); 
	    return;
	  }	  
	  fileReader.readAsDataURL(uploadFile); // 파일 리더를 이용해 파일을 읽는다
}
</script>
</head>
<body onload="loadImageFile();">
	<%
		Object ologin = session.getAttribute("login");
		MemberBean mem = null;

		if (ologin == null) {
		%>
		<script type="text/javascript">
			loginView();
		</script>
		<%
		return;
		}

		mem = (MemberBean) ologin;

		System.out.println("수정 전 mem = " + mem.toString());

		MemberService service = MemberService.getInstance();
		MemberBean updateDto = service.getUserInfo(mem.getId());

		// 이래도 되나?
		session.setAttribute("login", updateDto);
	%>
	<script type="text/javascript">
		location.href = "#";
	</script>
	<%
		System.out.println("수정 후 updateDto = " + updateDto.toString());
	%>
	<div style="height: 100%">
		<!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>
	<div align="center" style="margin-top: 10em" >
		<form action="MemberController" method="post" id="updateForm">
			<input type="hidden" name="command" value="userUpdateAf">
			<table border="1">
				<tr align="center">
					<td colspan="2">개인사진 수정(사진 업로드)</td>
				</tr>

				<tr>
					<th>아이디 :</th>
					<td><input type="text" name="id"
						value="<%=updateDto.getId()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>이름(닉네임) :</th>
					<td><input type="text" class="readOnOff" name="name"
						value="<%=updateDto.getName()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>비밀번호 :</th>
					<td><input type="password" class="readOnOff" name="pwd"
						placeholder="새 비밀번호" value="" readonly="readonly"
						onkeyup="checkPwd()"></td>
				</tr>
				<tr>
					<th>비밀번호 확인 :</th>
					<td><input type="password" class="readOnOff" name="pwdCheck"
						placeholder="비밀번호 확인" value="" readonly="readonly"
						onkeyup="checkPwd()"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><div id="checkPwd">동일한
							비밀번호를 작성해주세요</div></td>
				</tr>
				<tr>
					<th>이메일 :</th>
					<td><input type="text" class="readOnOff" name="email"
						value="<%=updateDto.getEmail()%>" readonly="readonly">
						</td>
				</tr>
				<tr>
					<th>휴대폰 번호 :</th>
					<td><input type="text" class="readOnOff" name="phone1"
						style="width: 50px"
						value="<%=updateDto.getPhone().split("-")[0]%>"
						readonly="readonly">&nbsp;-&nbsp; <input type="text"
						class="readOnOff" name="phone2" style="width: 50px"
						value="<%=updateDto.getPhone().split("-")[1]%>"
						readonly="readonly">&nbsp;-&nbsp; <input type="text"
						class="readOnOff" name="phone3" style="width: 50px"
						value="<%=updateDto.getPhone().split("-")[2]%>"
						readonly="readonly"></td>
				</tr>
				<tr>
					<!--
					<th>자기 소개 : </th>
					<td><textarea name="introduce" rows="3" cols="20" readonly="readonly"></textarea></td>
					</tr>
					 -->
				<tr>
					<td colspan="2" align="center"><input type="button"
						id="btn_Edit" value="수정"></td>
				</tr>
			</table>
		</form>
	</div>
	<hr>
	<br>
	<br>
	<div align="center">
	<form class="form-horizontal" action="MemberController"  method="post" id="">
	<input type="hidden" name="command" value="userUpdateAf"> 
	<h3 style="margin:0 0 20px;padding:0 0 8px;border-bottom:2px solid #ddd">개인정보 수정</h3>
	<table>
	<col style="width: 500px">
	<tr>
		<td style="padding-left: 30px; padding-right: 30px;">
		<div class="group">
			<input required="required" class="input" name="id" id="tbID" type="text" maxlength="12" readonly="readonly" value="<%=updateDto.getId()%>">
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date">ID <span id="idcheck" style="font-size: 8px"></span></label>
		</div>
		</td>
	</tr>
	
	<tr>
		<td style="padding-left: 30px; padding-right: 30px;">
			<div class="imgbox">
			<img id="original-Img" src='images/profiles/<%=updateDto.getId()%>.png' width='100px' class='profile re-img holder' align='middle' onerror="this.src='images/profiles/default.png'">
			<input type="file" name="fileload" accept="image/gif, image/jpeg, image/png" class="upload" id = "upload-Image" onchange="loadImageFile();" >
			</div>
		</td>
	</tr>
	<tr>
		<td style="padding-left: 30px; padding-right: 30px;">
		<!-- ID input-->
		<div class="group">
			<input required="required" class="input" name="id" id="tbID" type="text" maxlength="12" readonly="readonly"  value="<%=updateDto.getName()%>">
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date">ID <span id="idcheck" style="font-size: 8px"></span></label>
		</div>
	</tr>
	<tr>
		<!-- Password input-->
		<td style="padding-left: 30px; padding-right: 30px;">
		<div class="group">
			<input required class="input" name="pwd" id="tbPwd" type="password" maxlength="12" >
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date">PW</label>
		</div>
		</td>
	</tr>
	<tr>
		<td style="padding-left: 30px; padding-right: 30px;">
		<!-- Password input-->
		<div class="group">
			<input required="required" class="input" id="cpass" type="password" maxlength="12" onchange="pwdCheck()" >
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date">PW확인</label>
		</div>
		</td>
	</tr>
	<tr>
		<td style="padding-left: 30px; padding-right: 30px;">
		<!-- Email input-->
		<div class="group">
			<input required="required" class="input" name="email" type="text" id="email" onchange="emailCheck()" value="<%=updateDto.getEmail()%>">
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date">EMAIL</label>
		</div>
	</tr>
	<tr>
		<td style="padding-left: 30px; padding-right: 30px;">
		<div class="group">
			<input required="required" class="input" name="phone" type="text" id="phone" onchange="phoneCheck()" placeholder="" value="<%=%>"> <!-- pattern="\d{3}-\d{3,4}-\d{4}" -->
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date">PHONE</label>
		</div>
		</td>
	</tr>
	<tr>
	<td><button type="button" onclick="location.href='MemberController?command=userPage&id=<%=updateDto.getId()%>'">뒤로</button></td>
	</tr>
	</table>
	</form>
	</div>
	<br>
	<br>
	<hr>
	<br>
	<br>
	<hr>
	<br> ㅁ todolist(181018 업데이트 중)
	<br> - ★ 일단 기능부터
	<strike>개인정보 수정, 좋아요 카운트</strike>, 팔로우 페이지 꾸미기
	<br> - ★ 개인사진 수정(사진 업로드)
	<br> - ★ 닉네임 중복, 비밀번호 확인 안 되면 수정 완료버튼 비활성화
	<br> - ★ 사진에서 바로 좋아요 기능이 이상하다
	<br> - ★ 다운로드?
	<br> - ★ 히든 부분의 아쉬움
	<br> - ★ 아무 것도 없으면 아무것도 없습니다.
	<br> - ★ 구독 버튼 이미지 바꾸기
	<br> - ★ 내가 올린 사진들 그런 것 클릭 중일시 탭 누르는 효과처럼
	<br>
	
	<br> - 이미 사용하고 계신 비밀번호를 입력하셨습니다.
	<br> - 아이디 중복 검사시 창 변하게
	<br> - 비밀번호 다르면 수정 못 하게?
	<br> - 비밀번호 공백이면 수정 못 하게?
	<br> - jpg 파일인지, png 파일인지 확장자 문제
	<br> - top버튼
	<br> <strike>- tag들 각 체크박스로 해야 되나? 누를 때마다 ajax + jsp+include 로 검색 결과 가져오기?</strike>
	<br> <strike>- 다운로드, 좋아요 이런 애들 아이콘 구하기</strike>
	<br> - 로그인한 id 와 유저페이지의 id 가 다를 때 숨기는 코드 주석 삭제
	<br>
	<br> <strike>? 세션에 저장된 거 없으면 반환하는 것 그거 매 jsp 마다 해야 하나? : 필요한 페이지만 쓰면 된다</strike>
	<br> <strike>+ (추가) 이메일 select option?</strike>
	<br> <strike>+ (추가) 문자, 숫자 포함한 비밀번호로 저장?</strike>
	<br> + (추가) 휴대폰 번호 쓰면 자동으로 넘어가게?
	<br> + (추가) 신고 삭제
	<br> <strike>+ (추가) 팔로우</strike>
	<br>
	<br>

	<br> <strike>- ★ 비회원이 userPage 접근시 : 디폴트 회원 Dto 만들까?</strike>
	<br> <strike>- ★ 내가 나 구독 막아</strike>
	<br> <strike>- ★ 가져온 pdslist 들의 count 합치기</strike>
	<br><strike>- ★ 수정 이후 돌아왔을 때 refresh 된 정보 띄우기</strike>
	
	<br><strike>? userUpdateAf 에서 post로 받는 내용을 location.href 로
		controller 에 보내도 되는가?</strike>
	<br><strike>- ★ 닉네임, 자기소개 컬럼 만들자</strike>
	<br>
	<strike>&nbsp;&nbsp;&nbsp;&nbsp;- 닉네임 중복되면 안 되니까 확인 (ajax)</strike>
	<br>
	<strike>- ★ 컬럼들 not null, unique 해야 돼 (email 등)</strike>
	<br>
	<strike>- 이거 왜 수정 두번 눌러야 되지</strike>
	<br>
	<strike>- 비밀번호 확인</strike>
	<br>
</body>

<script type="text/javascript">
	$(function() {
		$(document).on("click", "#btn_Edit", function() { // 수정
			if ($("#btn_Edit").val() == "수정") { // 수정하면 readonly 지워서 수정 가능하게
				$(".readOnOff").removeAttr("readonly"); // 클래스로 묶었

				$(this).attr("value", "수정 완료");
				//$(this).attr('disabled',true);	// 비밀번호 확인되기 전까지 버튼 비활성화

			} else if ($("#btn_Edit").val() == "수정 완료") { // 수정을 마치고 내용 변경 못하게 다시 readonly
				$(".readOnOff").attr("readonly", "readonly");

				$(this).attr("value", "수정");

				//if(){	// (미수정) 닉네임 중복확인, 비밀번호 확인된 것만 보내야지
				// 비밀 번호 있는데 location 쓰면 안 되지 form submit post으로 보내야지
				$("#updateForm").submit(); // userUpdateAf 로 보내기
				//}
			}
		});

		$(document).on("keyup", "input[name='name']", function() { // (미수정) 닉네임 중복 검사하려고 써둔

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

	/* function checkPwd() { // 자바스크립트로 패스워드 입력 확인
		var pw1 = document.getElementsByName("pwd")[0].value;
		var pw2 = document.getElementsByName("pwdCheck")[0].value;
		if (pw1 != "" || pw2 != "") { // 빈 문자로 동일한 경우 제외
			if (pw1 != pw2) {
				document.getElementById('checkPwd').style.color = "red";
				document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
			} else {
				document.getElementById('checkPwd').style.color = "blue";
				document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하셨습니다.";
			}
		}
	} */
	 
$(document).ready(function(){ 
	$("#phone").focus(function () {
		$("#phone").attr("placeholder","010-XXXX-XXXX");
	});
	
	$("#phone").focusout (function () {
		$("#phone").attr("placeholder","");
	});
	$("#email").focus(function () {
		$("#email").attr("placeholder","hello@sagong.com");
		
	});
	
	$("#email").focusout (function () {
		$("#email").attr("placeholder","");
	});
});
</script>
</html>