<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="upload-wrapper">
  <label for="upload" class="upload-label">
    <p>✨UPLOAD IMAGE ✨</p>
    <img class="upload-imgBtn" src="https://uploads.codesandbox.io/uploads/user/1dcc6c5f-ac13-4c27-b2e3-32ade1d213e9/2Go1-photo.svg">
  </label>
</div>
<!-- fileReader를 통해 읽은 파일을 넣는 부분 -->
<div class="image-preview"></div>
<input type="file" accept="image/*" id="upload" class="image-upload" style="display:none;" multiple>


<script type="text/javascript"></script>
</body>
</html>