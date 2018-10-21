<%@page import="dto.PdsBean"%>
<%@page import="model.service.PdsService"%>
<%@page import="dto.AlarmBean"%>
<%@page import="java.util.List"%>
<%@page import="model.service.AlarmService"%>
<%@page import="dto.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberBean user = (MemberBean) session.getAttribute("login");
	List<AlarmBean> aList= null;
	if(user!=null){
		aList = AlarmService.getInstance().getAlarmList(user.getId()); 
	}
	PdsService pService = PdsService.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="shortcut icon" href="images/icons/favicon.ico">
<style type="text/css">
body {
  font-family: 'lato', sans-serif;
}

.alarms {
  max-width: 1000px;
  margin-left: auto;
  margin-right: auto;
  padding-left: 10px;
  padding-right: 10px;
}

h2 {
  font-size: 26px;
  margin: 20px 0;
  text-align: center;
}
h2 small {
  font-size: 0.5em;
}

.responsive-table li {
  border-radius: 3px;
  padding: 25px 30px;
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}
.responsive-table .table-row {
  background-color: #ffffff;
  box-shadow: 0px 0px 9px 0px rgba(0, 0, 0, 0.1);
  cursor: pointer;
}
.responsive-table .col-1 {
  flex-basis: 10%;
}
.responsive-table .col-2 {
  flex-basis: 20%;
}
.responsive-table .col-3 {
  flex-basis: 15%;
}
.responsive-table .col-4 {
  flex-basis: 45%;
}
.responsive-table .col-4 {
  flex-basis: 10%;
}
@media all and (max-width: 767px) {
  .responsive-table li {
    display: block;
  }
  .responsive-table .col {
    flex-basis: 100%;
  }
  .responsive-table .col {
    display: flex;
    padding: 10px 0;
  }
  .responsive-table .col:before {
    color: #6C7A89;
    padding-right: 10px;
    content: attr(data-label);
    flex-basis: 50%;
    text-align: right;
  }
}

/* x 버튼 */
button:focus {
  outline: none;
}
.circCont {
  display: inline-block;
}

.circle {
  width: 40px;
  height: 40px;
  background: transparent;
  border: 4px solid #e91e63;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
  position: relative;
  cursor: pointer;
  display: inline-block;
  margin: 10px 20px;
}
.circle:after {
  width: 24px;
  height: 4px;
  background-color: #e91e63;
  content: "";
  left: 50%;
  top: 50%;
  margin-left: -12px;
  margin-top: -2px;
  position: absolute;
  -moz-transform: rotate(-45deg);
  -ms-transform: rotate(-45deg);
  -webkit-transform: rotate(-45deg);
  transform: rotate(-45deg);
  /*@include transform-origin(100%,100%);*/
}
.circle:before {
  left: 50%;
  top: 50%;
  margin-left: -12px;
  margin-top: -2px;
  width: 24px;
  height: 4px;
  background-color: #e91e63;
  content: "";
  position: absolute;
  -moz-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
  transform: rotate(45deg);
  /*@include transform-origin(0%,0%);*/
}

.circle[data-animation="xMarks"] {
  border: 0px solid white;
  overflow: hidden;
  -moz-box-shadow: 0px 0px 0px 0px #e91e63 inset;
  -webkit-box-shadow: 0px 0px 0px 0px #e91e63 inset;
  box-shadow: 0px 0px 0px 0px #e91e63 inset;
  -moz-transition: cubic-bezier(0.175, 0.885, 0.52, 1.775) 200ms;
  -o-transition: cubic-bezier(0.175, 0.885, 0.52, 1.775) 200ms;
  -webkit-transition: cubic-bezier(0.175, 0.885, 0.52, 1.775) 200ms;
  transition: cubic-bezier(0.175, 0.885, 0.52, 1.775) 200ms;
}
.circle[data-animation="xMarks"]:before, .circle[data-animation="xMarks"]:after {
  -moz-transition: cubic-bezier(0.175, 0.885, 0.52, 1.775) 200ms;
  -o-transition: cubic-bezier(0.175, 0.885, 0.52, 1.775) 200ms;
  -webkit-transition: cubic-bezier(0.175, 0.885, 0.52, 1.775) 200ms;
  transition: cubic-bezier(0.175, 0.885, 0.52, 1.775) 200ms;
}
.circle[data-animation="xMarks"]:not(.xMarks):hover {
  -moz-box-shadow: 0px 0px 0px 6px #e91e63 inset;
  -webkit-box-shadow: 0px 0px 0px 6px #e91e63 inset;
  box-shadow: 0px 0px 0px 6px #e91e63 inset;
}
.circle[data-animation="xMarks"]:not(.xMarks):hover:before {
  -moz-transform: scale(0.7) rotate(45deg);
  -ms-transform: scale(0.7) rotate(45deg);
  -webkit-transform: scale(0.7) rotate(45deg);
  transform: scale(0.7) rotate(45deg);
  -moz-transition-delay: 100ms;
  -o-transition-delay: 100ms;
  -webkit-transition-delay: 100ms;
  transition-delay: 100ms;
}
.circle[data-animation="xMarks"]:not(.xMarks):hover:after {
  -moz-transform: scale(0.7) rotate(-45deg);
  -ms-transform: scale(0.7) rotate(-45deg);
  -webkit-transform: scale(0.7) rotate(-45deg);
  transform: scale(0.7) rotate(-45deg);
  -moz-transition-delay: 100ms;
  -o-transition-delay: 100ms;
  -webkit-transition-delay: 100ms;
  transition-delay: 100ms;
}

