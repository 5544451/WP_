<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.lowCO2.web.DBControll" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>

<%
	DBControll DBcon = new DBControll();

	String nickname = String.valueOf(session.getAttribute("Nickname"));
	Float culmulativeCarbon = 0f;
	
	if( session.getAttribute("cumulative") == ""){
		culmulativeCarbon = Float.valueOf(String.valueOf(session.getAttribute("cumulative")));
	}
	
	ArrayList<String> travelRoute = (ArrayList) session.getAttribute("travelRoute");	
	String[] dateArray = new String[travelRoute.size() -1];
	
	for( int p=1; p<travelRoute.size(); p++)
	{
		if(travelRoute.get(p) == null){break;}
		String[] arr1 = travelRoute.get(p).split("@");
		for( int i=1; i<arr1.length; i++)
		{
			System.out.println("arr1["+i+"] : " +arr1[i]);
			String[] row1 = arr1[i].split("/");
			for( int j=0; j<(arr1.length); j++)
			{
//				System.out.println("arr1["+i+"] : row1["+ j +"]  //// " +row1[j]);
				if( i == 1 && j == 0)
				{
					dateArray[p-1] = row1[j];
				}
				if( i == (arr1.length-1) && j == 0)
				{
					dateArray[p-1] += " ~ " + row1[0];
				}
			}
		}
		System.out.println("dateArray[]"+ (p-1) +"] = " + dateArray[p-1]);
	}
	
	//날짜 비교하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
 	 <link rel="stylesheet" href="/css/style2.css">
	<script src="https://kit.fontawesome.com/f1def33959.js" crossorigin="anonymous"></script>
	<link href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<body>
	<script>
	function chkPwdForm(obj) {
		var content = obj.value;
		var result = document.getElementById("pwdResult");
		var cumule = "";
		
		if(content.search(/\s/g) > -1){
			cumule += "비밀번호에 공백을 사용할 수 없습니다.";}

		var special_pattern = /[`~!@#$%^&*()_+|<>?:{}]/;
		if(special_pattern.test(content) == false){
			cumule += "비밀번호에 특수문자를 입력해야 합니다.";}
		if(cumule ==""){
			result.innerHTML = "사용가능한 비밀번호 입니다."
			result.style.color = "#008000"
		}
		else{
			result.innerHTML = cumule;
			result.style.color = "#db0d36"
			document.getElementById("pwd").value = null;
		}
	}
	
	function chkSecurity(obj){
		var pwd = obj.value;
		var special_pattern = /[`~!@#$%^&*()_+|<>?:{}]/; //특수문자
		var smallLetter =  /[a-z]/;  //소문자
		var capitalLetter = /[A-Z]/; //대문자
		var num = /[0-9]/;	// 숫자 
		
		//[소문자, 대문자, 숫자, 특수기호 있나없나]를 확인하기 위한 배열
        const stringChk = [false, false, false, false];
		var secuM = ['매우위험','위험','보통','안전']; //보안수준을 문구로 설명하기위한 배열
		var secuColor = ["#db0d36","#db0d36","#ffd400","#008000"]; //문구의 색상을 줌
        var security = 0; //보안 수준을 체크하기 위한 변수
		
        for(var i = 0; i < pwd.length; i++){
           	if(smallLetter.test(pwd) == true){
           		stringChk[0] = true;
            }
           	if(capitalLetter.test(pwd) == true){
           		stringChk[1] = true;
            }
           	if(num.test(pwd) == true){
           		stringChk[2] = true;
            }
        	if(special_pattern.test(pwd) == true){
        		stringChk[3] = true;
            }
        }
        security =  stringChk.filter(element => true === element).length;
        document.getElementById("Security_Level").value = security;
        document.getElementById("secMessage").innerHTML = secuM[security-1];
        document.getElementById("secMessage").style.color = secuColor[security-1];
        
	}
		
		
	function chkPwd(e){
		var password = document.getElementById("pwd_chk").value;
		var result = document.getElementById("pwdchkResult");
		var answer = document.getElementById("pwd").value;
		
		if(password == answer){
			result.innerHTML = "비밀번호 확인이 완료되었습니다."
			result.style.color = "#008000"
		}
		else{
			result.innerHTML = "비밀번호가 일치하지 않습니다."
			result.style.color = "#db0d36"
		}
	}
	
	function editMember(){
		var nickname = document.getElementById("newNickname").value;
		var password = document.getElementById("pwd").value;
		
        var f = document.editform;
        f.editNickname.value = nickname;
        f.editPswd.value = password;
        f.action = "MypageEdit" 
        f.method = "post"
        f.submit();
		
	}
	</script>
	<form name = "editform">
		<input type = "hidden" id = "editNickname" name = "editNickname"/>
		<input type = "hidden" id = "editPswd" name = "editPswd"/>
	</form>
	<header>
	   <article class="head-container">
	     <!--헤드 브랜드 클릭 시 새로고침-->
	     <article class="brand-container">
	       <i class="fa-solid fa-leaf brand-icon eco-style"></i>
	       <article class="brand-name"><a href="home.jsp">ECO Travel</a></article>
	     </article>
	     <article class="account-container">
	         <!-- 로그인, 회원가입 부분 따로 추가하는 부분 -->
	        <jsp:include page="account.jsp" flush="false" />
	     </article>
	   </article>
	</header>
	<section class="mypage-container">
      <article class="row">
        <article class="col">
            <ul class="nav nav-tabs">
              <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#info">회원 정보</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#record">내 여행</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Withdrawal">회원 탈퇴</a>
              </li>
            </ul>
            <article class="tab-content">
	            <article class="tab-pane fade show active" id="info" style = "padding : 30px;">
					<fieldset style="width : 50%; float:left; margin-top:4rem;">
						<p>닉네임<span id="nickname"><%= nickname %></span></p>
						<label style = "width :180px">새로운 닉네임</label>
						<input type="text"  id="newNickname" >
						<button value = "수정하기" onclick = "editNickname()">수정하기</button>
						<p class="mypage-carbon">
							<label>탄소 발자국</label><br><span> <%= culmulativeCarbon %> kg</span>
						</p>
					</fieldset>
					<fieldset style="width : 50%;">
						<p style="color: #81a081">비밀번호 변경</p>
						
						<label style = "width :180px">현재 비밀번호</label>
						<input type = "password" placeholder ="현재 비밀번호 입력"/>
						
						<label style = "width :180px">새로운 비밀번호</label>
						<input type = "password" id="pwd" name="pwd" placeholder ="공백없이 특수문자 포함" onkeyup="chkSecurity(this)" onblur="chkPwdForm(this)"/>
						<p id = "pwdResult"></p>
						<span>보안</span><br>
						<progress id = "Security_Level" value="0" max="4"></progress><p id="secMessage"></p><span id = "pwdchkResult"></span>
						
						<label style = "width :180px">새로운 비밀번호 확인</label>
						<input type = "password" id="pwd_chk" name="pwd_chk" placeholder ="공백없이 특수문자 포함" onkeyup="chkPwd(event)"/><br>
						
						<button value = "변경하기" onclick = "editNickname()">변경하기</button>
					</fieldset>
	            </article>
	            <article class="tab-pane fade" id="record" style = "padding : 30px;">
	                <fieldset style = "padding : 40px;">
	                <h4>찜한 여행지</h4>
	                <ul>
              
	                </ul>
	                </fieldset>
	                <hr>
	                <fieldset style = "padding : 40px;">
	                <h4>계획한 여행지</h4>
	              	<ul>  
	              <%for(int i=0;i<dateArray.length; i++) {
	              		if( i == 0 && dateArray[i] == null){break;}else{ %>
	            	   <li class="my-place-card"><%= dateArray[i] %></li>
	            	<%} }%>
	            	</ul> 
	                </fieldset>
	            </article>
	            <article class="tab-pane fade" id="Withdrawal">
	                <fieldset style = "padding : 20px;	width: 60%;" class="withdrawal-fieldset">
	                	<img src = "/img/저탄소여행.png" style = "width : 300px; padding : 30px; display: flex;"/>
	                	<h2><i class="fa-solid fa-triangle-exclamation exclamation-style"></i>회원 탈퇴 전 확인해주세요 </h2>
	                	<p>탈퇴하시면 이용 중인 모든 데이터가 폐쇄되며, 모든 데이터는 복구가 불가능합니다.</p>
	                	
	                	<article style = "width : 100%; padding : 50px; display : felx; background-color : #F0FFF0 ;">
	                		<ul style="list-style:none;">
	                			<li style="margin: 0.4rem 0;"><i class="fa-solid fa-check check-style"></i> 카카오톡을 포함한 모든 로그인 정보가 삭제 됩니다.</li>
	                			<li style="margin: 0.4rem 0;"><i class="fa-solid fa-check check-style"></i> 이때까지 모두 계획했던 여행 일정이 사라집니다.</li>
	                			<li style="margin: 0.4rem 0;"><i class="fa-solid fa-check check-style"></i> 누적으로 추가되고 있던 탄소량이 초기화 됩니다.</li>
	                		</ul>
	                	</article>
	                	
	                	<p class="out-checkbox"><input type="checkbox" id="cb1"/><span style="margin-left:1rem;">안내사항을 모두 확인하였으며, 이에 동의합니다.</span></p>
	                	<input type = "submit" style="width:150px;" value = "탈퇴하기"/>
	                </fieldset>
	            </article>
	            
            </article>
        </article>
    </article>
    	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	</section>

</body>
</html>
