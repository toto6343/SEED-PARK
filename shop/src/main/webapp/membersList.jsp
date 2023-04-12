<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ include file = "dbConn.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 회원 목록 </title>
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
	Home > 등록 회원 관리
	<hr>
	<% 
		String u_id = request.getParameter("userID");
		String u_pw = request.getParameter("userPW");
		String u_mail = request.getParameter("userMAIL");
		
		Statement sm = conn.createStatement();
		ResultSet rs = sm.executeQuery("SELECT id, email, signuptime FROM members");
		
		String str = "";
		int count = 1;
		
		while(rs.next()){
			str += count + " : " + rs.getString("id") + " / " + rs.getString("email")
				+ " / " + rs.getString("signuptime") + "<br>";
			count++;
		}
		out.print(str);
		
		rs.close();
		sm.close();
		conn.close();	
	%>
	<hr>
	<table border="0" style="margin-left:auto; margin-right:auto">
		<tr>
			<td>
				<form action="withdraw.jsp" method="post" >
					<input type="submit" value=" ◀ 회원 탈퇴시키기 " >
				</form>
			</td>	 
			<td>
				<form action="logout.jsp" method="post" >
					<input type="submit" value=" 로그 아웃 ▶" >
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