<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="shortcut icon" href="images/icons/favicon.ico">

</head>
<body>


<script type="text/javascript">
myColor = new Array(
"000000","101010","202020","303030",
"404040","505050","606060","707070",
"808080","909090","A0A0A0","B0B0B0",
"C0C0C0","D0D0D0","E0E0E0","FFFFFF"
);

myCnt = 0;
function myFade(){
     if (myCnt != 16){
         document.bgColor = "#" + myColor[myCnt];
         myTime = ( myCnt==0 || myCnt==15 ) ? 3000 : 50;
         myCnt++;
         setTimeout( "myFade()", myTime );
     }else{
         location.href = "index.jsp";
    }
}
</script>
 
<br><br><br><br><br><br><br>
<p align="left">
<font color="#FFFFFF" size="5">
<strong>404 error: not found</strong>
</font><br><br>
<font color="#FFFFFF" size="6">
<strong>The URL you requested was not found.</strong>
</font><br><br>
<font color="#000000" size="6">
<strong>SaGong'ssi</strong>
</font><br>
</p>
 
 
<script type="text/javascript">
myFade();
</script>


</body>
</html>