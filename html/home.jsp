<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="description" content="저탄소 제주 여행 도우미">
  <meta name="keywords" content="저탄소, 제주도, 제주여행, 여행, 여행계획">
  <meta name="author" content="team ROMIJI">
  <meta name="viewport" content="width=device-width, height=device-height, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <!--Open Graph (Facebook, Linkedin)-->
  <meta property="og:type" content="website">
  <meta property="og:title" content="저탄소 제주 여행 계획 사이트입니다.">
  <meta property="og:description" content="채식 식당, 자전거 대여소, 전기차 충전소, 관광지, 버스 정류장을 한 곳에서 찾아보세요.">
  <!--이미지랑 링크 추가하기-->
  <meta property="og:image" content="">
  <meta property="og:url" content="">
  <meta property="og:site_name" content="저탄소 제주 여행 도우미">

  <!-- twitter card (Twitter)-->
  <meta name="twitter:card" content="summary">
  <meta name="twitter:title" content="저탄소 제주 여행 계획 사이트입니다.">
  <meta name="twitter:description" content="채식 식당, 자전거 대여소, 전기차 충전소, 관광지, 버스 정류장을 한 곳에서 찾아보세요.">
  <!--이미지랑 링크 추가하기-->
  <meta name="twitter:image" content="">
  <meta name="twitter:url" content="">
  <meta name="twitter:creator" content="team ROMIJI">

  <!--일반적인 파비콘 설정-->
  <!--이미지 파일 넣기-->
  <link rel="icon" href="/img/leaf-solid.svg">
  <link rel="apple-touch-icon" href="">
  <link rel="short icon" type="image/x-icon" href="">

  <!--CSS Reset(1), 아이콘 폰트, 웹페이지 사용 폰트, style.css-->
  <link rel="stylesheet" href="/css/normalize.css">
  <script src="https://kit.fontawesome.com/f1def33959.js" crossorigin="anonymous"></script>
  <link href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="/css/style2.css">

  <!--카카오 지도 api-->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaf6aeb8548101614cfb4d94eec89d1e"></script>
  
  <title>ECO Travel</title>
</head>

<body>
  <header>
    <div class="head-container">
      <!--헤드 브랜드 클릭 시 새로고침-->
      <div class="brand-container">
        <i class="fa-solid fa-leaf brand-icon eco-style"></i>
        <div class="brand-name">ECO Travel</div>
      </div>
      <div class="account-container">
          <!-- 로그인, 회원가입 부분 따로 추가하는 부분 -->
	        <jsp:include page="account.jsp" flush="false" />
      </div>
    </div>
  </header>

<!--카테고리 버튼-->
	
<div class="destination-container">
    <div class="destination-bar">
      <button class="destination-box"><a href="http://localhost:8080/mainpage.jsp?table=vegan">
        <i class="fa-solid fa-salad  destination-icon restaurant-style"></i>
        <div class="destination-name">채식 식당</div>
      </button></a>
      <button class="destination-box"><a href="http://localhost:8080/mainpage.jsp?table=vegan">
        <i class="fa-solid fa-cherries destination-icon cafe-style"></i>
        <div class="destination-name">채식 카페</div>
      </button></a>
      <button class="destination-box"><a href="http://localhost:8080/mainpage.jsp?table=bike">
        <i class="fa-solid fa-bicycle destination-icon bicycle-style"></i>
        <div class="destination-name">자전거 대여소</div>
      </button></a>
      <button class="destination-box"><a href="http://localhost:8080/mainpage.jsp?table=tourist_destination">
        <i class="fa-solid fa-mountains destination-icon hotel-style"></i>
        <div class="destination-name">관광지</div>
      </button></a>
    </div>
  </div>   
	
  <!--사이드 바-->
<div class="side-container">
	<div class="search-bar">
		<input id="address" type="text" placeholder="검색할 주소">
	<button class="search-button" id="submit" ></button>
	</div>

	<!--추천장소-->	
	<div class="list-title">추천 목적지</div>
	<ul class="place-list">
	<!-- 추천장소 부분 따로 추가하는 부분 -->
	<jsp:include page="recommend.jsp" flush="true" />
	</ul>
</div>

  <!--지도 전체화면-->
  <section  id="map" class="map">
   	<!-- 지도 부분 따로 추가하는 부분 -->
 		<jsp:include page="search.jsp" flush="false" />
  </section>


</body>
</html>
