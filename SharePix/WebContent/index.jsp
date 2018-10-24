<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Cute+Font|Gamja+Flower" rel="stylesheet">
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
         myTime = ( myCnt==0 ) ? 2500 : 50;
         $(".after").css("color","#" + myColor[15-myCnt]);
         myCnt++;
         if(myCnt==15){            	
        	 setTimeout( "myFade2()", 1000 );
         }
         setTimeout( "myFade()", myTime );
     }else{
        //location.href = 'main.jsp'
        return;
    }
}
function myFade2(){
	$("#div1").toggle( "slide" );
	$("#div2").toggle( "slide" );
	$("#div3").toggle( "slide" );
	setTimeout( function () {
		location.href = 'main.jsp'
	}, 2000 );
};
</script>
 
<br><br><br><br><br><br><br>
<p align="left">
<font color="#FFFFFF" size="5">
<strong>Status 404</strong>
</font><br><br>
<font color="#FFFFFF" size="6">
<strong><label class="after">Page</label> not found.</strong>
</font>
</p>

<div class="after" style="font-family: 'Cute Font', cursive;">
<font color="#000000" style="font-size:60px">사</font>
<font color="#000000" style="font-size:30px"><label style="display:none" id="div1">진</label></font>
<font color="#000000" style="font-size:60px">공</font>
<font color="#000000" style="font-size:30px"><label style="display:none" id="div2">유</label></font>
<font color="#000000" style="font-size:60px">사</font>
<font color="#000000" style="font-size:30px"><label style="display:none" id="div3">이트</label></font>
</div>
<p>
<font color="#000000" size="6">
<strong>SaGong'sa</strong>
</font><br>
</p>
 
 
<script type="text/javascript">
myFade();
</script>


</body>
</html>