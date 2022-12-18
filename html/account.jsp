<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>

<%
	System.out.println("session.getParameter(kakaoN) :"  + session.getAttribute("Nickname"));
	String logID = "";
%>  


<!DOCTYPE html>
<html lang="ko">
<head>
	<link href="/css/style2.css" rel="stylesheet" type="text/css">
		<script src="https://kit.fontawesome.com/bb81250f29.js" crossorigin="anonymous"></script>
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
/*  	 	.dropbtn {
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
		   */
	</style>
	
</head>
<body> 
	<form name="paging">
    	<input type="hidden" name="kakaoN"/>
    	<input type="hidden" name="kakaoID"/></form> 

    <%
	
	if(session.getAttribute("Nickname") != null)
	{
		logID = session.getAttribute("Nickname").toString();
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
				<a href="MyPage.jsp" onclick="close();">
 					<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
  					마이페이지
  				</a>
  				<a href="#" onclick = "logOut()">
  					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
  					로그아웃
  				</a>
  			</article>
       </article>
   		<% }%>

  
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<!-- 요기부터 로그인 팝업창 -->
<!--팝업창 배경-->
 <article id="login" class="overlay">
		<!--팝업창-->
		<article class="popup">
			<!--'로그인' 타이틀-->
			<p class="title">로그인</p>
			<!--아이디 비밀번호 입력, 로그인 버튼-->
			<form action="login_ajax.jsp" method="post" style="width: 100%;">
				<i class="fa-solid fa-user id-icon"></i>
				<input type="text" name="user-id" class="input-id" autofocus placeholder="아이디" required/>
				<i class="fa-solid fa-lock pwd-icon"></i>
				<input type="password" name="user-pwd" class="input-pwd" placeholder="비밀번호" required/>
				<input type="submit" value="로그인"/>
			</form>
			<a href="" class="close" onclick="close();">&times;</a>
			<!--회원가입으로 이동-->
			<p class="to-join">아이디가 없으신가요?<a href="join.html" class="move-to-join">회원가입</a></p>
			<!--카카오 로그인으로 이동-->
			<p class="to-sns-login">SNS 계정으로 로그인</p>
			<a onclick="javascript:loginWithKakao()"><img src="/img/kakao_login_large.png" class="kakao-login" alt="카카오 로그인 버튼"/></a> 	
		</article> 
	</article>
<!--팝업창 끗-->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->


</body>
</html>
