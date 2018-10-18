<%@page import="controller.FileController"%>
<%@page import="java.io.File"%>
<%@page import="utils.Sorter"%>
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
		tagMap = new HashMap<>();
		for(int i=0;i<list.size();i++) {
			for(int j=0;j<list.get(i).getTags().length;j++) {
				String key = list.get(i).getTags()[j];
				if(tagMap.containsKey(key)) {
					int value = tagMap.get(key);
					tagMap.put(key, value+1);
				}else {
					tagMap.put(key, 1);
				}
			}
		}	
		it = Sorter.sortByValue(tagMap).iterator();
	}
%>

<style type="text/css">
.img_clickable{
	cursor: pointer;
}

.tag {
	margin : 5px;
	background-color: #ededed;	
	border-radius: 17px;
	border: 1px solid #dcdcdc;
	display: inline-block;
	cursor: pointer;
	color: #777777;
	font-family: Arial;
	font-size: 15px;
	padding: 5px 15px;
	text-decoration: none;
}

.tag:hover {
	background-color: #dfdfdf;
}
</style>	
<div class="container" >
<%	
//25 20 15 10
int iter = 0; // 지금 위치가 몇 번째인지 갯수를 세자
int size = 25;
int prevCount = -1; // 이전 갯수
int currCount = -1; // 현재 갯수
while(it.hasNext()) {		
	String temp = (String) it.next();        
       currCount = tagMap.get(temp);
       if(prevCount != -1 && prevCount > currCount){
			size = size-5;       	
       }
%>
       <span class="tag" onclick="location.href='PdsController?command=keyword&tags=<%=temp%>'"style="font-size: <%=size%>px ">#<%=temp%></span>
   <% 
	prevCount=tagMap.get(temp);
    iter++;
    if(iter>15){
    	break;
    }
   } %>
	
</div>
<div class="mcontainer" >
	<%for(PdsBean pds : list){
		String fSavename = pds.getfSaveName();
		String smallSrc = fSavename.substring(0,fSavename.lastIndexOf('.')) + "_small" + fSavename.substring(fSavename.lastIndexOf('.'));
		
		File f = new File(FileController.PATH + "\\" + fSavename);
		 if (f.exists() && f.length()<300000) { // 300kb 이하의 이미지는 그냥 원본을 가져온다
	    	  smallSrc = fSavename;			     
	    }
	%>
	<div class="item">
		<img class="img img_clickable" name="item" src="images/pictures/<%=pds.getfSaveName()%>" onclick="veiwDetail(<%=pds.getSeq()%>)" height="400">
	</div>
	<%} %>
</div>	
	