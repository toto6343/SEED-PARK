<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입</title>
<link rel="stylesheet" href="style1.css">
<script type="text/javascript">	
		function checkFun() 
		{
			var f = document.user_info;
			if(f.userID.value.length < 2 || f.userID.value.length > 16)
			{
				alert("아이디는 2~16자 이내로 입력해야 합니다.");
				f.userID.focus();
				return false;
			}
			else if(f.userPW.value.length < 6)
			{
				alert("비밀번호는 6자 이상으로 입력해야 합니다.");
				f.userPW.focus();
				return false;
			}
			else if(f.userMAIL.value == "")
			{
				alert("이메일 주소는 반드시 입력해야 합니다.");
				f.userMAIL.focus();
				return false;
			}			
			else return true;
		}		
	</script>
</head>
<body>
<header>
      <div id="logo">     
        <a href="main.html">
        <h1>DaMall</h1>
        </a>
      </div>
      <nav>
      	<ul id="topMenu">
				<li><a href="#">회원 메뉴<span>▼</span></a>
            <ul>
              <li><a href="signup.jsp">회원가입</a></li>
              <li><a href="login.jsp">로그인</a></li>
            </ul>
          </li>
              	<li><a href="product_write.html">상품 등록하기</a></li>
				<li><a href="shop_list.jsp">쇼핑하기</a></li>
				<li><a href="product_list.jsp">전체 상품 보기</a></li>
			</ul>
		</nav>
		</header>
<main>
	Home > 회원 가입
	<hr>
	<form action="insertDB.jsp" name="user_info" 
		method="post" onsubmit="return checkFun()" style="margin:auto">
		<fieldset style="width:230px; margin:auto">
			<legend> 회원 가입 화면 </legend><p>
	
			아이디 : <br>
			<input type="text" size = "16" name="userID"><br><br>
		
			비밀번호 : <br> 
			<input type="password" size = "16" name="userPW"><br><br>
			
			이메일 : <br>
			<input type="email" size="30" name="userMAIL"><br>		
			<hr>
			<div style="text-align:center">
			<input type="reset" value=" ◀ 다시작성 ">
			<input type="submit" value=" 가입하기 ▶ ">
			<br><br>
			</div>
		</fieldset>
	</form>
	</main>
<footer>
<div id="bottomMenu">
    	<ul>
          <li><a href="#">회사 소개</a></li>
          <li><a href="#">개인정보처리방침</a></li>
          <li><a href="#">여행약관</a></li>
          <li><a href="#">사이트맵</a></li>
         </ul>
    <div id="sns">
          <ul>
            <li><a href="#"><img src="images/sns-1.png"></a></li>
            <li><a href="#"><img src="images/sns-2.png"></a></li>
            <li><a href="#"><img src="images/sns-3.png"></a></li>
          </ul>
        </div>
      </div> 
		<div id="company">
        	<p>인천시 미추홀구 주안로 100로 Tel) 032-458-3254 관리자 : 김우혁<br></p>
        	<p>이메일 : admall@damall.com</p> 
      	</div>  
</footer>	
</body>
</html>