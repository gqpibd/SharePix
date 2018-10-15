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
</head>
<body>

<h2>자료 올리기</h2>

<form action="pdsupload.jsp" method="post" enctype="multipart/form-data" id="frm">


<div align="center">

<table border="1" bgcolor="white" style='border-left:0;border-right:0;border-bottom:0;border-top:0'>
<col width="200"><col width="500">

<tr align="center">
   <td colspan="2"><br>빈공간<br><br>
   </td>
</tr>

<tr align="left">

   <td colspan="2"><br><%=user.getId() %>
      <br>
      <input type="hidden" name="id" value="<%=user.getId() %>">
      <br>
   </td>
</tr>

<tr align="center">
   <td colspan="2">이미지 추가<br>
   </td>
</tr>

<tr>
	<td align="center">
		<input type="file" name="fileload" accept="image/gif, image/jpeg, image/png" style="width: 400px">
		<style>
	#holder { border: 10px dashed #ccc; width: 300px; min-height: 300px; margin: 20px auto;}
	#holder.hover { border: 10px dashed #0c0; }
	#holder img { display: block; margin: 10px auto; }
 
 
	#container { width: 300px; margin: 0px auto;}
	progress { width: 300px; margin: 0px auto; }
	</style>
	<div id="holder">
	</div> 
	이미지 파일을 드래그하여 미리 확인할 수 있습니다(※주의 : 등록은 위에 파일선택으로)
	</td>
	 <td border="1">
<!-- 	<div style="position:relative; float:left; width:410px; text-align:left;"> -->
	<select name="category">

            <option value="카테고리" selected="selected"> 카테고리 </option>

            <option value="가"> 가 </option>
 
            <option value="나"> 나 </option>

            <option value="다"> 다 </option>
            
            </select> <p>
            </p>
       <!--      </div> -->
	<br><br>
	<div style="position:relative; float:left; width:410px; text-align:left;">
   <textarea rows="2" cols="20" name="tags">태그(#으로 구분)</textarea>
   </div>
   <br><br><br><br><br><br><br><br><br><br><br><br>
   <div style="position:relative; float:right; width:410px;">
   <input align="right" type="submit"value="올리기">

   </div> 

   </td>
</tr>



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


</table>

</div>

</form>

<!-- <script>
	$("#submit").onclick(function(){		
		$("#frm").submit();
	});
	
</script> -->




</body>
</html>







