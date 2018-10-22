<%@page import="model.service.AlarmService"%>
<%@page import="dto.AlarmBean"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberBean user = (MemberBean) session.getAttribute("login");
	String goBackTo = request.getParameter("goBackTo");
	int alarmCount = 0;
	if(user!=null){
		alarmCount = AlarmService.getInstance().getAlarmList(user.getId()).size(); 
	}	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SaGong'ssi</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style/loginModal.css">
<link rel="stylesheet" href="style/common.css">
<link rel="stylesheet" href="style/titlebar.css">

<script type="text/javascript">
function idCheck() {
	$.ajax({
		type:"get",
		url:"MemberController?command=idcheck&id="+$("#tbID").val(),
		data:"id=" + $('#tbID').val(),
		
		success:function(data){
			if(data.trim() == "OK"){
				$("#idcheck").css("color", "#0000ff");
				//$("#idcheck").html("사용할 수 있는 id입니다.");
				$("#idcheck").val("");
				$("#idcheck").focus();
				alert("사용할 수 있는 id입니다.");
		
			}else{
				$("#idcheck").css("color", "#ff0000");
				//$("#idcheck").html("사용 중인 id입니다.");
				alert("사용 중인 id입니다.");
				$("#tbID").val("");
				$("#tbID").focus();
				
			}
		}
	});	
}

function pwdCheck() {	
	if($("#tbPwd").val() != ($("#cpass").val())){ 
	      alert("비밀번호가 다릅니다.");
	      $("#tbPwd").val("");
	      $("#cpass").val("");
	      $("#tbPwd").focus();
	      return false;
	}	
}

function emailCheck() {	 
	  // 이메일 검증 스크립트 작성
	  var emailVal = $("#email").val();
	  var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	  // 검증에 사용할 정규식 변수 regExp에 저장
	  if (emailVal.match(regExp) != null) {
	    alert("이메일을 올바르게 입력했습니다.");
	  }
	  else {
	    alert("이메일형식에 맞게 입력해주세요\nex)hello@sagong'ssi.com");
	    $("#email").val("");
	    $("#email").focus();  
	  }
}

function phoneCheck() {	
	var phoneVal = $("#phone").val();	
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
	if (phoneVal.match(regExp) != null) {
	   //alert("번호를 올바르게 입력했습니다.");
	}
	else {
	  alert("번호를 올바르게 입력해주세요\nex)010-XXXX-XXXX");
	  $("#phone").val("");
	  $("#phone").focus();  
	}
}

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
		
	function checkWidth() { // 윈도우 사이즈가 바뀔 때 보여주는 아이템 변경
		$("[name='large']").toggle($(window).width() >= 900);
		$("[name='small']").toggle($(window).width() < 900);
	}
	checkWidth();
	$(window).resize(checkWidth);
});
</script>

</head>
<body>
<div id="top-menu" >
<table border="0" align="center" width="100%" class="title_table">
<col width="100"><col width="300"><col width="300">

<tr name="small" style="display: none;">
	<td align="left">
		<p class="title" onclick="location.href='index.jsp'" style="margin-left: 5px; font-size: 1.3em" >SaGong'ssi</p>
	</td>
	<td align="right" name="small" style="display:none;">
		<% if(user==null){ // 로그아웃 상태 %>
			<button class="fill sagongBtn" id="titleBtn" href="#signup" data-toggle="modal" data-target=".log-sign">Sign In/Register</button>
		<%}else{ %>
			<img src='./images/profiles/<%=user.getId()%>.png' width='100px'
	            class='profile_img' align='middle'
	            onerror="this.src='images/profiles/default.png'">
		<span><%=user.getName() %>님 <span name="large">환영합니다.</span> <a href="MemberController?command=logout"><font size="2">로그아웃</font></a></span>	
		<div id="menuBtn" class="btn-group">
	  		<button type="button" class="fill sagongBtn" data-toggle="dropdown" aria-expanded="false">
				<span class="glyphicon glyphicon-menu-hamburger"></span>
	  		</button>
	  		<%if(user.getAuth() == 3){ // 관리자 로그인 상태 %>
				<ul class="mdropdown-menu" role="menu">
				    <li><a href="location.href='manager.jsp'">신고글 관리</a></li>				   
				</ul>
			<%}else{ // 일반회원 로그인 상태 %>
		  	<ul class="mdropdown-menu" role="menu">
			    <li><a href='MemberController?command=userPage&id=<%=user.getId()%>'>마이페이지</a></li>
			    <li><a href="pdswrite.jsp">사진 올리기</a></li>
			    <li><a href="myAlarms.jsp" name="alarm" >새소식(<%= alarmCount %>)</a></li>
			</ul>
			<%} %>		  
		</div> 
		<%} %>
	</td>
