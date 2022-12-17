<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.lowCO2.web.DBControll" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.io.PrintWriter" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	System.out.println("ajax 호출");
	
	String id = "";
	String pwd = "";
	List<String> mem = new ArrayList<String>();
	List<String> travelRoute = new ArrayList<String>();
	DBControll DBcon = new DBControll();
	
	//로그아웃
	if(session.getAttribute("Nickname") != null)
	{
		session.invalidate();
		System.out.println("logout");
	}
	
	//카카오 로그인
	if(request.getParameter("kakaoN") != null){
		id = request.getParameter("kakaoN");
		pwd = request.getParameter("kakaoID");
		
		mem = DBcon.selectOne(pwd, "member");
		if(mem.size() == 0)
		{
			String[] insert = new String[5];
			insert[0] = pwd;
			insert[1] = id;
			insert[2] = "";
			insert[3] = "";
			insert[4] = "";
			if(DBcon.insertMember(insert)){
				mem = DBcon.selectOne(pwd, "member");
			}
		}else{
			session.setAttribute("ID", mem.get(0));
			session.setAttribute("Nickname", mem.get(1));
			session.setAttribute("bookmark",mem.get(3));
			session.setAttribute("cumulative",mem.get(4));
			
			travelRoute = DBcon.selectJorney(pwd);

			session.setAttribute("travelRoute",travelRoute);
			System.out.println("ajax travelRoute + " + session.getAttribute("travelRoute"));
		}
		
	}//일반 로그인
	else if(request.getParameter("user-id") != null){
		id = request.getParameter("user-id");
		pwd = request.getParameter("user-pwd");
	
		mem = DBcon.selectOne(id, "member");
		
		if(mem.size() == 0)
		{ 
			out.println("<script>alert('회원 정보가 없습니다. 아이디를 확인하세요');</script>"); 
		}
		else if(pwd.equals(mem.get(2)))
		{
			session.setAttribute("ID", mem.get(0));
			session.setAttribute("Nickname", mem.get(1));
			session.setAttribute("bookmark",mem.get(3));
			session.setAttribute("cumulative",mem.get(4));
			
			travelRoute = DBcon.selectJorney(id);
			System.out.println("ajax travelRoute + " + travelRoute);

		}
		else
		{
			out.println("<script>alert('비밀번호가 틀렸습니다');</script>"); 
 		}
	}%>
	<script>
		location.href = "home.jsp"
	</script>
</body>
</html>
