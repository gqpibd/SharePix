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
        width: 70%;
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

.search__input:hover,
        .search__input:focus {
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
</style> 


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style/loginModal.css">


<script type="text/javascript">

function MyFunction() {

	$.ajax({
		type:"get",
		url:"MemberController?command=idcheck&id="+$("#tbID").val(),
		data:"id=" + $('#tbID').val(),
		
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
	
}


function MyFunction01() {
	
	
	if($("#tbPwd").val() != ($("#cpass").val())){ 
	      alert("비밀번호가 다릅니다.");
	      $("#tbPwd").val("");
	      $("#cpass").val("");
	      $("#tbPwd").focus();
	      return false;
	     }
	
	
}

</script>




</head>
<body>

<div id="top-menu">
<table border="0" align="center" width="100%" class="title_table">
<col width="100"><col width="400"><col width="200">
	<tr>
	<td align="center">
		<p class="title" onclick="location.href='index.jsp'"><font size="5">SaGong'ssi</font></p>
	</td>
	<td>
		<input class="search__input" type="text" placeholder="Search">
	</td>
	<td align="center">
	<% if(user==null){ %>
		<button class="btn" href="#signup" data-toggle="modal" data-target=".log-sign">Sign In/Register</button>
		<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" style="margin-right: 5px;">로그인</button>
		<button type="button" class="btn btn-primary" onclick="location.href='regi.jsp'" style="margin-left: 5px;">회원가입</button> -->
	<%}else{ %>
		<h5><%=user.getName() %>님 환영합니다. <a href="MemberController?command=logout"><font size="2">로그아웃</font></a> </h5>
		<button onclick="location.href='myPage.jsp'">마이페이지</button>
		<button onclick="location.href='pdswrite.jsp'">사진 올리기</button>
		<button onclick="location.href='PdsController?command=myLikePdsList&id=<%=user.getId()%>'">즐겨찾기</button>
	<%} %>
	<!-- <input type="submit" value="로그인"> -->
	</tr>
</table>
</div> 

<script>
window.onscroll = function() {myFunction()};

var header = document.getElementById("top-menu");
var sticky = header.offsetTop;

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
					<input required="" class="input" name="id" type="text" autofocus><span
						class="highlight"></span><span class="bar"></span> <label
						class="label" for="date">ID</label>
				</div>


				<!-- Password input-->
				<div class="group">
					<input required="" class="input" name="pwd" type="password"><span
						class="highlight"></span><span class="bar"></span> <label
						class="label" for="date">PW</label>
				</div>
				<!-- <em>minimum 6 characters</em> -->
				
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
			<form class="form-horizontal" action="MemberController"  method="post">
			<input type="hidden" name="command" value="regi"> 
				<fieldset>
					<!-- Sign Up Form -->
					<!-- ID input-->
					<div class="group">
						<input required="" class="input" name="id" id="tbID" type="text" maxlength="12" onblur="MyFunction()">
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">ID <span id="idcheck" style="font-size: 8px"></span></label>
					</div>

					<!--  Password input-->
					<div class="group">
						<input required="" class="input" name="pwd" id="tbPwd" type="password" maxlength="12" >
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">PW</label>
					</div>

					<!-- Password input-->
					<div class="group">
						<input required="" class="input" id="cpass" type="password" maxlength="12" onblur="MyFunction01()" >
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">PW확인</label>
					</div>

					<!-- Name input-->
					<div class="group">
						<input required="" class="input" name="name" type="text" name="name" maxlength="12" >
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">NAME</label>
					</div>

					<!-- Email input-->
					<div class="group">
						<input required="" class="input" name="email" type="email">
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">EMAIL</label>
					</div>
					
					<!-- Tel input-->
					<div class="group">
						<input required="" class="input" name="phone" type="tel" pattern="\d{3}-\d{3,4}-\d{4}" > <!-- pattern="\d{3}-\d{3,4}-\d{4}" -->
						<span class="highlight"></span>
						<span class="bar"></span> 
						<label class="label" for="date">PHONE <span style="font-size: 8px">ex)010-6545-1894</span></label>
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

</body>
</html>
