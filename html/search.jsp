<%@page import="java.util.List"%>
<%@ page import= "com.lowCO2.web.Place" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
	List<Place> selected_places = new ArrayList<Place>();
	List<Place> places = new ArrayList<Place>();
	String table =  (String) session.getAttribute("table");
	places = (ArrayList) session.getAttribute(table);
	if(places == null)
	{ 
		System.out.println("info is null // search");%>
		  <script>
			Init();
	  	</script>
<%  }
	else
	{	
		System.out.println(" search : table is "+ table); 
		places = (ArrayList) session.getAttribute(table);
	}
	%>

	<script>
	var areaArr=[] ;
		<c:forEach items= "${places}" var="item" varStatus = "status">
			console.log("${items.name}");
	    	areaArr.push({location : ${item.type} , lat : ${item.latitude} , lng :${item.longtitude}});
	 	</c:forEach> 
 	</script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaf6aeb8548101614cfb4d94eec89d1e"></script>
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
	<form name = "distance">
	   <input type="hidden" name="x1" >
	   <input type="hidden" name="y1" >
	   <input type="hidden" name="type" >   
	   <input type="hidden" name="address">   
	</form>
	
	<div class="custom_zoomcontrol radius_border"> 
        <span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
        <span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    </div>
    
    
	<!-- 카카오 지도가 뿌려질 곳 !  -->
	<div id="map" style="width:100%;height:75vh; margin: 0 auto;"></div>
	<script>
	<c:forEach items= "${places}" var="item">
		console.log(items.name);
    	areaArr.push({location : ${item.type} , lat : ${item.latitude} , lng :${item.longtitude}});
 	</c:forEach> 
	
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(36.3504119, 127.3845475),
			level: 10
		};

		var map = new kakao.maps.Map(container, options);
		
		// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomIn() {
		    map.setLevel(map.getLevel() - 1);
		}

		// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomOut() {
		    map.setLevel(map.getLevel() + 1);
		}

		// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
		var markers = [];

		/* Gson jsonParser = new Gson();
		jsonParser.toJson(${places});
		$.get("${places}",function(positions)){
	   // 마커 이미지의 이미지 주소입니다
		   var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		       
		   for (var i = 0; i < positions.length; i ++) {
		       
		       // 마커 이미지의 이미지 크기 입니다
		       var imageSize = new kakao.maps.Size(24, 35); 
		       
		       // 마커 이미지를 생성합니다    
		       var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		       var latlng = new kakao.maps.LatLng(positions[i].longtitude, positions[i].latitude);
		       
		       // 마커를 생성합니다
		       var marker = new kakao.maps.Marker({
		           map: map, // 마커를 표시할 지도
		           position: positions[i].latlng, // 마커를 표시할 위치
		           title : positions[i].name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		           image : markerImage // 마커 이미지 
		       });
		   }
		}
		*/
		// "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
		function showMarkers() {
		    setMarkers(map)    
		} 

		// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
		function hideMarkers() {
		    setMarkers(null);    
		}
	</script>
</body>
</html>