</tr>
<tr name="small" style="display: none;" >
	<td colspan="2" align="center">
		<form action="PdsController" method="get">
		<input type="hidden" name="command" value="keyword"> 
		<input class="search__input" type="text" name="tags" placeholder="Search" style="width: 95%">
		<input type="hidden" name="choice" value="SEQ"> 
		</form>
	</td>
</tr>

<tr name="large">	
	<td align="center" rowspan="2">
		<p class="title" onclick="location.href='index.jsp'" style="font-size: 2em">SaGong'ssi</p>
	</td>
	<td rowspan="2">
		<form action="PdsController" method="get">
		<input type="hidden" name="command" value="keyword"> 
		<input class="search__input" type="text" name="tags" placeholder="Search">
		<input type="hidden" name="choice" value="SEQ"> 
		</form>
	</td>
	
	<td align="center">
	<% if(user==null){ // 로그아웃 상태 %>
		<button class="fill sagongBtn" id="titleBtn" href="#signup" data-toggle="modal" data-target=".log-sign">Sign In/Register</button>
	<%}else{ %>
		<img src='images/profiles/<%=user.getId()%>.png' width='100px'
            class='profile_img' align='middle'
            onerror="this.src='images/profiles/default.png'">
		<span><%=user.getName() %>님 <span name="large">환영합니다.</span> <a href="MemberController?command=logout"><font size="2">로그아웃</font></a></span>
	</td>
</tr>
<tr>
	<td align="center" name="large">		
		<%if(user.getAuth() == 3){ // 관리자 로그인 상태 %>
			<button class="fill sagongBtn" onclick="location.href='manager.jsp'">신고글 관리</button>
		<%}else{ // 일반회원 로그인 상태 %>
			<button class="fill sagongBtn" onclick="location.href='MemberController?command=userPage&id=<%=user.getId()%>'"><font>마이페이지</font></button>
			<button class="fill sagongBtn" onclick="location.href='pdswrite.jsp'">사진 올리기</button>	
			<button class="fill sagongBtn" name="alarm" onclick="location.href='myAlarms.jsp'">새소식(<%= alarmCount %>)</button>	
		<%} %>	
		<%} %>		
	</td>	
</tr>
</table>
</div> 

