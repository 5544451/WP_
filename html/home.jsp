<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <meta charset="UTF-8">
  <meta name="description" content="저탄소 제주 여행 도우미">
  <meta name="keywords" content="저탄소, 제주도, 제주여행, 여행, 여행계획">
  <meta name="author" content="team ROMIJI">
  <meta name="viewport" content="width=device-width, height=device-height, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">


  <!--CSS Reset(1), 아이콘 폰트, 웹페이지 사용 폰트, style.css-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
  <link rel="stylesheet" href="/css/normalize.css">
  <script src="https://kit.fontawesome.com/f1def33959.js" crossorigin="anonymous"></script>
  
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic&family=Noto+Sans+KR:wght@300;700&family=Noto+Serif+KR:wght@400;500&display=swap" rel="stylesheet">
  <link href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css" rel="stylesheet" type="text/css" />
  
  <link rel="stylesheet" href="main.css">
  <link rel="stylesheet" href="modal.css">
  <link rel="stylesheet" href="style2.css">
  
  <script src="https://kit.fontawesome.com/bb81250f29.js" crossorigin="anonymous"></script>
  <!-- 날짜 선택 -->
  <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
  <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
  
  <!--카카오 지도 api-->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaf6aeb8548101614cfb4d94eec89d1e&libraries=services,clusterer,drawing"></script>
  <title>ECO Travel</title>
</head>
<body>
  <!--모달창 배경이 될 부분-->
	<article class="carbon-modal">
      <!--모달창-->
      <article class="carbon-modal-body">
        <!--나무 아이콘 나타내는 부분-->
        <article class="carbon-trees-body">
          <article id="trees-line-one"></article>
          <article id="trees-line-two"></article>
          <article id="trees-line-three"></article>
        </article>
        <!--절약한 탄소량 문구 나타내는 부분-->
        <article class="carbon-message-body">
          <article>오늘 절약한 탄소량  <span class="message-carbon" id="carbon-kg"></span></article>
          <article>= 소나무<span class="message-carbon" id="trees"></span>가<br>1년 간 흡수하는 탄소량</article>
        </article>
        <!--카카오톡 공유 문구 나타내는 부분-->
        <article class="carbon-kakaoshare">
          오늘 일정 공유 <img src="kakaotalk_sharing_btn_small.png">
        </article>
      </article>
    </article>
  <header>
    <article class="head-container">
      <!--헤드 브랜드 클릭 시 새로고침-->
      <article class="brand-container">
        <i class="fa-solid fa-leaf brand-icon eco-style"></i>
        <article class="brand-name">ECO Travel</article>
      </article>
      <article class="account-container">
         <jsp:include page="account.jsp" flush="false" />
      </article>
    </article>
  </header>

  <!--사이드 바-->
  <article class="side-container">
    <article class="search-bar">
      <form>
        <input type="text" class="word" name="word" placeholder="검색">
        <button type="button" class="btn-search"></button>
      </form>
    </article>
    <article class="side-title">추천 장소</article>
    <ul class="list-container">
    </ul>
  </article>

	
  <article class="destination-container">
    <article class="destination-bar">
      <button class="destination-box" id="veget-food">
        <i class="fa-solid fa-salad  destination-icon restaurant-style"></i>
        <article class="destination-name">채식 식당</article>
      </button>
      <button class="destination-box" id="veget-cafe">
        <i class="fa-solid fa-cherries destination-icon cafe-style"></i>
        <article class="destination-name">채식 카페</article>
      </button>
      <button class="destination-box" id="bic-reserve">
        <i class="fa-solid fa-bicycle destination-icon bicycle-style"></i>
        <article class="destination-name">자전거 대여소</article>
      </button>
      <button class="destination-box" id="tourist">
        <i class="fa-solid fa-mountains destination-icon hotel-style"></i>
        <article class="destination-name">친환경 관광지</article>
      </button>
    </article>
  </article>
  
	<article class="placelist-container">
		<article>
        	<input type='text' class="form-control linkedCalendars" placeholder="날짜 선택"/>
    	</article>
    	<article class="side-title">
    		<p>날짜 선택</p> 
    		<select name="language" id="datepick" onchange="handleOnChange(this)">	
			</select>
		</article>
    	<ul class="plist-container">
    	</ul>
    	<button class="btn-store">일정 저장</button>
 	</article>
 	<!-- 지도 전체 화면 -->
	<section  id="map" class="map">
   		<!-- 지도 부분 따로 추가하는 부분 -->
 		<jsp:include page="search.jsp" flush="false" />		
  	</section>
</body>
</html>
