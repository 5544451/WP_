<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>

<%
	System.out.println("session.getParameter(kakaoN) :"  + session.getAttribute("kakaoN"));
	System.out.println("request.getAttribute(id) : "+ session.getAttribute("comN"));

	String logID = "";
%>  


<!DOCTYPE html>
<html lang="ko">
<head>

  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>

	<script>
    // content, cate, index를 인수로 받아 form 태그로 전송하는 함수
    function loginkakao(kakaonickname, id) {
      // name이 paging인 태그
      var f = document.paging;
      // form 태그의 하위 태그 값 매개 변수로 대입
      f.kakaoN.value = kakaonickname;
      f.kakaoID.value = id;
      f.action="login_ajax.jsp"
      f.method="post"
     // input태그의 값들을 전송하는 주소
      f.submit();
    };

    <!-- 카카오 로그인 -->
		
	Kakao.init('aaf6aeb8548101614cfb4d94eec89d1e'); //발급받은 키 중 javascript키를 사용해준다.
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	function loginWithKakao() {
		//로그인시도
	    Kakao.Auth.login({
	      	success: function (response) {
	      	// 성공시 API 호출
	        Kakao.API.request({
	        	url: '/v2/user/me',
	        	success: function (response) {
	        		console.log(response);
	        		var kakaonickname = response.properties.nickname;    //카카오톡 닉네임을 변수에 저장 (닉네임 값을 다른페이지로 넘겨 출력하기 위해서)
					console.log('kakaonickname = ' + kakaonickname);
	        		var id = response.id;
	        		loginkakao(kakaonickname, id);

	        	},			
	            fail: function (error) {console.log(error);}
	        });},
	      fail: function (error) { console.log(error) }
	    })}
	
		function logOut() {
			console.log("logout()");
			location.replace('login_ajax.jsp');
		}
	</script>
	<style type="text/css">
		.dropbtn {
		  color: #3f464d;
		  width : 200px;
		  height : 55px;
		  font-size: 20px;
		  border: none;
		  font-weight: bold;
		}
	
		.dropdown {
		  position: relative;
		  display: inline-block;
		}
		 
		.dropdown-content {
		  display: none;
		  position: absolute;
		  min-width: 160px;
		  z-index: 1;
		}
		 
		.dropdown-content a {
		  color: black;
		  padding: 12px 16px;
		  text-decoration: none;
		  display: block;
		}
		 
		.dropdown-content a:hover {background-color: #ddd;}
		 
		.dropdown:hover .dropdown-content {display: block;}
		 
	</style>
	
</head>
<body> 
	<form name="paging">
    	<input type="hidden" name="kakaoN"/>
    	<input type="hidden" name="kakaoID"/></form> 

    <%
	
	if(session.getAttribute("kakaoN") != null)
	{
		logID = session.getAttribute("kakaoN").toString();
	}

	if(session.getAttribute("comN") != null)
	{
		logID = session.getAttribute("comN").toString();
	}
    
    if( logID == "") {%>
       	<ul>
            <li style = "display : inline-block;"><a href="join.html" id="buttons"><p>회원가입</p></a></li>
            <li style = "display : inline-block;"><a href="#login" id="buttons"><p>로그인</p></a></li> 
       	</ul>
   <% }else{ %>    
       <article class = "dropdown">	
   			<button class = "dropbtn"><p><%= logID%>님</p></button>
  			<article class="dropdown-content">
				<a href="#">
 					<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
  					마이페이지
  				</a>
  				<a href="#">
  					<i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
  					설정
  				</a>
  				<a href="#" onclick = "logOut()">
  					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
  					로그아웃
  				</a>
  			</article>
       </article>
   		<% }%>

           	
<!-- 요기부터 로그인 팝업창 -->
 <div id="login" class="overlay">
     <div class="popup"> <div class="title"> <p> 로그인 </p> </div>
     <fieldset>
          <form action="login_ajax.jsp" method="post">
               <ul>
                   <li>
                       <label for="user-id"> 아이디 </label>
                       <input type="text" name="user-id" autofocus placeholder="아이디 입력" required/>
                   </li>
                   <li>
                       <label for="user-pwd"> 비밀번호 </label>
                       <input type="password" name="user-pwd" placeholder="비밀번호 입력" required/>
                   </li>
               </ul>  
               <br>
               <div id="buttons">
                   <input type="submit" value="로그인"/>
                   <a href="" class="close">&times;</a>
               </div>
            </form>
            <div style="font-size: 15px; text-align : center;"><p>아이디가 없으신가요? <a href="join.html">&nbsp 회원가입</a></p></div> 
               <br><p style="font-size : 13px"> SNS 계정으로 로그인</p><hr>
               <ul style="text-align: center;" class="sns">  
             		<li onlick="kakaoLogin()" style="display: inline-block;"><!-- 카카오 -->
               		<a onclick="javascript:loginWithKakao()">
                   	<img src="/img/kakao_login_large.png" alt="카카오 로그인 버튼"/></a>
				</li>
			 </ul>
           </fieldset>
      </div> 
</div> 
</body>
</html>
