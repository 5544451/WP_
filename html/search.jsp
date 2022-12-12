<%@page import="java.util.List"%>
<%@ page import= "com.lowCO2.web.Place" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaf6aeb8548101614cfb4d94eec89d1e&libraries=services,clusterer,drawing"></script>
    
<!--// 	   <script>
	//   function a(lan1,lon1,address,type){
	//      var f = document.distance;
	//      f.x1.value = lan1;
	//      f.y1.value = lon1;
	//      f.address.value = address;
	//      f.type.value = type;
	 //     
	//      f.action = "";
	//      f.method ="post";
	//      f.submit();
	//   };
	//   </script> -->
   
   <style>
    .custom_zoomcontrol {position:absolute;top:50px;right:10px;width:36px;height:80px;overflow:hidden;z-index:1;background-color:#f5f5f5;} 
	.custom_zoomcontrol span {display:block;width:36px;height:40px;text-align:center;cursor:pointer;}     
	.custom_zoomcontrol span img {width:15px;height:15px;padding:12px 0;border:none;}             
	.custom_zoomcontrol span:first-child{border-bottom:1px solid #bfbfbf;}
   </style>
   
   
</head>
<body>
<!-- 	<form name = "distance">
	   <input type="hidden" name="x1" >
	   <input type="hidden" name="y1" >
	   <input type="hidden" name="type" >   
	   <input type="hidden" name="address">   
	</form>
	
	<div class="custom_zoomcontrol radius_border"> 
        <span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
        <span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    </div>
     -->
    
	<!-- 카카오 지도가 뿌려질 곳 !  -->
	  <section>
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
                displayMarker(data[i]);    
                displaySearch(data[i]);
                bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                
            }       
            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
        } 
    }
    function removeSearch(){
    	let divEls = document.querySelectorAll('body > article.side-container > ul >li');
    	  for (let i = 0; i < divEls.length; i++) {
    	    divEls[i].remove();
    	  }
    }
	function displaySearch(place){
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
</body>
</html>
