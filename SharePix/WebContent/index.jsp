<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
<!-- 
<style type="text/css">
.center{
	margin: auto;
	width: 60%;
	border: 3px solid #8ac007;
	padding: 10px;
}
</style>
 -->
 
<!-- <link href="css/style0.css" rel="stylesheet" type="text/css" /> -->

<!-- <style type="text/css">
body {
	background: url(./image/back.jpg) no-repeat center top;
}
</style>  -->

</head>
<body>
 
<h1>Login</h1>
<p>환영합니다</p>

<div class="center">

<form method="post" action="MemberController">
<div style="padding: 100px 0 0 250px;">
<div id="login-box">
<h2>로그인 페이지</h2>
이 웹 사이트를 사용하려면 로그인해 주십시오.
<input type="hidden" name="command" value="loginAf">
<br>

<br>
<div id="login-box-name" style="margin-top:20px;">User Id:</div>
<div id="login-box-field" style="margin-top:20px;">
<input name="id" id="id" class="form-login" title="Username" value="" size="30" maxlength="50" />
</div>
<div id="login-box-name">Password:</div>
<div id="login-box-field">
<input name="pwd" type="password" class="form-login" title="Password" value="" size="30" maxlength="48" />
</div>
<br />
<span class="login-box-options">x
New User?  <a href="MemberController?command=addUserPage" style="margin-left:30px;">회원가입</a>

</span>
<br/>
<br/>
<input style="margin-left:100px;" type="submit" value="Login" />
</div>
</div>
</form>

</div> 
 
</body>
</html>








