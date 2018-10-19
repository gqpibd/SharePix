<%@page import="model.service.ReplyService"%>
<%@page import="dto.ReplyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String command = request.getParameter("command");
%>
<%if(command.equals("rere")){ 
String id = request.getParameter("id");
String toWhom = request.getParameter("toWhom");
String pdsSeq = request.getParameter("pdsSeq");
String reRef = request.getParameter("reRef");
%>
<li class='reply' id='rere_write' style="width: 95%">
	<div class='wrap' align='center' style="padding: 10px;background: #fff;margin:auto" >
		<form action='ReplyController'>
			<input type='hidden' name='command' value='addReply'> 
			<input type='hidden' name='id' value="<%=id%>"> 
			<input type='hidden' name='pdsSeq' value="<%=pdsSeq%>"> 
			<input type='hidden' name='refSeq' value="<%=reRef%>"> 
			<input type='hidden' name='toWhom' value="<%=toWhom%>">
			<div align='left'>
				<img src='images/profiles/<%=id%>.png' width='10'
					class='profile re-img' align='middle'
					onerror="this.src='images/profiles/default.png'"> 
				<span class='nickname'><%=id%></span>
				<textarea id='writeReply' placeholder="<%=toWhom%>님에게 댓글 작성" name='content'></textarea>
				<div align=right style='padding: 10px'>
					<button class='mybtn' type='submit'>등록</button>
				</div>
			</div>
		</form>
	</div>
</li>
<%}else if(command.equals("modify")){ //수정
String id = request.getParameter("id");
String content = request.getParameter("content");
String reSeq = request.getParameter("reSeq");
String pdsSeq = request.getParameter("pdsSeq");
%>

	
<li class='reply' style="width: 95%">
	<div class='wrap' align='center' style="padding: 10px;background: #fff;margin:auto" >
		<form action='ReplyController'>
			<input type='hidden' name='command' value='updateReply'>
			<input type='hidden' name='reSeq' value=<%=reSeq%>>
			<input type='hidden' name='pdsSeq' value=<%=pdsSeq%>>
			<div align='left'>
				<img src='images/profiles/<%=id%>.png' width='10'
					class='profile re-img' align='middle'
					onerror="this.src='images/profiles/default.png'"> 
				<span class='nickname'><%=id%></span>
				<textarea id='writeReply' name='content'><%=content%></textarea>
				<div align=right style='padding: 10px'>
					<button class='mybtn' type='submit'>수정</button>
					<button class='mybtn' type='button' onclick="deleteReply(<%=reSeq%>)">삭제</button>
					<button class='mybtn' type='button' onclick="cancel(this,<%=reSeq%>)">취소</button>
				</div>
			</div>
		</form>
	</div>
</li>
<%}else if(command.equals("cancel")){	
	String loginId = request.getParameter("loginId");
	String pdsWriter = request.getParameter("pdsWriter");
	int reSeq = Integer.parseInt(request.getParameter("reSeq"));
	ReplyBean re = ReplyService.getInstance().getReply(reSeq);
	String src = "images/profiles/"+re.getId()+".png";
	String srcError="images/profiles/default.png";
%>
	<li class="reply">
	<%if(re.getReSeq() != re.getReRef()){%> <!-- 대댓일 때 표시 -->
		<img src="images/icons/rere.png" style=" float: left; width: 20px; margin-right:13px">
	<%}
  	if(re.getDel() == 1){%> <!--  삭제된 댓글일 때 표시 --> 
		<div class="reply_content">삭제된 댓글입니다</div>
	<%}else{ // 댓글 표시
		if(loginId!=null && re.getId().equals(loginId)){ %> <!-- 작성자일 때 수정, 삭제 가능하게 -->  
		<div class="mtooltip" align="right">
			<img src="images/icons/more.png" width="3px" align="right" class="more img_clickable" > 
			<span class="mtooltiptext"> 
			<label onclick="modify('<%=re.getReSeq()%>','<%=re.getContent() %>')" id="<%=re.getReSeq()%>" class="aTag">수정</label><br> 
			<label onclick="deleteReply(<%=re.getReSeq()%>)" class="aTag">삭제</label><br>
			</span>
		</div>
    	<%}%>
    	<% if (re.getReSeq() != re.getReRef()) { %> <!-- 대댓일 때 들여쓰기 -->
			<div style="margin-left: 30px">
		<%}else{ %>
			<div>
		<%} %>
		<img src="<%=src%>" class="profile re-img img_clickable" width="10" onerror="this.src='<%=srcError%>'" 
			onclick="location.href='MemberController?command=userPage&id=<%= re.getId()%>'">
		<font style="font-size: 17px; font-weight: bold;"><%=re.getId()%></font>
			<% if(re.getId().equals(pdsWriter)){ %> <!-- 사진 올린사람 표시 -->
				<img src="images/icons/writer.png" width="60" style="vertical-align: middle">
			<%}%>
			<div class="reply_content">		
				<% if (re.getToWhom() != null & re.getToWhom() != "") { %> <!-- 다른 사람 호출하는 태그가 있을 때 --> 
				<b>@<%=re.getToWhom()%></b> 
				<% } %> 
				<%=re.getContent()%>
			<br> 
			<font style="font-size: 3px; color: graytext;"><%=re.getWdate()%></font><br> <!-- 날짜 -->
			<% if (loginId != null) { %>
			<button class="mybtn" name="<%=re.getReRef()%>" onclick="addReply(this)" id="<%=re.getReSeq()%>" toWhom="<%=re.getId()%>">답변</button>
			<% } %>									
		</div>
		</div>
	</li>
	<%}
}%>