.circle.xMarks {
  -moz-transition: -moz-transform 400ms ease-out, opacity 200ms ease-in;
  -o-transition: -o-transform 400ms ease-out, opacity 200ms ease-in;
  -webkit-transition: -webkit-transform 400ms ease-out, opacity 200ms ease-in;
  transition: transform 400ms ease-out, opacity 200ms ease-in;
  -moz-transition-delay: opacity 100ms;
  -o-transition-delay: opacity 100ms;
  -webkit-transition-delay: opacity 100ms;
  transition-delay: opacity 100ms;
  -moz-transform: scale(2);
  -ms-transform: scale(2);
  -webkit-transform: scale(2);
  transform: scale(2);
  opacity: 0;
  -moz-box-shadow: 0px 0px 0px 20px #e91e63 inset;
  -webkit-box-shadow: 0px 0px 0px 20px #e91e63 inset;
  box-shadow: 0px 0px 0px 20px #e91e63 inset;
}
.circle.xMarks:before {
  background-color: white;
  -moz-transform: scale(2) rotate(45deg);
  -ms-transform: scale(2) rotate(45deg);
  -webkit-transform: scale(2) rotate(45deg);
  transform: scale(2) rotate(45deg);
}
.circle.xMarks:after {
  background-color: white;
  -moz-transform: scale(2) rotate(-45deg);
  -ms-transform: scale(2) rotate(-45deg);
  -webkit-transform: scale(2) rotate(-45deg);
  transform: scale(2) rotate(-45deg);
}

</style>
<link rel="stylesheet" href="style/common.css">
</head>
<body>
	<div class="left__heading" style="height: 100%">
		<!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>

	<div class="alarms" style="margin-top: 10em" >
		<%if(aList.size()==0){%>
			<h2>새로운 소식이 없습니다</h2>
		<% }else{%>
			<ul class="responsive-table">
		<% for(int i=0;i<aList.size();i++){ 
			String type = "";
			String content = aList.get(i).getContent();
			PdsBean pds = pService.getPdsDetail(aList.get(i).getPdsSeq());
			if(aList.get(i).getType()==AlarmBean.NEWPOST){
				type = aList.get(i).getFromId()+"님의 새 게시글이 올라왔어요";
			}else{
				type = aList.get(i).getFromId()+"님이 댓글을 달았어요";
			}
			String fSaveName = pService.getPdsDetail(aList.get(i).getPdsSeq()).getfSaveName();
		%>		
		<li class="table-row" onclick="veiwDetail(<%=aList.get(i).getSeq()%>,<%=aList.get(i).getPdsSeq()%>)">
		 	<div class="col col-1" data-label="작성자 프로필"> 
		 		<img class="profile_img" name="item" src="images/profiles/<%=aList.get(i).getFromId()%>.png"  >
		 	</div>
			<div class="col col-2" data-label="내용"> <%=type %></div>
			<div class="col col-3" data-label="관련 게시글">
				<img name="item" src="images/pictures/<%=fSaveName%>"  height="50" ></div>
			<div class="col col-4" data-label="관련 게시글">
			<button class="circle" data-animation="xMarks" data-remove="3000" onclick="deleteAlarm(<%=aList.get(i).getSeq()%>,this)"></button>
			</div>
		</li>
		
		<%}} %>
		</ul>
	</div>
	<script type="text/javascript">
	function veiwDetail(aSeq,pSeq) {
	    location.href="PdsController?command=readAlarm&alarmSeq=" + aSeq + "&pdsSeq="+pSeq;
	 };
	 function deleteAlarm(aSeq,item){
		 $.ajax({
				url:"PdsController", // 접근대상
				type:"get",		// 데이터 전송 방식
				data:"command=deleteAlarm&id=<%=user.getId()%>&seq="+aSeq, // 전송할 데이터
				success:function(data, status, xhr){
					$(item).parent().parent().remove();
					updateAlarm(data.trim());
				},
				error:function(){ // 또는					 
					console.log("통신실패!");
				}
			});
	 }
	 
	 
	 $('.circle').on('click',function(){
		  var animClass = $(this).data('animation');
		  var removeTime = $(this).data('remove');
		  if($(this).hasClass(animClass)){
		     $(this).removeClass(animClass);
		  }else{
		    $(this).addClass(animClass);
		    if(typeof removeTime != 'undefined'){
		      var el = $(this);
		       setTimeout(function(){
		         el.removeClass(animClass);
		       },removeTime);
		    }
		  }
		});
	</script>
</body>
</html>