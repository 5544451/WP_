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
		
		int i;
		for(i = 0; i < userJourney.size() ; i++) {
			System.out.println("userJourney.get(i) : " + userJourney.get(i));
			if( userJourney.get(i) == "null" || userJourney.get(i).isEmpty())
			{
				userJourney.set(i, newJourney);
				contentCol = "plan" + (i);
				break;
			}
		}
		
		if(i == userJourney.size())
		{
			contentCol = "plan" + (i);
			DBcon.addColumn(i);
		}
		
		System.out.println("contentCol : " + contentCol);
		DBcon.updateJourney(id, contentCol, newJourney);

		session.setAttribute("travelRoute",userJourney);
		System.out.println("update travelRoute : " + userJourney);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/home.jsp");
		dispatcher.forward(req, response); 
		
    }
}
