package com.lowCO2.web;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MypageEdit")
public class MypageEdit extends HttpServlet{
	@Override
	protected void service (HttpServletRequest req, HttpServletResponse response) throws IOException, ServletException
    {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String[] mem = new String[5];
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		DBControll DBcon = new DBControll();
		
		mem[0] =  String.valueOf(session.getAttribute("ID"));
		mem[1] =  String.valueOf(req.getParameter("editNickname"));
		mem[2] =  String.valueOf(req.getParameter("editPswd"));
		mem[3] =  String.valueOf(session.getAttribute("bookmark"));
		mem[4] =  String.valueOf(session.getAttribute("cumulative"));
    
		session.setAttribute("Nickname",mem[1]);
		session.setAttribute("password",mem[2]);

		DBcon.updateMember(mem);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/MyPage.jsp");
		dispatcher.forward(req, response); 
		
    }
}
