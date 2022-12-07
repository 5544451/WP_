<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>

<%
	System.out.println("session.getParameter(kakaoN) :"  + request.getParameter("kakaoN"));
	System.out.println("request.getAttribute(id) : "+ request.getAttribute("id"));
%>  


<!DOCTYPE html>
<html lang="ko">
<head>

  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>

	<script>
    // content, cate, index를 인수로 받아 form 태그로 전송하는 함수
    function loginkakao(id) {
      // name이 paging인 태그
      var f = document.paging;
      // form 태그의 하위 태그 값 매개 변수로 대입
      f.kakaoN.value = id;
     // input태그의 값들을 전송하는 주소
      f.action = "/kakaolog";
     // 전송 방식 : post
      f.method = "post";
      f.submit();
    };
    </script>

    <!-- 카카오 로그인 -->
	<script type="text/javascript">
		
		Kakao.init('aaf6aeb8548101614cfb4d94eec89d1e'); //발급받은 키 중 javascript키를 사용해준다.
		console.log(Kakao.isInitialized()); // sdk초기화여부판단
		//카카오로그인
		function loginWithKakao() {
		    Kakao.Auth.login({
		      success: function (response) {
		        Kakao.API.request({
		        	url: '/v2/user/me',
		        	success: function (response) {
 							var kakaonickname = response.properties.nickname;    //카카오톡 닉네임을 변수에 저장 (닉네임 값을 다른페이지로 넘겨 출력하기 위해서)
 							loginkakao(kakaonickname);
		        	},			
		            fail: function (error) {console.log(error);}
		        });},
		      fail: function (error) { console.log(error) }
		    })}
	</script>
</head>
<body> 
	<form name="paging">
    	<input type="hidden" name="kakaoN"/></form> 
    <%  
       if( session.getAttribute("kakaoN") == null && session.getAttribute("comN") == null) {%>
       		<ul>
                <li style="display: inline-block;"><a href="signup.jsp" id="buttons"><p>회원가입</p></a></li> &nbsp &nbsp &nbsp
                <li style="display: inline-block;"><a href="#login" id="buttons"><p>로그인</p></a></li>   
           	</ul>
       <% } else if(session.getAttribute("kakaoN") == null){ %>     		
       			<li style="display: inline-block;"><p><%= session.getAttribute("comN") %> 님</p> &nbsp &nbsp &nbsp
       			<li style="display: inline-block;"><a href="logout_s.jsp" id="buttons"><p>로그아웃</p></a></li>
       <%	} else{%>
       			<li style="display: inline-block;"><p><%= session.getAttribute("kakaoN")%>님</p> &nbsp &nbsp &nbsp
       			<li style="display: inline-block;"><a href="logout_s.jsp" id="buttons"><p>로그아웃</p></a></li>
       <% 	} %> 

<!-- 요기부터 로그인 팝업창 -->
 <div id="login" class="overlay">
     <div class="popup"> <div class="title"> <p> 로그인 </p> </div>
     <fieldset>
          <form action="mainpage" method="post">
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
            <div style="font-size: 15px; text-align : center;"><p>아이디가 없으신가요? <a href="signup.jsp">&nbsp 회원가입</a></p></div> 
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
