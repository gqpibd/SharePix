<%@page import="model.service.MemberService"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	Object ologin = session.getAttribute("login");
	if (ologin == null) {
		System.out.println("로그인 해야됨");
		response.sendRedirect("main.jsp");
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>개인정보수정</title>
<link rel="shortcut icon" href="images/icons/favicon.ico">
<style type="text/css">
.imgbox{
	position: relative;
	width: 300px;
	height: 300px;
	vertical-align: middle;
}
.holder{
	max-height: 300px;
	max-width: 300px;	
	position: relative;
	z-index: -1;	
}
.upload {
	align-self: center;
	width: 300px;
	height: 300px;
	opacity: 0;
	/* background-color:red; */
	cursor: pointer; 
	position: absolute;
	top: 0;
	left: 0;
	z-index: 1;
} 
.label
{
	top: -20px !important;
	transform: scale(.75) !important ; left:-15px !important;
    /* font-size: 14px; */
    color: #4a89dc !important;    
}
</style>
<script type="text/javascript">
var fileReader = new FileReader();
var filterType = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
fileReader.onload = function (event) { // 파일이 로드 되었을 때
   var image = new Image(); // 새로운 이미지를 생성한다.
   image.onload = function() {      
      document.getElementById("editable-Img").src = image.src;
   }
   image.src = event.target.result;
};
var loadImageFile = function () {
	  var uploadImage = document.getElementById("upload-Image"); //파일 요소 가져와서
	  
	  //check and retuns the length of uploded file.
	  if (uploadImage.files.length == 0) {  // 업로드 된게 있는지 확인하고
	    return; 
	  }	 
	  
	  //Is Used for validate a valid file.
	  var uploadFile = document.getElementById("upload-Image").files[0]; // 업로드된 파일중 첫 번째를 가져온다.
	  
	  if (!filterType.test(uploadFile.type)) {
	    alert("Please select a valid image."); 
	    return;
	  }	  
	  fileReader.readAsDataURL(uploadFile); // 파일 리더를 이용해 파일을 읽는다
};
</script>

</head>
<body onload="loadImageFile();">
	<%		
		MemberBean mem = null;
		mem = (MemberBean) ologin;
		System.out.println("수정 전 mem = " + mem.toString());

		MemberService service = MemberService.getInstance();
		MemberBean updateDto = service.getUserInfo(mem.getId());

		session.setAttribute("login", updateDto);
		session.setMaxInactiveInterval(30*60);
		Object updateLogin = session.getAttribute("login");
		
		updateDto = (MemberBean)updateLogin;
	%>
	<script type="text/javascript">
		location.href = "#";
	</script>
	<%
		System.out.println("수정 후 updateDto = " + updateDto.toString());
	%>
	<div style="position: relative; height: 100% ; z-index: 50;">
		<!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="MemberController?command=userUpdatePage" />
		</jsp:include>
	</div>
	<br>
	<br>
	<form action="MemberController" method="post" enctype="multipart/form-data">
	<div align="center" style="margin-top: 6em">
	<table>
	<col style="width: 350px"><col style="width: 350px">
	<tr>
	<td colspan="2">
	<h3 style="border:2px;border-bottom:2px solid #ddd; align-content: center !important;">개인정보 수정</h3>
	</td>
	</tr>
	<tr>
	<td style="padding-left: 30px; padding-right: 30px;">
		<div class="group">
			<input required="required" class="input" name="id" id="id" type="text" maxlength="12" readonly="readonly" value="<%=updateDto.getId()%>">
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date" id="id_label">ID&nbsp;&nbsp;&nbsp;(수정 불가)<span id="idcheck" style="font-size: 8px"></span></label>
		</div>
	</td>
	<td style="padding-left: 30px; padding-right: 30px;">
		<!-- ID input-->
		<div class="group">
			<input required="required" class="input" name="name" id="name" type="text" maxlength="12" value="<%=updateDto.getName()%>">
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date" id="name_label">이름<span style="font-size: 8px"></span></label>
		</div>
	</td>
	</tr>
	<tr>
	<td style="padding-left: 30px; padding-right: 30px; padding-bottom : 20px" rowspan="4">
			<div class="group">
			<label class="label" for="date">프로필 사진 : 드래그 하거나 클릭하여 업로드</label>
			</div>
			<br>
			<div class="imgbox" align="center">
			<img id="editable-Img" src='images/profiles/<%=updateDto.getId()%>.png' class='holder' align='middle' onerror="this.src='images/profiles/default.png'">
			<input type="file" name="fileload" accept="image/gif, image/jpeg, image/png" class="upload" id="upload-Image" onchange="loadImageFile();" >
			</div>
			<br>
			<div align="center">
			<a href="javascript:profile_default()" id="profile_default">기본 프로필 사진으로 변경</a>
			<input type="hidden" name="profile_keep_or_default" id="profile_keep_or_default" value="true">
			</div>
		</td>
		<!-- Password input-->
		<td style="padding-left: 30px; padding-right: 30px;">
		<div class="group">
			<input class="input" name="pwd" id="pwd" type="password" maxlength="12">
			<span class="highlight"></span>
			<span class="bar" id="pwd_bar"></span> 
			<label class="label" for="date">&nbsp;&nbsp;비밀번호</label>
		</div>
		</td>
	</tr>
	<tr>
		<!-- Password input-->
		<td style="padding-left: 30px; padding-right: 30px;">
		<div class="group">
			<input class="input" id="pwd2" type="password" maxlength="12" onkeyup="">
			<span class="highlight"></span>
			<span class="bar" id="pwd2_bar"></span> 
			<label class="label" for="date">&nbsp;비밀번호 확인</label>
		</div>
		</td>
	</tr>
	<tr>
		<!-- Email input-->
		<td style="padding-left: 30px; padding-right: 30px;">
		<div class="group">
			<input required="required" class="input" name="email" type="text" id="email2" onchange="email2Check()" value="<%=updateDto.getEmail()%>">
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date">&nbsp;&nbsp;이메일</label>
		</div>
		</td>
	</tr>
	<tr>
		<!-- Tel input-->
		<td style="padding-left: 30px; padding-right: 30px;">
		<div class="group">
			<input required="required" class="input" name="phone" type="text" id="phone2" onchange="phoneCheck()" value="<%=updateDto.getPhone()%>"/> <!-- pattern="\d{3}-\d{3,4}-\d{4}" -->
			<span class="highlight"></span>
			<span class="bar"></span> 
			<label class="label" for="date">&nbsp;&nbsp;전화번호</label>
		</div>
		</td>
	</tr>
	<tr>
	<td colspan="2" align="center" style="height: 80px">
	<button id="edit_Btn" class="sagongBtn fill" type="submit" >수정</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="button" class="sagongBtn fill" onclick="location.href='MemberController?command=userPage&id=<%=updateDto.getId()%>'">뒤로</button>
	</td>
	</tr>
	</table>
	</div>
	</form>
	<!-- 
	<hr>
	<br>
	<br>
	<hr>
	<br> ㅁ todolist(181023  업데이트 중)
	<br> - ★ 다운로드?
	<br> - ★ 내가 올린 사진들 그런 것 클릭 중일시 탭 누르는 효과처럼
	<br> - ★ a 태그 /  버튼 처럼, 탭처럼
	<br>
	
	<br> - 아이디 중복 검사시 창 변하게
	<br> - jpg 파일인지, png 파일인지 확장자 문제 있나?
	<br> - top버튼
	<br> + (추가) 휴대폰 번호 쓰면 자동으로 넘어가게?
	<br> - ★ 일단 기능부터
	<strike>개인정보 수정, 좋아요 카운트, 팔로우 페이지 꾸미기</strike>
	<br> <strike>- ★ 개인사진 수정(사진 업로드)</strike>
	<br> <strike>- ★ 닉네임 중복, 비밀번호 확인 안 되면 수정 완료버튼 비활성화</strike>
	<br> <strike>- ★ 아무 것도 없으면 아무것도 없습니다.</strike>
	<br> <strike>- ★ 구독 버튼 이미지 바꾸기</strike>
	<br> <strike>- ★ 자기가 올린 디테일 볼 때 팔로우 버튼 없애기</strike>
	<br> <strike>- ★ 관리자 삭제 기능</strike>
	<br> <strike>- 이미 사용하고 계신 비밀번호를 입력하셨습니다.</strike>
	<br> <strike>- 비밀번호 다르면 수정 못 하게?</strike>
	<br> <strike>- 비밀번호 공백이면 수정 못 하게?</strike>
	<br> <strike>- ★ 사진에서 바로 좋아요 기능이 이상하다</strike>
	<br> <strike>- ★ 히든 부분의 아쉬움</strike>
	<br> <strike>- ★ 팔로우 버튼 디자인</strike>
	<br> <strike>- tag들 각 체크박스로 해야 되나? 누를 때마다 ajax + jsp+include 로 검색 결과 가져오기?</strike>
	<br> <strike>- 다운로드, 좋아요 이런 애들 아이콘 구하기</strike>
	<br> <strike>- 로그인한 id 와 유저페이지의 id 가 다를 때 숨기는 코드 주석 삭제</strike>
	<br> <strike>? 세션에 저장된 거 없으면 반환하는 것 그거 매 jsp 마다 해야 하나? : 필요한 페이지만 쓰면 된다</strike>
	<br> <strike>+ (추가) 이메일 select option?</strike>
	<br> <strike>+ (추가) 문자, 숫자 포함한 비밀번호로 저장?</strike>
	<br> <strike>+ (추가) 신고 삭제</strike>
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
	-->
</body>

<script type="text/javascript">

$(document).ready(function () { // 전부 입력시에 수정버튼 활성화 되게끔 만들 생각
	var pwdCheck = false;
	$("input[type='password']").keyup(function () {
		if($("#pwd").val()=="" && $("#pwd2").val()==""){// 다시 null이 되었을 때 버튼 정상으로
			$("#edit_Btn").css("background-color", "");
			$("#edit_Btn").removeAttr("disabled");
		}else if($("#pwd").val()==$("#pwd2").val()){ 	// 비밀 번호 동일시
			$("#pwd2").css("color", "#0000ff");
			$("#edit_Btn").css("background-color", "");
			$("#edit_Btn").addClass('fill');
			$("#edit_Btn").removeAttr("disabled");
			pwdCheck = true;
		}else if($("#pwd").val()!=$("#pwd2").val()){
			$("#pwd2").css("color", "#ff0000");
			$("#edit_Btn").css("background-color","red");
			$("#edit_Btn").removeClass('fill');
			$("#edit_Btn").attr("disabled", "disabled");
			pwdCheck = false;
		}
	});
	
	$(document).on("click", "#edit_Btn", function () {// 수정 버튼 눌렸을 때
		if($("#name").val()==""){	//	닉네임 빈문자
			alert("닉네임을 입력하세요.");
			$("#name").focus();
			return;
		}else if($("#pwd").val()=="" && $("#pwd2").val()==""){// 새 비밀번호  빈 문자
			$("#pwd").val("<%=mem.getPwd()%>");
			$("#pwd2").val("<%=mem.getPwd()%>");
			return;
		}else if(!pwdCheck){ // 비밀번호 다를 때
			alert("비밀번호가 같지 않습니다.");
			$("#pwd2").focus();
			return;
		}else if($("#email2").val()==""){	// 이메일 빈문자
			alert("이메일을 입력하세요.");
			$("#email2").focus();
			return;
		}else if($("#phone2").val()==""){
			alert("핸드폰 번호를 입력하세요.");
			$("#phone2").focus();
			return;
		}
	});
});

function profile_default() {
	$("#editable-Img").attr("src", "images/profiles/default.png");
	console.log("profile_default() profile_keep_or_default : false");
	$("#profile_keep_or_default").val('false');
} 

$(document).ready(function(){ 
	$("#phone2").focus(function () {
		$("#phone2").attr("placeholder","010-XXXX-XXXX");
	});
	$("#phone2").focusout (function () {
		$("#phone2").attr("placeholder","");
	});
	$("#email2").focus(function () {
		$("#email2").attr("placeholder","hello@sagong.com");
	});
	$("#email2").focusout (function () {
		$("#email2").attr("placeholder","");
	});
});
function email2Check() {
	$.ajax({
		type:"get",
		url:"MemberController?command=emailcheck&email="+$("#email2").val(),
		data:"email=" + $('#email2').val(),
	
		success:function(data){
			
			var emailVal = $("#email2").val();
			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
			var emailCheck = false;
			
			if(emailVal.match(regExp) != null &&  data.trim() == "OK" ) { // 올바르게 입력한 경우
				$("#email2").css("color", "#0000ff");
				emailCheck = true;
			}else if(emailVal.match(regExp) == null) { // 형식이 올바르지 않은 경우
				$("#email2").css("color", "#000");
				alert("이메일형식에 맞게 입력해주세요\nex)hello@sagong'ssi.com");
				$("#email2").val("");
			    $("#email2").focus();  
				emailCheck = false;
			}else { // 중복된 이메일
				$("#email2").css("color", "#000");
				alert("사용 중인 id입니다.");
				$("#email2").val("");
				$("#email2").focus();
				emailCheck = false;
			}
		}
	});
}

function phoneCheck() {	
	var phoneVal = $("#phone2").val();	
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/;

	var phoneCheck = false;
	
	if (phoneVal.match(regExp) != null) {
		$("#phone2").css("color", "#0000ff");
		//$("#phone").css("background", "linear-gradient(to top, #3366FF, white)");
		//alert("번호를 올바르게 입력했습니다.");
		phoneCheck = true;
	}
	else {
	  $("#phone2").css("color", "#000");
	 //$("#phone").css("background", "linear-gradient(to top, #FF6666, white)");
	  alert("번호를 올바르게 입력해주세요\nex)010-XXXX-XXXX");
	  $("#phone2").focus();  
	  phoneCheck = false;
	}
}
</script>
</html>