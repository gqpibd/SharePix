<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="utils.CollenctionUtil"%>
<%@page import="model.service.PdsService"%>
<%@page import="dto.PdsBean"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   MemberBean user = (MemberBean)session.getAttribute("login");
   
   
   HashMap<String,Integer> tagMap = CollenctionUtil.getHashMap(PdsService.getInstance().getSearchPds(""));	
   Iterator<String> it = CollenctionUtil.sortByValueReverse(tagMap).iterator();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:100,300,400">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100">
<link rel="shortcut icon" href="images/icons/favicon.ico">

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
	max-width: 500px;
	max-height: 400px;
	position: relative;
	z-index: -1;
}

.upload {
	width: 500px;
	height: 400px;
	opacity: 0;
	cursor: pointer;
	position: absolute;
	top: 0;
	left: 0;
	z-index: 1;
}

.td1 {
	border-bottom: 1px solid #444444;
	padding: 10px;
	text-align: center;
	/* color: #4a89dc !important; */
}

.td2 {
	border-bottom: 1px solid #444444;
	padding: 10px;
	text-align: center;
	font-size: 19px;
	/* color: #4a89dc !important; */
	



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
	  if (uploadImage.files.length == 0) {  // 업로드 된게 있는지 확인하고
	    return; 
	  }
	  /* for(i=0;i<uploadImage.files.length;i++){ // 파일이 여러개일 때
		  console.log(document.getElementById("upload-Image").files[i].name);
	  } */
	  
	  //Is Used for validate a valid file.
	  var uploadFile = document.getElementById("upload-Image").files[0]; // 업로드된 파일중 첫 번째를 가져온다.
	  
	  if (!filterType.test(uploadFile.type)) {
	    alert("Please select a valid image."); 
	    return;
	  }	  
	  fileReader.readAsDataURL(uploadFile); // 파일 리더를 이용해 파일을 읽는다
}

</script>
</head>
<body onload="loadImageFile();">
	<%if(user == null){%> 
		<script type="text/javascript">
			loginView();
		</script>
	<%} %>
   
	<div style="height: 100%">
		<!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>
	<div align="center" style="margin-top: 10em">
		<form action="FileController" method="post" enctype="multipart/form-data" id="pdswrite">
			<input type="hidden" name="command" value="upload">
			<input type="hidden" name="id" value="<%=user.getId()%>">

			<table border="0" bgcolor="white"
				style='border-left: 0; border-right: 0; border-bottom: 0; border-top: 0'>
				<col width="500px">
				<col width="300px">

				<tr align="center">
					<td class="td2" colspan="2">Image Upload<br>
					</td>
				</tr>
				<tr align="center">
					<td class="td1" colspan="2"><img
						src='images/profiles/<%=user.getId()%>.png' width='100px'
						class='profile_img' align='middle'
						onerror="this.src='images/profiles/default.png'"> <br>
					</td>
				</tr>
				<tr>
					<td class="td1" align="center">
						 <div class="imgbox">
               <img class="holder" id="original-Img"/>
               
               <label id="mlabel" for="fileload" >
               	<br><br><br><br><br><br><br><br>
               	
               	<span class="glyphicon glyphicon-paperclip" aria-hidden="true"  ></span>
               	드래그 하거나 클릭하여 업로드
               	<br>
               	
               	</label>
               <input type="file" name="fileload" accept="image/gif, image/jpeg, image/png" class="upload" id = "upload-Image" onchange="loadImageFile();" >               
            </div>
	
					</td>
					<td class="td1">
						<!-- <select name="category" class="btn btn-default dropdown-toggle"><span class="caret"></span> -->
						<div align="center">
						<select name="category" class="btn btn-default dropdown-toggle">
							<option value="카테고리" selected="selected" >카테고리</option>
							<option value="자연">자연</option>
							<option value="인물">인물</option>
							<option value="음식">음식</option>
							<option value="과학">과학</option>
							<option value="디자인">디자인</option>
							<option value="기타">기타</option>
						</select>
						</div><br>
						<div style="width: 95%; margin: 15px">							
							<textarea class="form-control" name="tags" id="tagArea" placeholder="태그(#구분)"></textarea>
						</div><br>
						<p style="margin-top: 5px; margin-bottom: 5px; font-weight: bold;">이런 태그가 필요해요</p>
						<div id="tags" align="center">
							
							<%
							if(it!=null){
							int iter = 0; // 지금 위치가 몇 번째인지 갯수를 세자
							while(it.hasNext()) {		
								String temp = (String) it.next();
							%>
								<span class="tag" onclick="addTag('<%=temp%>')" style="font-size: 15px; padding: 7px; margin: 2px">#<%=temp%></span>	
							<%
								iter++;
								if(iter>18){ 
								 	break;
								}
							}}%>
							</div>
						
					</td>
				</tr>
			</table>
			
			<div style="position: relative; float: bottom;">
				<!--  <input type="right" name="command" value="pdsupload"> -->
				<!-- <input align="right" type="submit"value="올리기"> -->
				<input class="fill sagongBtn" type="button" onclick="checkAndSubmit()" value="올리기">
				<button class="fill sagongBtn" type="button" onclick="location.href='index.jsp'">나가기</button>
			</div>

		</form>
		</div>
	<script type="text/javascript">
		function addTag(tagName) {
			$("#tagArea").val($("#tagArea").val() + "#" + tagName);
		}
		function checkAndSubmit(){
			if($("select[name='category']").val() == "카테고리"){
				alert("카테고리를 입력해 주세요");
				$("select[name='category']").focus();
				return;
			}else{
				$("#pdswrite").submit();
			}
		}
		
	</script>
</body>
</html>