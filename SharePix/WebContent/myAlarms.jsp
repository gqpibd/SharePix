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
</head>
<body>
	<div class="left__heading" style="height: 100%">
		<!-- 타이틀바 -->
		<jsp:include page="titlebar.jsp">
			<jsp:param name="goBackTo" value="index.jsp" />
		</jsp:include>
	</div>
	<div style="margin-top: 10em" >
		<table>
		<%for(int i=0;i<aList.size();i++){ 
		String type = (aList.get(i).getType()==AlarmBean.NEWPOST)?aList.get(i).getFromId()+"님의 새 게시글":aList.get(i).getFromId()+"님의 댓글";
		String fSaveName = pService.getPdsDetail(aList.get(i).getPdsSeq()).getfSaveName();
		%>
		
			<tr>
				<td> <img class="clickable" name="item" src="images/pictures/<%=fSaveName%>" onclick="veiwDetail(<%=aList.get(i).getSeq()%>,<%=aList.get(i).getPdsSeq()%>)" height="100" ></td>
				<td> <%=type %></td>
				<td><button onclick="deleteAlarm(<%=aList.get(i).getSeq()%>,this)"> 삭제 </button></td>
			</tr> 
		<%} %>
		</table>
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
	</script>
</body>
</html>