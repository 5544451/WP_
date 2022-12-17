package com.lowCO2.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class member extends HttpServlet{
	@Override
	protected void service (HttpServletRequest req, HttpServletResponse response) throws IOException, ServletException
    {
		//쓰고 읽기에 한글가능하도록 ㅇㅣㄴ코딩
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String[] mem = new String[5];
		req.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		
		String nick =  String.valueOf(req.getParameter("nickname"));
		String pwd =  String.valueOf(req.getParameter("pwd"));
		String email =  String.valueOf(req.getParameter("mail"));
		mem[0] = email;
		mem[1] = nick;
		mem[2] = pwd;
		mem[3] = "";
		mem[4] = "";

		DBControll DBcon = new DBControll();
		
		List<String> DetecRepeat = DBcon.MemberTable();
		for(String chkRpt : DetecRepeat)
		{
			if(chkRpt == email)
			{
				RequestDispatcher dispatcher = req.getRequestDispatcher("/join.html");
				dispatcher.forward(req, response); 
			}
		}

		if(DBcon.insertMember(mem)) { 
			RequestDispatcher dispatcher = req.getRequestDispatcher("/home.jsp"); 
			//alert("회원가입 완료! 다시 로그인해주세요. "); 
			dispatcher.forward(req, response); 
		}
		else { 
			RequestDispatcher dispatcher = req.getRequestDispatcher("/join.html");
			dispatcher.forward(req, response); 
		}
		
		
    }
}
