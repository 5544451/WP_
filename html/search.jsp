<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
    let map = new kakao.maps.Map(mapContainer, mapOption); 
    let sample = new Array(); // 선택한 장소 직선 담는 배열
    let markerArray = new Array(); // 선택한 장소 마커 담는 배열
    let Searchmarker = new Array(); // 검색한 장소 마커 담는 배열
    
    
    var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다 
    var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
    var positions = [];// 마커를 표시할 위치와 title 객체 배열입니다. 선택한 장소 리스트 배열.
    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places(); 

    // 키워드로 장소를 검색합니다
    ps.keywordSearch(search, placesSearchCB); 
    
    // 키워드 검색 완료 시 호출되는 콜백함수 입니다
    function placesSearchCB (data, status, pagination) {
    	removeSearch();
    	removeMarker();
    	
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
    function removeMarker(){ // 검색 장소 마커 초기화
    	for(let i=0;i<Searchmarker.length;i++)
    		Searchmarker[i].setMap(null); // 마커 초기화
    	Searchmarker = new Array(); 
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
        let marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x) 
        });
        Searchmarker.push(marker); 
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
    	  
    	  
    	
        // 마커를 표시할 위치와 title 객체 배열입니다 
        positions.push({ // 선택한 장소 position 배열에 추가
            title : place.place_name,
            latlng : new daum.maps.LatLng(place.y, place.x)
        });
        markerDraw(); // 마커 그리기
        LineDraw(); // 라인 그리기
        
       
     
        
        function markerDraw(){
        	 var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다 
             var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
             // 마커 이미지의 이미지 주소입니다
             
          
             for(let i=0;i<markerArray.length;i++) //마커 초기화
            	 markerArray[i].setMap(null);
             
             markerArray = new Array(); // 다시 배열 생성
             for (var i = 0; i < positions.length; i++) { //선택한 장소 리스트에 저장되어있는 장소 마커 찍기.     
                 var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                 imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                 imgOptions =  {
                     spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                     spriteOrigin : new kakao.maps.Point(0, (i*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                     offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                 },
                 markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                     marker = new kakao.maps.Marker({
                     position: positions[i].latlng, // 마커의 위치
                     title : positions[i].title,
                     image: markerImage 
                 });
                 
                 marker.setMap(map);
                 markerArray.push(marker);
                 // 마커 이미지를 생성합니다    
             }
        }
        function LineDraw(){
        	var linePath; // 두 점 사이 경로
            var lineLine = new daum.maps.Polyline(); // 그리는 점선
            let distance=0; // 선택한 여행 경로 총 거리
         	for(let i=0;i<sample.length;i++){
            	sample[i].setMap(null); 
         	} // sample 배열에 있던 값 싹 다 초기화.
         	sample = new Array(); // sample 배열 다시 새로 만들기.
            for (var i = 0; i < positions.length; i++) { // 장소간 라인 그리기
                if (i != 0) {
                    linePath = [ positions[i - 1].latlng, positions[i].latlng] //라인을 그리려면 두 점이 있어야하니깐 두 점을 지정했습니다
                }
                ;
                lineLine.setPath(linePath); // 선을 그릴 라인을 세팅합니다
         
                sample.push(new daum.maps.Polyline({
                    map : map, // 선을 표시할 지도입니다 
                    path : linePath,
                    strokeWeight : 3, // 선의 두께입니다 
                    strokeColor : 'black', // 선의 색깔입니다
                    strokeOpacity : 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                    strokeStyle : 'dashed' // 선의 스타일입니다
                }));
                distance += Math.round(lineLine.getLength());
                //displayCircleDot(positions[i].latlng, distance); 거리 지도에 표시     
            }
         	console.log("총 거리");
         	console.log(distance);
            
        }
        function delWork(e) { // 클릭한 장소 삭제
        	  e.preventDefault();
        	  let delParentLi = e.target.parentNode;
        	  delParentLi = delParentLi.parentNode;
        	  let deleteLi = delParentLi.firstChild;
        	  deleteLi = deleteLi.firstChild;
        	  let deletenode = deleteLi.innerHTML.toString();
        	  console.log(deleteLi.innerHTML);
        	  placeList.removeChild(delParentLi);
        	  
        	  let search;
        	  for(var i = 0; i < positions.length; i++){ 
        		  search = positions[i].title.toString();
        		  if (search === deletenode) { 
        		    positions.splice(i, 1); 
        		    i--; 
        		  }
        		} // position 객체에서 선택한 장소(삭제할 장소) 삭.제
        	  LineDraw(); // 라인 다시 그리기
        	  markerDraw(); // 마커 다시 그리기
        	  
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
  </section>
</body>
</html>
