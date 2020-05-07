<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>

<body>
  <img id="original-Img" src="images/pictures/test.jpg"/><br>
  <script type="text/javascript">
	var fileReader = new FileReader();
	var filterType = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
	document.addEventListener("DOMContentLoaded", function(){ // $(document).ready();
		var image = new Image(); // 새로운 이미지를 생성한다.
		
		image.src=document.getElementById("original-Img").src;
		var canvas=document.createElement("canvas");
		var context=canvas.getContext("2d");
		canvas.width=image.width/2;
		canvas.height=image.height/2;
			context.drawImage(image,
		       0,
		       0,
		       image.width,
		       image.height,
		       0,
		       0,
		       canvas.width,
		       canvas.height
		   );
		   
		document.getElementById("original-Img").src = canvas.toDataURL();
		
	});
</script>
</body>
</html>