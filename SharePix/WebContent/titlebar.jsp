<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberBean user = (MemberBean) session.getAttribute("login");

	String goBackTo = request.getParameter("goBackTo");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
#top-menu {
  width: 100%;
  background-color: #F6F6F6;
  top: 0px;
  left: 0px;
  position: fixed;
  z-index: 1; 
}

.title_table {
	margin-top: 10px;
	margin-bottom: 10px;
}

.search__input {
	width: 100%;
	padding: 12px 24px;
	
	background-color: transparent;
	transition: transform 250ms ease-in-out;
	font-size: 14px;
	line-height: 18px;
	
	color: #575756;
	background-color: transparent;
	background-image: url(http://mihaeltomic.com/codepen/input-search/ic_search_black_24px.svg);
	background-repeat: no-repeat;
	background-size: 18px 18px;
	background-position: 95% center;
	border-radius: 50px;
	border: 1px solid #575756;
	transition: all 250ms ease-in-out;
	backface-visibility: hidden;
	transform-style: preserve-3d;
}
    
.search__input::placeholder {
            color: rgba(87, 87, 86, 0.8);
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

.search__input:hover, .search__input:focus {
            padding: 12px 0;
            outline: 0;
            border: 1px solid transparent;
            border-bottom: 1px solid #575756;
            border-radius: 0;
            background-position: 100% center;
        }        
.title{
	text-transform: uppercase; 
	letter-spacing: 1.5px;
	font-weight: bold;
}
.title:hover{
	cursor: pointer;
}

.fill:hover,
.fill:focus {
  box-shadow: inset 0 0 0 2em var(--hover);
}

.fill {
  --color: #8C8C8C;
  --hover: #1973bc;
}

.sagongBtn {
  background: none;
  border: 0px solid;
  font: inherit;
  border-radius: 12px;
  line-height: 1;
  margin: 0.5em;
  padding: 0.5em 1em;
}

.sagongBtn:focus{
	outline: none;
}

.sagongBtn {
  color: var(--color);
  transition: 0.25s;
}

.sagongBtn:hover, .sagongBtn:focus {
  border-color: var(--hover);
  color: #fff;
}
.outline{
	border:0;
	outline: none;
}


</style> 


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<link rel="stylesheet" href="style/loginModal.css">
<link rel="stylesheet" href="style/common.css">


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
	   alert("번호를 올바르게 입력했습니다.");
	  }
	  else {
	    alert("번호를 올바르게 입력해주세요\nex)010-XXXX-XXXX");
	    $("#phone").val("");
	    $("#phone").focus();  
	  }
	
	
}

function emailCheck() {
	
	
	
	
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
})
</script>




</head>
<body>
<div id="top-menu" >
<table border="0" align="center" width="100%" class="title_table">
<col width="100"><col width="300"><col width="300">
<tr>
	<td align="center" rowspan="2">
		<p class="title" onclick="location.href='index.jsp'"><font size="5">SaGong'ssi</font></p>
	</td>
	<td rowspan="2">

		<form action="PdsController" method="get">
		<input type="hidden" name="command" value="keyword"> 
		<input class="search__input" type="text" name="tags" placeholder="Search">
		<input type="hidden" name="choice" value="SEQ"> 
		<!-- <input class="searchbtn1" type="submit" value=""> -->
		</form>
	</td>
	<td align="center" class="mar">
	<% if(user==null){ %>
		<button class="fill sagongBtn" id="titleBtn" href="#signup" data-toggle="modal" data-target=".log-sign">Sign In/Register</button>
		<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" style="margin-right: 5px;">로그인</button>
		<button type="button" class="btn btn-primary" onclick="location.href='regi.jsp'" style="margin-left: 5px;">회원가입</button> -->
	<%}else if(user!=null && user.getAuth() != 3){ %>
		<img src='images/profiles/<%=user.getId()%>.png' width='100px'
            class='profile_img' align='middle'
            onerror="this.src='images/profiles/default.png'">
		<span><%=user.getName() %>님 환영합니다. <a href="MemberController?command=logout"><font size="2">로그아웃</font></a></span>
	</td>
	</tr>
	<tr>
	<td align="center" class="mar">

		<button class="fill sagongBtn" onclick="location.href='MemberController?command=userPage&id=<%=user.getId()%>'"><font>마이페이지</font></button>
		
		<button class="fill sagongBtn" id=picupload onclick="location.href='pdswrite.jsp'">사진 올리기</button>
		
<!-- 		<button class="fill sagongBtn"><span class="glyphicon glyphicon-option-horizontal" aria-hidden="true"></span></button>
		<ul class="dropdown-menu" role="menu">
 	  		 <li><a href="#">하나</a></li>
 	 	 	 <li><a href="#">둘</a></li>
 	  		 <li><a href="#">셋</a></li>
 		</ul> -->

 		<div class="btn-group">
  	<button type="button" class="fill sagongBtn" data-toggle="dropdown" aria-expanded="false">
   	  <span class="glyphicon glyphicon-option-horizontal"></span>
  </button>
  <ul class="dropdown-menu" role="menu">
    <li><a href='MemberController?command=userPage&id=<%=user.getId()%>'>마이페이지</a></li>
    <li><a href="pdswrite.jsp">사진 올리기</a></li>
    <li><a href="#">알림</a></li>
  </ul>
</div>
 		
 		
 		
	</td>
	
	<%} else if(user!=null && user.getAuth() == 3){ %>
	<img src='images/profiles/<%=user.getId()%>.png' width='100px'
            class='profile_img' align='middle'
            onerror="this.src='images/profiles/default.png'">
		<span><%=user.getName() %>님 환영합니다. <a href="MemberController?command=logout"><font size="2">로그아웃</font></a></span>
	</td>
	</tr>
	<tr>
	<td align="center" class="mar">
	
				<button class="fill sagongBtn" onclick="location.href='manager.jsp'">관리자모드</button></td>
			<%}//좋아요 다른데가요 ?네 근데 아이디를 굳이 안 보내도 될거같아요 끝되나 실행해볼까요 넵 !%> 
			
</tr>
</table>
</div> 

<script>
var header = document.getElementById("top-menu");
var sticky = header.offsetTop;
function loginView(){
	$("#titleBtn").click();
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
	
<%-- 	<form method="post" action="MemberController">
		<input type="hidden" name="command" value="login"> 	
		<input type="hidden" name="goBackTo" value="<%=goBackTo%>"> 		
		 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="exampleModalLabel">로그인</h4>
		      </div>
		      
		      
		      <div class="modal-body">		       
		          <div class="form-group">
		            <label for="recipient-name" class="control-label">아이디:</label>
		            <input type="text" class="form-control" id="recipient-name" name="id" title="Username">
		          </div>
		          <div class="form-group">
		            <label for="message-text" class="control-label">패스워드:</label>
		            <input type="password" class="form-control" id="message-text" name="pwd" title="Password">
		          </div>
	          </div>
	          
	          
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='regi.jsp'">회원가입</button>
			        <button type="submit" class="btn btn-primary" value="로그인">로그인</button>
			      </div>
		    </div>
		  </div>
		</div>
	</form>  --%>

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