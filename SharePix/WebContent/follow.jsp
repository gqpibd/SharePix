<%@page import="java.util.List"%>
<%@page import="dto.PdsBean"%>
<%@page import="model.service.PdsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String pageId = request.getParameter("id");
    
    PdsService pdsService = PdsService.getInstance();
	List<PdsBean> pagePdsList = pdsService.getMyPdsAllList(pageId);
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%for (int i = 0; i < pagePdsList.size(); i++) {
	PdsBean dto = pagePdsList.get(i);
	%>
	
	<%
	out.println((i+1) + " 번째 : " + dto.toString() + "<br><br>");
	out.println("<table border='1'><tr><td>얍</td><td>야로</td></tr></table>");
}%>


</body>
</html>