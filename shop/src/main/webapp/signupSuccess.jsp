<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 등록 성공</title>
<link rel="stylesheet" href="style1.css">
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
	Home > 회원 등록 성공 
	<hr>
	<div style="text-align:center">
	축하합니다! <br>
	관리자인 경우만 로그인 수행이 가능합니다. <br><br>
	</div>

	<table border="0"; style="margin-left:auto; margin-right:auto">
	
		<tr>
			<td>
			
				<form action="membership.jsp" method="post" >
						<input type="submit" value="◀ 사용자 공간 이동 " >
				</form>
			</td>
			<td> 
				<form action="login.jsp" method="post" >
					<input type="submit" value=" 관리자 모드 이동 ▶" >
				</form>
				
			</td>
		</tr>
		
	</table>
	
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