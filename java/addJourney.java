package com.lowCO2.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addJourney")
public class addJourney extends HttpServlet{
	@Override
	protected void service (HttpServletRequest req, HttpServletResponse response) throws IOException, ServletException
    {
		//쓰고 읽기에 한글가능하도록 ㅇㅣㄴ코딩
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		List<String> userJourney = new ArrayList<String>();
		
		PrintWriter out = response.getWriter();
		DBControll DBcon = new DBControll();
		String newJourney = req.getParameter("journey");
		String id = String.valueOf(session.getAttribute("ID"));
		System.out.println("addJourney / session.getAttribute(\"ID\") : " + id);
		
		
		userJourney = (List<String>) session.getAttribute("travelRoute");
		String contentCol = "";
		
		for(int i = 0; i < userJourney.size() ; i++) {
			System.out.println("userJourney.get(i) : " + userJourney.get(i));
			if( userJourney.get(i) == "null" || userJourney.get(i).isEmpty())
			{
				contentCol = "plan" + (i);
				break;
			}
			contentCol = "plan" + (userJourney.size());
		}
		
		
		System.out.println("contentCol : " + contentCol);
		DBcon.updateJourney(id, contentCol, newJourney);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/home.jsp");
		dispatcher.forward(req, response); 
		
    }
}
