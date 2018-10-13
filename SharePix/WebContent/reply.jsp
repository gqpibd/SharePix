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
<li class='reply' id='rere_write'>
	<div class='wrap' align='center'>
		<form action='ReplyController'>
			<input type='hidden' name='command' value='addReply'> 
			<input type='hidden' name='id' value="<%=id%>"> 
			<input type='hidden' name='pdsSeq' value="<%=pdsSeq%>"> 
			<input type='hidden' name='refSeq' value="<%=reRef%>"> 
			<input type='hidden' name='toWhom' value="<%=toWhom%>">
			<div style='padding-left: 30px' align='left'>
				<img src='images/profiles/<%=id%>.png' width='10'
					class='profile re-img' align='middle'
					onerror="this.src='images/profiles/default.png'"> 
				<span class='nickname'><%=id%></span>
				<textarea id='writeReply' placeholder="<%=toWhom%>님에게 댓글 작성" name='content'></textarea>
				<div align=right style='padding: 10px'>
					<button class='btn-like' type='submit'>등록</button>
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
<li class='reply'>
	<div class='wrap' align='center'>
		<form action='ReplyController'>
			<input type='hidden' name='command' value='updateReply'>
			<input type='hidden' name='reSeq' value=<%=reSeq%>>
			<input type='hidden' name='pdsSeq' value=<%=pdsSeq%>>
			<div style='padding-left: 30px' align='left'>
				<img src='images/profiles/<%=id%>.png' width='10'
					class='profile re-img' align='middle'
					onerror="this.src='images/profiles/default.png'"> 
				<span class='nickname'><%=id%></span>
				<textarea id='writeReply' name='content'><%=content%></textarea>
				<div align=right style='padding: 10px'>
					<button class='btn-like' type='submit'>수정</button>
					<button class='btn-like' type='button' onclick="deleteReply(<%=reSeq%>)">삭제</button>
					<button class='btn-like' type='button' onclick="cancel(this,<%=reSeq%>)">취소</button>
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
		<div class="tooltip" align="right">																		
			<img src="images/icons/more.png" width="3px" align="right" class="more">							
			<span class="tooltiptext">									
				<label onclick="modify('<%=re.getReSeq()%>')" id="<%=re.getReSeq()%>" class="aTg">수정</label><br>
				<label onclick="deleteReply(<%=re.getReSeq()%>)" class="aTag">삭제</label><br>
			</span>
		</div>
    	<%}%>
		<img src="<%=src%>" class="profile re-img" width="10" onerror="this.src='<%=srcError%>'" >
		<div class="reply_content">								
			<span class="nickname"><%=re.getId()%>
			<% if(re.getId().equals(pdsWriter)){ %> <!-- 사진 올린사람 표시 -->
				<img src="images/icons/writer.png" width="60" style="vertical-align: middle">
			<%}%>
			</span>								
			<span id="content_<%=re.getReSeq()%>"><%=re.getContent() %></span><br>
			<font style="font-size: 3px; color:graytext;"><%=re.getWdate() %></font><br>
			<%if(loginId!=null){ %>
			<button name="<%=re.getReRef()%>" onclick="addReply(this)" id="<%=re.getReSeq()%>" toWhom="<%=re.getId()%>">답변</button>
			<%} %>							
		</div>
	</li>
	<%}
}%>