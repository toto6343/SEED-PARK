<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
<link rel="stylesheet" href="style1.css">
</head>
<script type="text/javascript">	
		function checkFun() 
		{
			var f = document.loginForm;
			if(f.uID.value == "")
			{
				alert("아이디를 입력해 주세요.");
				f.uID.focus();
				return false;
			}
			else if(f.uPW.value == "")
			{
				alert("비밀번호를 입력해 주세요.");
				f.uPW.focus();
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
	Home > 로그인
	<hr>
	<form name="loginForm" action="loginSuccess.jsp" 
		method="post" onsubmit="return checkFun()" style="margin:auto">
		<fieldset style="width:260px; margin:auto">
			<legend> 로그인 화면 </legend><p>
			<table>
			<tr height="30">
				<td align="right">아이디&nbsp;</td>
				<td><input type="text" name="uID"></td>
			</tr>
			<tr height="30">
				<td align="right">비밀번호&nbsp;</td>
				<td><input type="password" name="uPW"></td>
			</tr>
			<tr height="50">
				<td></td>
				<td><input type="submit" value=" 로그인 ▶▶ "></td>
			</tr>
			</table>
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