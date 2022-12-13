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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
  <link rel="stylesheet" href="/css/normalize.css">
  <script src="https://kit.fontawesome.com/f1def33959.js" crossorigin="anonymous"></script>
  <link href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="style2.css">

  <!--카카오 지도 api-->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaf6aeb8548101614cfb4d94eec89d1e&libraries=services,clusterer,drawing"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <title>ECO Travel</title>
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
        <!--로그인 클릭 시 로그인 창 팝업-->
        <article class="account-login"><a href="/js/login.html">로그인</a></article>
        <!--회원가입 클릭 시 회원가입 창 팝업-->
        <article class="account-join"><a href="/js/join.html">회원가입</a></article>
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
      <li class="place-card">
        <article class="place-title-container">
          <article class="place-name">제주대대대대대대대대대대대대대대학교</article>
          <article class="place-view-container">
            <i class="fa-solid fa-eye view-icon"></i>
            <article class="place-view">1224312</article>
          </article>
        </article>
        <article class="place-desc">제주 아라동 어쩌구 저쩌구</article>
      </li>
    </ul>
  </article>

	
  <article class="destination-container">
    <article class="destination-bar">
      <button class="destination-box">
        <i class="fa-solid fa-salad  destination-icon restaurant-style"></i>
        <article class="destination-name">채식 식당</article>
      </button>
      <button class="destination-box">
        <i class="fa-solid fa-cherries destination-icon cafe-style"></i>
        <article class="destination-name">채식 카페</article>
      </button>
      <button class="destination-box">
        <i class="fa-solid fa-bicycle destination-icon bicycle-style"></i>
        <article class="destination-name">자전거 대여소</article>
      </button>
      <button class="destination-box">
        <i class="fa-solid fa-mountains destination-icon hotel-style"></i>
        <article class="destination-name">관광지</article>
      </button>
    </article>
  </article>
  
	<article class="placelist-container">
		<article>
        	<input type="text" name="daterange" value="12/10/2022 - 12/20/2022" />
    	</article>
    	<article class="side-title">오늘의 일정</article>
    	<ul class="plist-container"></ul>
    	<button class="btn-store">일정 저장</button>
 	</article>
 	
	<section  id="map" class="map">
   		<!-- 지도 부분 따로 추가하는 부분 -->
 		<jsp:include page="search.jsp" flush="false" />		
  	</section>
  <!--지도 전체화면-->
  <!-- <section>
    <article id="map" class="map"></article>
    <script>
    const placeList = document.querySelector('.plist-container'); // 선택한 장소 리스트 컨테이너
    const searchList = document.querySelector('.list-container'); // 검색 장소 리스트 컨테이너
    const inputBtn = document.querySelector('.btn-search');
    const inputText = document.querySelector('.word');

    let search ="서울 맛집";
    var infowindow = new kakao.maps.InfoWindow({zIndex:1});

    var mapContainer = document.getElementById('map'), // 지도를 표시할 article
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };  

    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption); 

   
    var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다 
    var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
    var positions = [];// 마커를 표시할 위치와 title 객체 배열입니다 
    	 
    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places(); 

    // 키워드로 장소를 검색합니다
    ps.keywordSearch(search, placesSearchCB); 
    

    // 키워드 검색 완료 시 호출되는 콜백함수 입니다
    function placesSearchCB (data, status, pagination) {
    	removeSearch();
        if (status === kakao.maps.services.Status.OK) {

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            var bounds = new kakao.maps.LatLngBounds();
            for (var i=0; i<data.length; i++) {
                displayMarker(data[i]);    //마커 찍기
                displaySearch(data[i]);//장소 검색
                bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                
            }       

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
        } 
    }
    function removeSearch(){ // 검색 장소 초기화
    	let divEls = document.querySelectorAll('body > article.side-container > ul >li');
    	  for (let i = 0; i < divEls.length; i++) {
    	    divEls[i].remove();
    	  }
    }
	function displaySearch(place){ // 검색한 장소 오른쪽(선택한 장소 리스트) 컨테이너에 추가
		const liEl = document.createElement('li');
    	liEl.setAttribute('class', 'place-card');
    	
    	const container = document.createElement('article');
    	container.setAttribute('class', 'place-title-container');
    	
    	const name = document.createElement('article');
    	name.setAttribute('class', 'place-name');
    	name.innerHTML=place.place_name;
    	
    	const view = document.createElement('article');
    	view.setAttribute('class', 'place-view-container');
    	
    	const icon = document.createElement('i');
    	icon.setAttribute('class', 'fa-solid fa-eye view-icon');
    	
    	const x = document.createElement('article');
    	x.setAttribute('class', 'place-view');
    	x.innerHTML=place.phone;
    	
    	const address = document.createElement('article');
    	address.setAttribute('class', 'place-desc');
    	address.innerHTML=place.address_name;
    	
    	
    	  
    	view.appendChild(icon);
    	view.appendChild(x);
    	
    	container.appendChild(name);
    	container.appendChild(view);
    	
    	
    	liEl.appendChild(container);
    	liEl.appendChild(address);
    	searchList.appendChild(liEl);
	}
    // 지도에 마커를 표시하는 함수입니다
    function displayMarker(place) {
        
        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x) 
        });

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function() {
        	let str = place.place_name;
        	let send = JSON.stringify(place);
        	let content = '<div class="wrap style="width:100%; padding:0px 8px;">' + 
            '    <div class="info">' + 
            '        <div class="title">' + 
            '		  	<input type="button" class="close" onclick="closeOverlay()" value="닫기"></input>' + 
            '				<h3>'+place.place_name +'</h3>'+            
            '        </div>' + 
            '        <div class="body">' +  
            '            <div class="desc">' + 
            '                <div class="ellipsis">'+place.address_name+'</div>' + 
            '                <div class="jibun ellipsis">'+place.phone+'</div>' + 
            '				 <input type="button" class="close" onclick=\'listAdd(\ '+send+'\);\' value="추가"></input>' + 
            '            </div>' + 
            '        </div>' + 
            '    </div>' +    
            '</div>';
            // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
            infowindow.setContent(content);
            infowindow.open(map, marker);
        });
    }
    function closeOverlay() {
    	infowindow.close();    
    }
    
    inputBtn.addEventListener('click', function (e) {
    	  e.preventDefault();
    	  let inputValue = inputText.value;
    	  ps.keywordSearch(inputValue, placesSearchCB); 
    	  
    	});
    
    function listAdd(place){
    	infowindow.close(); 
    	
    	const liEl = document.createElement('li');
    	liEl.setAttribute('class', 'place-card');
    	
    	const container = document.createElement('article');
    	container.setAttribute('class', 'place-title-container');
    	
    	const name = document.createElement('article');
    	name.setAttribute('class', 'place-name');
    	name.innerHTML=place.place_name;
    	
    	const view = document.createElement('article');
    	view.setAttribute('class', 'place-view-container');
    	
    	const icon = document.createElement('i');
    	icon.setAttribute('class', 'fa-solid fa-eye view-icon');
    	
    	const x = document.createElement('article');
    	x.setAttribute('class', 'place-view');
    	x.innerHTML=place.phone;
    	
    	const address = document.createElement('article');
    	address.setAttribute('class', 'place-desc');
    	address.innerHTML=place.address_name;
    	
    	const delBtn = document.createElement('button');
    	delBtn.innerText = "삭제";
    	delBtn.setAttribute('class', 'del-data');
    	  
    	view.appendChild(icon);
    	view.appendChild(x);
    	
    	container.appendChild(name);
    	container.appendChild(view);
    	
    	address.appendChild(delBtn);
    	delBtn.addEventListener('click', delWork);
    	
    	liEl.appendChild(container);
    	liEl.appendChild(address);
    	placeList.appendChild(liEl);
    	  
    	  
    	var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다 
        var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
        // 마커를 표시할 위치와 title 객체 배열입니다 
        positions.push({
            title : place.place_name,
            latlng : new daum.maps.LatLng(place.y, place.x)
        });
        // 마커 이미지의 이미지 주소입니다
        var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
     
        for (var i = 0; i < positions.length; i++) {
            // 마커 이미지의 이미지 크기 입니다
            var imageSize = new daum.maps.Size(24, 35);
     
            // 마커 이미지를 생성합니다    
            var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
     
            // 마커를 생성합니다
            var marker = new daum.maps.Marker({
                map : map, // 마커를 표시할 지도
                position : positions[i].latlng, // 마커를 표시할 위치
                title : positions[i].title,
                image : markerImage
            // 마커 이미지 
            });
        }
     
        var linePath;
        var lineLine = new daum.maps.Polyline();
        var distance;
     
        for (var i = 0; i < positions.length; i++) {
            if (i != 0) {
                linePath = [ positions[i - 1].latlng, positions[i].latlng] //라인을 그리려면 두 점이 있어야하니깐 두 점을 지정했습니다
            }
            ;
            lineLine.setPath(linePath); // 선을 그릴 라인을 세팅합니다
     
            var drawLine = new daum.maps.Polyline({
                map : map, // 선을 표시할 지도입니다 
                path : linePath,
                strokeWeight : 3, // 선의 두께입니다 
                strokeColor : 'black', // 선의 색깔입니다
                strokeOpacity : 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                strokeStyle : 'dashed' // 선의 스타일입니다
            });
     
            distance = Math.round(lineLine.getLength());
            displayCircleDot(positions[i].latlng, distance);
             
        }
        function delWork(e) {
        	  e.preventDefault();
        	  let delParentLi = e.target.parentNode;
        	  delParentLi = delParentLi.parentNode;
        	  
        	  console.log(delParentLi);
        	  placeList.removeChild(delParentLi);
        	}
        function displayCircleDot(position, distance) {
            if (distance > 0) {
                // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
                var distanceOverlay = new daum.maps.CustomOverlay(
                        {
                            content : '<div class="dotOverlay">거리 <span class="number">'
                                    + distance + '</span>m</div>',
                            position : position,
                            yAnchor : 1,
                            zIndex : 2
                        });
     
                // 지도에 표시합니다
                distanceOverlay.setMap(map);
            }
        }
        
    }
    </script>
  </section> -->

</body>
</html>
