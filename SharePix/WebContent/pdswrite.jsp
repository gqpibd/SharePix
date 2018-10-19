<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
<<<<<<< HEAD
   MemberBean user = (MemberBean)session.getAttribute("login");
   if(user == null){
      response.sendRedirect("index.jsp");
   }
=======
	MemberBean user = (MemberBean) session.getAttribute("login");
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<<<<<<< HEAD
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Lato:100,300,400">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:100">
<link rel="stylesheet" href="style/picDetail.css">



=======
<link href="css/style0.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdswrite.jsp</title>


<style>
.imgbox {
	position: relative;
	width: 500px;
	height: 400px;
	vertical-align: middle;
}

.holder {
<<<<<<< HEAD
	max-width: 500px;
=======
	/* width: 100%; */
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
	max-height: 400px;
<<<<<<< HEAD
	position: relative;
	z-index: -1;
=======
	max-width: 300px;
	position: absolute;
	top: 0;
	left: 0;
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
}

.upload {
	width: 500px;
	height: 400px;
	opacity: 0;
	cursor: pointer;
<<<<<<< HEAD
	position: absolute;
	top: 0;
	left: 0;
	z-index: 1;
}

.td1 {
	border-bottom: 1px solid #444444;
	padding: 10px;
	text-align: center;
}

.re-img { /* 댓글 프로필 */
	float: left;
	width: 33px;
	height: 33px;
	border-radius: 33px;
	margin: 5px;
	vertical-align: middle;
}

.td2 {
	border-bottom: 1px solid #444444;
	padding: 10px;
	text-align: center;
	font-size: 19px;
}


=======
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
}
</style>

<script type="text/javascript">
<<<<<<< HEAD
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

=======
	var fileReader = new FileReader();
	var filterType = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
	fileReader.onload = function(event) { // 파일이 로드 되었을 때
		var image = new Image(); // 새로운 이미지를 생성한다.
		image.onload = function() {
			document.getElementById("original-Img").src = image.src;
		}
		image.src = event.target.result;
		image.width = 500;
	};
	var loadImageFile = function() {
		var uploadImage = document.getElementById("upload-Image"); //파일 요소 가져와서

		//check and retuns the length of uploded file.
		if (uploadImage.files.length === 0) { // 업로드 된게 있는지 확인하고
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
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
</script>
</head>
<body onload="loadImageFile();">

	<div style="height: 100%">
		<!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>
	<div align="center" style="margin-top: 10em">
<<<<<<< HEAD
		<form action="FileController" method="post"
			enctype="multipart/form-data" id="pdswrite">
=======
		<form action="PdsController" method="post"
			enctype="multipart/form-data" id="pdswrite">
			<input type="hidden" name="command" value="pdsupload">
			<table border="1" bgcolor="white"
				style='border-left: 0; border-right: 0; border-bottom: 0; border-top: 0'>
				<col width="500">
				<col width="100">
				<tr align="center">
					<td colspan="2"><br>빈공간<br> <br></td>
				</tr>
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git

<<<<<<< HEAD
			<table border="0" bgcolor="white"
				style='border-left: 0; border-right: 0; border-bottom: 0; border-top: 0'>
				<col width="500px">
				<col width="100px">
=======
				<tr align="left">
					<td colspan="2"><br><%=user.getId()%> <br> <input
						type="hidden" name="id" value="<%=user.getId()%>"> <br>
					</td>
				</tr>
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git

				<tr align="center">
<<<<<<< HEAD
					<td class="td2" colspan="2">Image Upload<br>
					</td>
				</tr>
				<tr align="center">
					<td class="td1" colspan="2"><img
						src='images/profiles/<%=user.getId()%>.png' width='100px'
						class='profile re-img' align='middle'
						onerror="this.src='images/profiles/default.png'"> <br>
					</td>
				</tr>
				<tr>
					<td class="td1" align="center">
						 <div class="imgbox">
               <img class="holder" id="original-Img"/>
               <label id="mlabel" for="fileload" >
               	<br><br><br><br><br><br><br><br>
               	
               	<span class="glyphicon glyphicon-paperclip" aria-hidden="true" size = ></span>
               	드래그 하거나 클릭하여 업로드
               	<br>
               	
               	</label>
               <input type="file" name="fileload" accept="image/gif, image/jpeg, image/png" class="upload" id = "upload-Image" onchange="loadImageFile();" >               
            </div>
            
        
            
            
            
					<!-- 	<div class="container">
							<div class="gallery">
								<div class="gallery-item">
									<div class="gallery-item-image">
										<img src="http://www.blueb.co.kr/SRC2/_image/w01.jpg">
									</div>
									<div class="gallery-item-description">
										<h3>Image title</h3>
										<span>Lorem ipsum dolor sit amet, consectetur
											adipisicing elit. Dignissimos, quia.</span>
									</div>
								</div>
							</div>
						</div> -->
					
					</td>
					<td class="td1" border-botton="1">
						<!-- <select name="category" class="btn btn-default dropdown-toggle"><span class="caret"></span> -->

						<select name="category" class="btn btn-default dropdown-toggle">

							<option disabled value="카테고리" selected="selected" >카테고리</option>
=======
					<td colspan="2">이미지 추가<br>
					</td>
				</tr>

				<tr>
					<td align="center">
						<div class="imgbox">
							<img class="holder" id="original-Img" /> <input type="file"
								name="fileload" accept="image/gif, image/jpeg, image/png"
								class="upload" id="upload-Image" onchange="loadImageFile();">
							<label for="upload">드래그 하거나 클릭하여 업로드</label>
						</div>
					</td>
					<td border="1">
						<!-- <select name="category" class="btn btn-default dropdown-toggle"><span class="caret"></span> -->
						<select name="category">
							<option value="카테고리" selected="selected">카테고리</option>
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
							<option value="자연">자연</option>
							<option value="인물">인물</option>
							<option value="음식">음식</option>
							<option value="과학">과학</option>
							<option value="디자인">디자인</option>
							<option value="기타">기타</option>
					</select><br>
<<<<<<< HEAD
						<div class="input-group">
							<br>
							<br>
							<textarea class="form-control" rows="3" cols="20" name="tags"
								placeholder="태그(#구분)"></textarea>
						</div> <br>
					</td>
				</tr>
			</table>
			<div style="position: relative; float: bottom;">
				<!--  <input type="right" name="command" value="pdsupload"> -->
				<!-- <input align="right" type="submit"value="올리기"> -->
				<input class="fill sagongBtn" type="submit" value="올리기">
				<button class="fill sagongBtn" type="button"
					onclick="location.href='index.jsp'">나가기</button>


			</div>

=======
						<div>
							<textarea rows="2" cols="20" name="tags" placeholder="태그(#으로 구분)"></textarea>
						</div> <br>
					</td>
				</tr>
			</table>
			<div style="position: relative; float: bottom;">
				<!--  <input type="right" name="command" value="pdsupload"> -->
				<!-- <input align="right" type="submit"value="올리기"> -->
				<input type="submit" value="올리기">
			</div>
>>>>>>> branch 'JAEWOO' of https://github.com/gqpibd/SharePix.git
		</form>

	</div>
</body>
</html>