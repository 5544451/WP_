<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.lowCO2.web.tourAPI" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>

<%
	tourAPI tour = new tourAPI();
	List<String> TourList = new ArrayList<>();

	if( TourList.isEmpty() )
	{
		TourList = tour.InitAPI();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="Addpaging">
   <input type = "hidden" name = "journey"/>
</form>
<section>
    <article id="map" class="map"></article>
    <script>
    const placeList = document.querySelector('.plist-container'); // 선택한 장소 리스트 컨테이너
    const searchList = document.querySelector('.list-container'); // 검색 장소 리스트 컨테이너
    const inputBtn = document.querySelector('.btn-search'); // 검색 버튼
    const inputText = document.querySelector('.word'); // 검색 키워드
    const saveBtn = document.querySelector('.btn-store'); // 경로 저장 완료 버튼
    const body = document.querySelector('.carbon-modal-body');
    const modal = document.querySelector('.carbon-modal');
    var datecombo = document.getElementById('datepick'); //날짜  콤보박스
    const vefoodBtn = document.getElementById('veget-food'); //채식 식당 버튼
    const vecafeBtn = document.getElementById('veget-cafe'); //채식 카페 버튼
    const bicreserBtn = document.getElementById('bic-reserve'); //자전거 대여소
    const tourist = document.getElementById('tourist'); //관광지 버튼
    
    let tourData = <%= TourList %>;
    console.log('tourData : ' +tourData[0]);    
	    
    let currentDate = null;
    let DATA= {
    	//날짜별 placelist 목록, 배열의 인덱스가 선택한 날짜이다.
    };
    let dateArr={
    	// 선택한 날짜 배열
    };
    let totalDistance =0; // 총 거리
    let totalCarbon=0; // 총 탄소계산량
    let diffday = 0; //선택한 여행 일자 날짜 일자
    
    $('.linkedCalendars').daterangepicker({ // 날짜 선택 함수
    	linkedCalendars: false,
    	"locale":{
    	"format": "YYYY-MM-DD",
    	"separator": " ~ ",
    	"applyLabel": "적용",
    	"cancelLabel": "취소",
    	"fromLabel": "From",
    	"toLabel": "To",
    	"customRangeLabel": "Custom",
    	"daysOfWeek": ["일","월", "화", "수", "목", "금", "토"],
    	"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"] },
    	}, function (start, end, label) {
    		dateArr = [];
    		DATA= {
    		    	//날짜 재선택. 날짜별 placelist 목록 초기화
    		    };
    		diffday = getDateDiff(start.format('YYYY-MM-DD'),end.format('YYYY-MM-DD'));	
       	}); //datepicker
    
       	
    function getDateDiff(d1, d2){ //날짜 차이 구하기
      const date1 = new Date(d1);
  	  const date2 = new Date(d2);
  	  
  	  const diffDate = date1.getTime() - date2.getTime();
  	  
  	  let cnt = Math.abs(diffDate / (1000 * 60 * 60 * 24));
  	  datecombo.options.length = 0 ; // 옵션 값 리셋
 	  var ops = document.getElementById('datepick').options;
  	  for(let i=0;i<cnt+1;i++)
	  {
  		let pickday = AddDays(date1, i);
  		var op = new Option();
  		op.value = pickday;
  		op.text= pickday;
  		ops.add(op); // 날짜 콤보박스에 추가
  		dateArr.push(pickday);
	  }
  	  console.log(dateArr);
  	  ops[0].selected = true; //첫째 날을 기본으로 선택사항으로 두기
  	  currentValue = document.getElementById('datepick').value;
  	  return cnt; // 여행 날짜 길이 반환
    }
    
    
    function AddDays(date, days) { // 날짜 더하기 함수. 형식 포맷 시킨다.
        var result = new Date(date);
        result.setDate(result.getDate() + days);
        result = result.getFullYear() + "-" + ((result.getMonth() + 1) > 9 ? (result.getMonth() + 1).toString() : "0" + (result.getMonth() + 1)) + "-" + (result.getDate() > 9 ? result.getDate().toString() : "0" + result.getDate().toString());
        return result;
    }
    
    saveBtn.addEventListener('click', function (e) {
        e.preventDefault();
        modal.style.visibility='visible'; // 모달 창 띄우기
        let NewJourney = "";
        
        for(var i=0;i<dateArr.length;i++)
    	{
        	console.log(dateArr[i]); // 날짜 값
        	if(DATA[dateArr[i]]==undefined)
        		return;
        	for(var j=0;j<DATA[dateArr[i]].length;j++)
        		NewJourney += "/" + DATA[dateArr[i]][j].address_name + "+" + DATA[dateArr[i]][j].place_name;
    	}
        
        /*for(var i = 0; i<positions.length ; i++)
          {
           NewJourney += "/" + positions[i].address_name + "+" + positions[i].place_name
          }*/
        console.log("complete Routine : " + positions);
        
        var f = document.Addpaging;
        f.journey.value = NewJourney;
        f.action = "addJourney" 
        f.method = "post"
        f.submit();
        alert("완료!");

      });
    
       // 모달창 꺼질 때
    modal.addEventListener('click', function (event) {
        
      modal.style.visibility='hidden';
    });
       
       
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
    
    // 실제로는 숫자값에 '탄소 계산 함수 리턴값'이 들어감
    totalCarbon = totalDistance*91.4+"kg";
 	console.log(totalCarbon);
    // 실제로는 tree에 'parseInt(totalCarbon)/(소나무흡수량)'이 들어감.
    treeModal(); // 모달 창 생성
    
    function handleOnChange(e){ //날짜 선택 값 변경 시
    	for(let i=0;i<markerArray.length;i++) //마커 초기화
         	 markerArray[i].setMap(null);
    	 for(let i=0;i<sample.length;i++){
           	sample[i].setMap(null); 
        	} // 라인 다 초기화.
    	if(positions.length!=0){
    		DATA[currentDate]= [];
    		for(let i=0;i<positions.length;i++)
    			DATA[currentDate][i] = positions[i]; // 바뀌기 전 날짜에 positions 값을 담아둔다.
    	}
    	console.log(DATA[currentDate]); 
   		currentDate = e.value; // 선택한 날짜로 바꾸기
   		console.log(currentDate);
   		updatePositions(); // 현재 선택한 날짜 기준 으로 position 객체 값을 변경
 	}
    
    function updatePositions() // data 배열에 저장해두었던 값을 positions 배열에 들고옴
    {
    	positions=[];
    	removeTravel(); // 경로 표지 삭제
    	if(DATA[currentDate]!=undefined){
    		for(let i=0;i<DATA[currentDate].length;i++)
    			positions[i]=DATA[currentDate][i];
    
    		for(let i=0;i<i<positions.length;i++)
				listUpdate(positions[i]);    	//표지 업데이트
    	}
    }
    
    function treeModal(){
    	var tree = 1;
        const treeSentence = tree+"그루";

        // 나무 보여주는 구조
        //   *      trees-line-one에 1개
        //  ***     trees-line-two에 최대 3개
        // *****    trees-line-three에 최대 5개
        
        
         
        if(tree>=1 && tree <4) {
          for(i=0; i<tree; i++) {
        	  console.log("들어왓나");
            document.getElementById("trees-line-one").innerHTML += '<i class="fa fa-duotone fa-tree one-tree"></i>';
          }
          document.getElementById("trees-line-two").style="display=none";
          document.getElementById("trees-line-three").style="display=none";
        }
        else if(tree>=4 && tree<7) {
          document.getElementById("trees-line-one").innerHTML = '<i class="fa fa-duotone fa-tree tree-style"></i>';
          for(i=1; i<tree; i++)
            document.getElementById("trees-line-two").innerHTML += '<i class="fa fa-duotone fa-tree tree-style"></i>';
          document.getElementById("trees-line-three").style="display=none";
        }
        else if(tree>=7 && tree<10) {
          document.getElementById("trees-line-one").innerHTML = '<i class="fa fa-duotone fa-tree tree-style"></i>';
          for(i=1; i<4; i++)
            document.getElementById("trees-line-two").innerHTML += '<i class="fa fa-duotone fa-tree tree-style"></i>';
          for(i=4; i<tree; i++)
            document.getElementById("trees-line-three").innerHTML += '<i class="fa fa-duotone fa-tree tree-style"></i>';
        }
        else if(tree>=10) {
          document.getElementById("trees-line-one").innerHTML = '<i class="fa fa-duotone fa-tree tree-style"></i>';
          document.getElementById("trees-line-two").innerHTML = '<i class="fa fa-duotone fa-tree tree-style"></i><i class="fa fa-solid fa-ellipsis tree-style"></i><i class="fa fa-duotone fa-tree tree-style"></i>';
          for(i=0; i<5; i++)
            document.getElementById("trees-line-three").innerHTML += '<i class="fa fa-duotone fa-tree tree-style"></i>';
        }
        // tree가 1보다 작게 나오는 경우
        else {
          document.getElementById("trees-line-one").innerHTML = '<i class="fa fa-duotone fa-tree tree-style"></i>';
        }
        
        document.getElementById("carbon-kg").innerHTML = totalCarbon;
        document.getElementById("trees").innerHTML = treeSentence;
        
    }
    
    
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
    function removeTravel(){ // 여행 경로 초기화
      let divEls = document.querySelectorAll('body > article.placelist-container > ul >li');
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
    
    
    function listUpdate(place){
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
    	  
    	const upBtn = document.createElement('button');
    	upBtn.innerText = "위";
    	upBtn.setAttribute('class', 'up-data');
    	
    	const downBtn = document.createElement('button');
    	downBtn.innerText = "아래";
    	downBtn.setAttribute('class', 'down-data');
    	
    	delBtn.addEventListener('click', delWork);
    	upBtn.addEventListener('click', upWork);
    	downBtn.addEventListener('click', downWork);
    	
    	
    	view.appendChild(icon);
    	view.appendChild(x);
    	
    	container.appendChild(name);
    	container.appendChild(view);
    	
    	
    	liEl.appendChild(container);
    	liEl.appendChild(address);
    	liEl.appendChild(delBtn);
    	liEl.appendChild(upBtn);
    	liEl.appendChild(downBtn);
    	
    	placeList.appendChild(liEl);
    	  
    	  
        // 마커를 표시할 위치와 title 객체 배열입니다 
        markerDraw(); // 마커 그리기
        LineDraw(); // 라인 그리기
    	
    }
    function listAdd(place){
    	if(currentDate==null){
    		alert("날짜를 선택해주세요");
    		return;
    	}
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
    	  
    	const upBtn = document.createElement('button');
    	upBtn.innerText = "위";
    	upBtn.setAttribute('class', 'up-data');
    	
    	const downBtn = document.createElement('button');
    	downBtn.innerText = "아래";
    	downBtn.setAttribute('class', 'down-data');
    	
    	delBtn.addEventListener('click', delWork);
    	upBtn.addEventListener('click', upWork);
    	downBtn.addEventListener('click', downWork);
    	
    	
    	view.appendChild(icon);
    	view.appendChild(x);
    	
    	container.appendChild(name);
    	container.appendChild(view);
    	
    	liEl.appendChild(container);
    	liEl.appendChild(address);
    	
    	liEl.appendChild(delBtn);
    	liEl.appendChild(upBtn);
    	liEl.appendChild(downBtn);
    	
    	placeList.appendChild(liEl);
    	  
    	  
        // 마커를 표시할 위치와 title 객체 배열입니다 
        positions.push(place); // 선택한 장소 position 배열에 추가
        markerDraw(); // 마커 그리기
        LineDraw(); // 라인 그리기
        
    }        
   
    function markerDraw(){ // 마커 그리기
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
            position: new kakao.maps.LatLng(positions[i].y, positions[i].x) , // 마커의 위치
            title : positions[i].place_name,
            image: markerImage 
            });
                 
            marker.setMap(map);
            markerArray.push(marker);
            // 마커 이미지를 생성합니다    
      	}
  	}
    function LineDraw(){ // 사이 경로(선) 그리기
    	var linePath; // 두 점 사이 경로
    	var lineLine = new daum.maps.Polyline(); // 그리는 점선
        let distance=0; // 선택한 여행 경로 총 거리
        for(let i=0;i<sample.length;i++){
          	sample[i].setMap(null); 
       	} // sample 배열에 있던 값 싹 다 초기화.
       	sample = new Array(); // sample 배열 다시 새로 만들기.
        console.log(positions);
       	for (var i = 0; i < positions.length; i++) { // 장소간 라인 그리기
             if (i != 0) {
            	 linePath = [ new daum.maps.LatLng(positions[i-1].y, positions[i-1].x) , new daum.maps.LatLng(positions[i].y, positions[i].x) ] //라인을 그리려면 두 점이 있어야하니깐 두 점을 지정했습니다
             }
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
       	totalDistance = distance;
        console.log("총 거리");
        console.log(distance);
            
    }
    function delWork(e) { // 클릭한 장소 삭제
        e.preventDefault();
        	  let delParentLi = e.target.parentNode;
        	  let deleteLi = delParentLi.firstChild;
        	  deleteLi = deleteLi.firstChild;
        	  let deletenode = deleteLi.innerHTML.toString();
        	  console.log(deletenode);
        	  placeList.removeChild(delParentLi);
        	  
        	  let search;
        	  for(var i = 0; i < positions.length; i++){ 
        		  search = positions[i].place_name.toString();
        		  if (search === deletenode) { 
        		    positions.splice(i, 1); 
        		    i--; 
        		  }
        		} // position 객체에서 선택한 장소(삭제할 장소) 삭.제
        	  LineDraw(); // 라인 다시 그리기
        	  markerDraw(); // 마커 다시 그리기
        	  
        }
        function upWork(e) { // 장소 위로 올리기
      	  e.preventDefault();
      	  let upParentLi = e.target.parentNode;
      	   let upLi = upParentLi.firstChild;
      	  upLi = upLi.firstChild;
      	  let upnode = upLi.innerHTML.toString();
      	
      	  console.log(upnode);
      	  console.log(positions.length);
      	  if(positions[0].place_name===upnode){
      	  	alert("첫번째 일정입니다.");
      	     return;
          }
      	  removeTravel(); // 경로 카드 삭제
          removeMarker(); // 마커 삭제
          // 경로 객체 순서 변경
          
          for(let i = 0; i < positions.length; i++){ 
      		  search = positions[i].place_name.toString();
      		  if (search === upnode) {
      			
      			let tmp = positions[i];
      			positions[i]=positions[i-1];
      			positions[i-1]=tmp;
      		    // 앞 장소와  위치 변경
      		  }
      	  } 
          
          // 경로 카드 다시 추가
          for(let i = 0; i < positions.length; i++){ 
      		  listUpdate(positions[i]);
      	  } 
      }
        function downWork(e) { // 클릭한 장소 아래로 내리기
        	e.preventDefault();
        	  let upParentLi = e.target.parentNode;
        	   let upLi = upParentLi.firstChild;
        	  upLi = upLi.firstChild;
        	  let upnode = upLi.innerHTML.toString();
        	  
        	  console.log(upnode);
        	  console.log(positions.length);
        	  if(positions[positions.length-1].place_name===upnode){
              	  alert("마지막 일정입니다.");
              	  return;
                }
        	  removeTravel(); // 경로 카드 삭제
              removeMarker(); // 마커 삭제
              // 경로 객체 순서 변경
            for(let i = 0; i < positions.length; i++){ 
        		  search = positions[i].place_name.toString();
        		  if (search === upnode) {
        			
        			let tmp = positions[i];
        			positions[i]=positions[i+1];
        			positions[i+1]=tmp;
        		    // 앞 장소와  위치 변경
        		  }
        	  } 
            
            // 경로 카드 다시 추가
            for(let i = 0; i < positions.length; i++){ 
        		  listUpdate(positions[i]);
        	  } 
      	  
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
        

    </script>
  </section>
</body>
</html>
