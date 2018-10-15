<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
MemberBean user = (MemberBean)session.getAttribute("login");
%>    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="css/style0.css" rel="stylesheet" type = "text/css"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdswrite.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
#holder {
	border: 10px dashed #ccc;
	width: 300px;
	min-height: 300px;
	margin: 20px auto;
}

#holder.hover {
	border: 10px dashed #0c0;
}

#holder img {
	display: block;
	margin: 10px auto;
}

#container {
	width: 300px;
	margin: 0px auto;
}

progress {
	width: 300px;
	margin: 0px auto;
}
</style>
<script type="text/javascript">
var fileReader = new FileReader();
var filterType = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
	
var loadImageFile = function () {
	    var uploadImage = document.getElementById("upload-img"); //파일 요소 가져와서
	    
	    //check and retuns the length of uploded file.
	    if (uploadImage.files.length === 0) {  // 업로드 된게 있는지 확인하고
	      return; 
	    }
	    
	    //Is Used for validate a valid file.
	    var uploadFile = document.getElementById("upload-img").files[0]; // 업로드된 파일중 첫 번째를 가져온다.
	    console.log(uploadFile);
	    if (!filterType.test(uploadFile.type)) {
	      alert("Please select a valid image."); 
	      return;
	    }
	    
	    fileReader.readAsDataURL(uploadFile); // 파일 리더를 이용해 파일을 읽는다
	}
	
	
	fileReader.onload = function (event) { // 파일이 로드 되었을 때
  var image = new Image(); // 새로운 이미지를 생성한다.
  
  image.onload=function(){
      document.getElementById("original-Img").src=image.src;      
  }
};
</script>
</head>
<body onload="loadImageFile();">
 
 <h2>자료 올리기</h2>
	<div align="center">
		<form action="PdsController" method="post" enctype="multipart/form-data" id="pdswrite">
		<input type="hidden" name="command" value="pdsupload">
		<table border="1" bgcolor="white"
			style='border-left: 0; border-right: 0; border-bottom: 0; border-top: 0'>
			<col width="200">
			<col width="500">

			<tr align="center">
				<td colspan="2"><br>빈공간<br>
				<br></td>
			</tr>

			<tr align="left">
				<td colspan="2"><br><%=user.getId()%> <br> <input
					type="hidden" name="id" value="<%=user.getId()%>"> <br>
				</td>
			</tr>

			<tr align="center">
				<td colspan="2">이미지 추가<br>
				</td>
			</tr>
			
			<tr>
				<td align="center">
				<input type="file" name="fileload" accept="image/gif, image/jpeg, image/png" style="width: 400px" id = "upload-img" onchange="loadImageFile();" >
				
				<div id="holder"> </div></td>
				<td border="1">
					<!-- 	<div style="position:relative; float:left; width:410px; text-align:left;"> -->
					<select name="category">

						<option value="카테고리" selected="selected">카테고리</option>

						<option value="자연">자연</option>

						<option value="인물">인물</option>

						<option value="음식">음식</option>

						<option value="과학">과학</option>

						<option value="디자인">디자인</option>

						<option value="기타">기타</option>

				</select>
					<p></p> <!--      </div> --> <br>
				<br>
					<div style="position: relative; float: left; width: 410px; text-align: left;">
						<textarea rows="2" cols="20" name="tags" placeholder = "태그(#으로 구분)"></textarea>
					</div> <br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<img id="original-Img"/>
					<div style="position: relative; float: right; width: 410px;">
						<!--  <input type="right" name="command" value="pdsupload"> -->
						<!-- <input align="right" type="submit"value="올리기"> -->
					<input type="submit" value="올리기">
					</div>

				</td>
			</tr>
		</table>
		</form>

	</div>



	<script>
var holder = document.getElementById('holder');
var progress = document.getElementById('uploadprogress');
     
holder.ondragover = function () { this.className = 'hover'; return false; };
holder.ondragend = function () { this.className = ''; return false; };
holder.ondrop = function (e) {
    this.className = '';
    e.preventDefault();
    readfiles(e.dataTransfer.files);
}

 
function readfiles(files) {
    // 파일 미리보기
    previewfile(files[0]);
     
    var formData = new FormData();
    formData.append('upload', files[0]);
 
    var xhr = new XMLHttpRequest();
    xhr.open('POST', './devnull.php');
    xhr.onload = function() {
        progress.value = 100;
    };

    xhr.upload.onprogress = function (event) {
        if (event.lengthComputable) {
            var complete = (event.loaded / event.total * 100 | 0);
            progress.value = progress.innerHTML = complete;
        }
    }

    xhr.send(formData);
}
 
function previewfile(file) {
    var reader = new FileReader();
    reader.onload = function (event) {
        var image = new Image();
        image.src = event.target.result;
        image.width = 250; // a fake resize
        holder.appendChild(image);
    };

    reader.readAsDataURL(file);
}

	


</script>




<!-- <script>
	$("#submit").onclick(function(){		
		$("#frm").submit();
	});
	
</script> -->




</body>
</html>







