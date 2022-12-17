<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.lowCO2.web.DBControll" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>


<%
	String nickname = String.valueOf(session.getAttribute("Nickname"));
	Float culmulativeCarbon = 0f;
	
	if( session.getAttribute("cumulative") == ""){
		culmulativeCarbon = Float.valueOf(String.valueOf(session.getAttribute("cumulative")));
	}
	ArrayList<String> travelRoute = (ArrayList) session.getAttribute("travelRoute");	
	//날짜 비교하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
	<!--CSS Reset(1), 아이콘 폰트, 웹페이지 사용 폰트, style.css-->
	
	<link rel="stylesheet" href="/css/main.css">
	<script src="https://kit.fontawesome.com/f1def33959.js" crossorigin="anonymous"></script>
	<link href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="/css/style2.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<style>
		fieldset{
			padding : 30px;
		}
		 p { margin:20px 0px; }
		 
	</style>

</head>
<body>
	<header>
	   <article class="head-container">
	     <!--헤드 브랜드 클릭 시 새로고침-->
	     <article class="brand-container">
	       <i class="fa-solid fa-leaf brand-icon eco-style"></i>
	       <article class="brand-name">ECO Travel</article>
	     </article>
	     <article class="account-container">
	         <!-- 로그인, 회원가입 부분 따로 추가하는 부분 -->
	        <jsp:include page="account.jsp" flush="false" />
	     </article>
	   </article>
	</header>
	<section class="container">
      <article class="row">
        <article class="col">
            <ul class="nav nav-tabs">
              <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#info">회원 정보</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#record">내 여행</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Withdrawal">회원 탈퇴</a>
              </li>
            </ul>
            <article class="tab-content">
	            <article class="tab-pane fade show active" id="info" style = "padding : 30px;">
					<fieldset style="width : 50%; float:left;">
						<p>닉네임</p>
						<h4> <%= nickname %></h4>
						<button style="float : right;" value = "수정하기">수정하기</button>
					</fieldset>
					<fieldset style="width : 50%; ">
						<p>비밀번호 변경</p>
						<label style = "width :150px">현재 비밀번호</label>
						<input type = "password" placeholder ="현재 비밀번호 입력"/>
						<label style = "width :150px">새로운 비밀번호</label>
						<input type = "password" placeholder ="공백없이 특수문자 포함"/>
						<button style="float : right;" value = "수정하기">수정하기</button>
					</fieldset>
					<fieldset>
						<label>탄소 발자국</label>
						<h4> <%= culmulativeCarbon %> kg</h4>
					</fieldset>
	            </article>
	            <article class="tab-pane fade" id="record" style = "padding : 30px;">
	                <fieldset style = "padding : 40px;">
	                <h4>찜한 여행지</h4>
	                <ul>
              
	                </ul>
	                </fieldset>
	                <hr>
	                <fieldset style = "padding : 40px;">
	                <h4>계획한 여행지</h4>
	              	<ul>  
	              <%for(int i=1;i<travelRoute.size(); i++) {%>
	            	   <li><p><%= travelRoute.get(i) %></p></li>
	            	<%} %>
	            	</ul> 
	                </fieldset>
	            </article>
	            <article class="tab-pane fade" id="Withdrawal" style = "padding : 30px;">
	                <fieldset style = "padding : 40px;">
	                	<img src = "/img/저탄소여행.png" style = "width : 300px; padding : 30px; display: felx;"/>
	                	<h2> 회원 탈퇴 전 확인해주세요 </h2>
	                	<p>탈퇴하시면 이용 중인 모든 데이터가 폐쇄되며, 모든 데이터는 복구가 불가능합니다.</p>
	                	
	                	<article style = "width : 100%; padding : 50px; display : felx; background-color : #F0FFF0 ;">
	                		<ul>
	                			<li> - 카카오톡을 포함한 모든 로그인 정보가 삭제 됩니다.</li>
	                			<li> - 이때까지 모두 계획했던 여행 일정이 사라집니다.</li>
	                			<li> - 누적으로 추가되고 있던 탄소량이 초기화 됩니다.</li>
	                		</ul>
	                	</article>
	                	
	                	<input type="checkbox" id="cb1">안내사항을 모두 확인하였으며, 이에 동의합니다.</input>
	                	<hr>
	                	<input type = "submit" value = "탈퇴하기"/>
	                	
	                </fieldset>
	            </article>
	            
            </article>
        </article>
    </article>
	    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		
	</section>

</body>
</html>
