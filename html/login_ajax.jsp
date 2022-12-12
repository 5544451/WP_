<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.lowCO2.web.DBControll" %>
    
<%
	request.setCharacterEncoding("UTF-8");
	
	
	System.out.println("ajax 호출");
	if(request.getParameter("kakaoN") != null){
		session.setAttribute("kakaoN", request.getParameter("kakaoN"));
		session.setAttribute("kakaoID",request.getParameter("kakaoID"));
	}
	else if(request.getParameter("user-id") != null){
		String id = request.getParameter("user-id");
		String pwd = request.getParameter("user-pwd");
		session.setAttribute("comN", request.getAttribute("id"));
	

		String[] mem = new String[3];
		DBControll DBcon = new DBControll();
		mem = DBcon.selectOne(id, "member");
		
		if(pwd.equals(mem[2]))
		{
			session.setAttribute("comN", mem[1]);
		}
		else
		{
			System.out.println("비번틀림");
		}
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
<% 	response.sendRedirect("home.jsp"); %>