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
  
  <!--사이드 바-->
  <aside>
    <div class="side-container">
      <div class="search-bar">
        <form>
          <input type="text" name="word" placeholder="검색">
          <button class="btn-search"></button>
        </form>
      </div>
      <div class="side-title">추천 장소</div>
      <ul class="list-container">
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
        <li class="place-card">
          <div class="place-title-container">
            <div class="place-name">제주대대대대대대대대대대대대대대학교</div>
            <div class="place-view-container">
              <i class="fa-solid fa-eye view-icon"></i>
              <div class="place-view">1224312</div>
            </div>
          </div>
          <div class="place-desc">제주 아라동 어쩌구 저쩌구</div>
        </li>
      </ul>
    </div>
  </aside>

  <!--지도 전체화면-->
  <section>
    <div id="map" class="map"></div>
    
    <script>
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
      };
      var map = new kakao.maps.Map(mapContainer, mapOption); 
    </script>
  </section>


</body>
</html>