<script>
var header = document.getElementById("top-menu");
var sticky = header.offsetTop;
function loginView(){
	$("#titleBtn").click();
}
function updateAlarm(newCount){
	$("[name='alarm']").text("새소식("+newCount+")");
}
</script>

	<!-- 로그인 -->
	<div class="modal fade bs-modal-sm log-sign" id="myModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
	<div class="modal-content">
	<div class="bs-example bs-example-tabs">
		<ul id="myTab" class="nav nav-tabs">
			<li id="tab1" class=" active tab-style login-shadow ">
				<a href="#signin" data-toggle="tab">Log In</a></li>
			<li id="tab2" class=" tab-style ">
				<a href="#signup" data-toggle="tab">Sign Up</a></li>
			</ul>
	</div>
	<div class="modal-body">
	<div id="myTabContent" class="tab-content">
	<div class="tab-pane fade active in" id="signin">
		<form class="form-horizontal" method="post" action="MemberController">
		<input type="hidden" name="command" value="login"> 	
		<input type="hidden" name="goBackTo" value="<%=goBackTo%>"> 		
		
				<fieldset>
				<!-- Sign In Form -->
				<!-- Text input-->

				<div class="group">
					<input required="required" class="input" name="id" type="text">
					<span class="highlight" ></span><span class="bar"></span> 
					<label class="label" for="date">ID</label>
				</div>


				<!-- Password input-->
				<div class="group">
					<input required="required" class="input" name="pwd" type="password">
					<span class="highlight"></span>
					<span class="bar"></span> 
					<label class="label" for="date">PW</label>
				</div>
				<!-- <em>minimum 6 characters</em> -->
				
				<div class="forgot-link">
            		<a href="#forgot" data-toggle="modal" data-target="#forgot-password"> I forgot my password</a>
            	</div>
				
				<!-- Button -->
				<div class="control-group">
					<label class="control-label" for="signin"></label>
					<div class="controls">
						<button id="signin" name="signin"
						class="btn btn-primary btn-block">Log In</button>
					</div>
				</div>
				</fieldset>
			</form>
		</div>


		<div class="tab-pane fade" id="signup">
			<form class="form-horizontal" action="MemberController"  method="post" id="regiform">
			<input type="hidden" name="command" value="regi"> 
				<fieldset>
					<!-- Sign Up Form -->
					<!-- ID input-->
					<div class="group">
						<input required="required" class="input" name="id" id="tbID" type="text" maxlength="12" onchange="idCheck()">
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">ID <span id="idcheck" style="font-size: 8px"></span></label>
					</div>

					<!--  Password input-->
					<div class="group">
						<input required class="input" name="pwd" id="tbPwd" type="password" maxlength="12" >
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">PW</label>
					</div>

					<!-- Password input-->
					<div class="group">
						<input required="required" class="input" id="cpass" type="password" maxlength="12" onchange="pwdCheck()" >
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">PW확인</label>
					</div>

					<!-- Name input-->
					<div class="group">
						<input required="required" class="input" name="name" type="text" maxlength="12" >
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">NAME</label>
					</div>

					<!-- Email input-->
					<div class="group">
						<input required="required" class="input" name="email" type="text" id="email" onchange="emailCheck()" placeholder="">
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">EMAIL</label>
					</div>
					
					<!-- Tel input-->
					<div class="group">
						<input required="required" class="input" name="phone" type="text" id="phone" onchange="phoneCheck()" placeholder=""> <!-- pattern="\d{3}-\d{3,4}-\d{4}" -->
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">PHONE</label>
					</div>


					<!-- Button -->
					<div class="control-group">
						<label class="control-label" for="confirmsignup"></label>
						<div class="controls">
							<button id="confirmsignup" name="confirmsignup"
								class="btn btn-primary btn-block">Sign Up</button>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
		</div>
		</div>				
		</div>
		</div>
	</div>	
	
<!--modal2-->

<div class="modal fade bs-modal-sm" id="forgot-password" tabindex="0" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
        <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">아이디/비밀번호 찾기</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
        <fieldset>
        <div class="group">
			<input required="required" class="input" type="email" id="emailC"><span class="highlight"></span><span class="bar"></span>
   			 <label class="label" for="date">Email 입력</label>
   		</div>
		 <div class="group">
			<input required="required" class="input" type="text"><span class="highlight"></span><span class="bar"></span>
   			 <label class="label" for="date">ID 입력</label>
   		</div>
   		 <div class="group">
			<input required="required" class="input" type="text"><span class="highlight"></span><span class="bar"></span>
   			 <label class="label" for="date">Phone 입력</label>
   		</div>		

        
        <div class="control-group">
              <label class="control-label" for="forpassword"></label>
              <div class="controls">
                <button id="forpasswodr" name="forpassword" class="btn btn-primary btn-block">Send</button>
              </div>
            </div>
          </fieldset>
          </form>
      </div>
    </div> 
    
  </div>
</div>




</body>
</html>