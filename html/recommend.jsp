<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import= "com.lowCO2.web.Place" %>
<%@ page import= "java.sql.Connection"%>
<%@ page import= "java.sql.DriverManager"%>
<%@ page import= "java.sql.PreparedStatement"%>
<%@ page import= "java.sql.ResultSet"%>
<%@ page import= "java.sql.SQLException"%>

<%@ page import= "java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
  <!-- ���� �о�� -->
  <script type="text/javascript">
   	function Init() {
    // name�� paging�� �±�
	    var f = document.read;
	    // input�±��� ������ �����ϴ� �ּ�
	    f.action = "/main";
	    f.method = "post";
	    f.submit();
   };
   </script>

</head>
<body>
<form name="read"><input type="hidden"/></form> 

      <!-- ���� �ݺ�ȣ�� -->        
<%	 		//���̺� �޾ƿ�
        List<Place> info = new ArrayList<Place>();
        String table =  (String) session.getAttribute("table");
        info = (ArrayList) session.getAttribute(table);
        
        if(info == null)
        { 
        	System.out.println("info is null // recommend");%>
       	  <script>
      		Init();
     	  </script>
    <%     }
        else{
        	for(int i=0;i<info.size(); i++) {%>
	           	<li class="place-card">
	 		      <div class="place-container">
	 		            <div class="place-title-container">
	 		        	<div class="place-name" ><%= info.get(i).name%> </div>
	 		        	
	 		        	<div class="place-view-container">
            			<i class="fa-solid fa-eye view-icon"></i>
            			<div class="place-view"><%= info.get(i).view %></div>
          				</div>
	 		        	
	 		        	<div class="place-desc"><%= info.get(i).roadaddress %></div>
	 		      		</div>
	 		      </div>
	 		    </li>   	
<% 	            }} %> 
</body>
</html>