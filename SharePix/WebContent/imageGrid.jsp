<%@page import="controller.FileController"%>
<%@page import="java.io.File"%>
<%@page import="utils.CollenctionUtil"%>
<%@page import="model.service.PdsService"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="controller.PdsController"%>
<%@page import="dto.PdsBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String command = request.getParameter("command");
	String id = "";
	List<PdsBean> list = null;
	HashMap<String, Integer> tagMap = null;
	Iterator<String> it = null;
	if(command.equals("favorites")){	
	    id = request.getParameter("id");
		list = PdsService.getInstance().myLikePdsList(id); // 즐겨찾기한 사진들을 모아서 보여줌
		tagMap = CollenctionUtil.getHashMap(list);	
		it = CollenctionUtil.sortByValue(tagMap).iterator();
	}else if(command.equals("manager")){ 
		list = PdsService.getInstance().getsingoPdsAllList();// 그럼 끝인데
	}
%>

<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua" rel="stylesheet">
<link href="style/common.css" rel="stylesheet">
<style type="text/css">
.noNews {
  font-size: 26px;
  margin: 20px 0;
  text-align: center;
  font-family: 'Do Hyeon', sans-serif;
}
</style>
<div class="container" align="center" >
<%	if(tagMap!=null){
int iter = 0; // 지금 위치가 몇 번째인지 갯수를 세자
int size = 30; // 가장 큰 폰트 사이즈
int prevCount = -1; // 이전 갯수
int currCount = -1; // 현재 갯수
while(it.hasNext()) {		
	String temp = (String) it.next();        
       currCount = tagMap.get(temp);
       if(prevCount != -1 && prevCount > currCount){
			size = size-3; // 갯수가 줄어들면 폰트 사이즈도 줄여준다       	
       }
%>
       <span class="tag" onclick="location.href='PdsController?command=keyword&choice=SEQ&tags=<%=temp%>'"style="font-size: <%=size%>px ">#<%=temp%></span>
   <% 
	prevCount=tagMap.get(temp);
    iter++;
    if(iter>15){
    	break;
    }
   }
}
if(list.size() == 0){%>
<div align="center" class="noNews">
	<p>와! 여긴 먼지 하나 없네요!</p>
	<p>좋아하는 사진을 찾아 봐요!</p>
</div>
<%}%>
	
</div>
<div class="mcontainer" >
	<%for(PdsBean pds : list){
		String fSavename = pds.getfSaveName();
		String smallSrc = fSavename.substring(0,fSavename.lastIndexOf('.')) + "_small" + fSavename.substring(fSavename.lastIndexOf('.'));
		
		File f = new File(config.getServletContext().getRealPath("/images/pictures") + "\\" + fSavename);
		 if (f.exists() && f.length()<300000) { // 300kb 이하의 이미지는 그냥 원본을 가져온다
	    	  smallSrc = fSavename;			     
	    }
	%>
	<div class="item">
		<img class="img clickable" name="item" src="images/pictures/<%=smallSrc%>"
		onerror="$(this).parent().remove()"  
		onclick="veiwDetail(<%=pds.getSeq()%>)" height="300">
	</div>
	<%} %>
</div>	
	