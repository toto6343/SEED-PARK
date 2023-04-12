<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>주문 처리</title>
<link rel="stylesheet" href="style1.css">
</head>
<% 

int total=Integer.parseInt(request.getParameter("total"));
int count=Integer.parseInt(request.getParameter("count"));
 
NumberFormat nf= NumberFormat.getNumberInstance();
String totalstr =  nf.format(total);   

%>
<script type="text/javascript">
function check(f) {\
	blank=false;
	for (i=0; i<f.elements.length;i++) {
		if (f.elements[i].value=="") {
			if (f.elements[i].name != "number")
				blank=true;
			if ((f.elements[i].name == "number") && (f.pay.value == "card"))
				blank=true;
			}
	}
	if (blank==true)
		alert("모든 항목을 입력하셔야 합니다.");
	else
		f.submit();
	}
	
var passwordInput = document.getElementById("number");
var passwordValue = passwordInput.value;
if (passwordValue.length >= 8) {
  passwordInput.value = passwordValue.substring(0, 8);
}	

function maskNumber() {
    var input = document.getElementById("number").value; // 입력값 가져오기
    var masked = input.substring(0, 8) + "********" + input.substring(16); // 8자리를 마스킹 처리
    document.getElementById("number").value = masked; // 마스킹 처리된 값으로 입력값 대체
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
<p style="text-align:center; font-size:12pt" >
[<a href= "sale_list.jsp">장바구니 다시 보기</a>] </p>
<form method=post action="order_save.jsp" name="order" id="order">
<table style="margin-left:auto; margin-right:auto">
	<tr>
  		<th bgcolor=#003399 colspan=2>
   			<font size=+1 color=white> 주문서 작성하기</font>
  		</th>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>이름</font>
  		</th>
  			<td bgcolor=#eeeeee>
   				<input type="text" id="wname" name="wname" size=30>
  			</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>결제 유형</font>
  		</th>
  			<td bgcolor=#eeeeee>
   				<font size=-1>
    				<input type="radio" name="pay" value="card">카드
    				<input type="radio" name="pay" value="cash">온라인 입금
   				</font>
  			</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>카드 번호</font>
  		</th>
  		<td bgcolor=#eeeeee>
   			<input type="password" id="number" name="number" size=30 oninput="maskNumber()">
  		</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>배달 주소</font>
  		</th>
  		<td bgcolor=#eeeeee>
   			<input type="text" id="addr" name="addr" size=30>
  		</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>전화번호</font>
  		</th>
  		<td bgcolor=#eeeeee>
   			<input type="text" id="tel" name="tel" size=30>
  		</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>주문 총 금액</font>
  		</th>
  		<td bgcolor=#eeeeee>
   			<%=totalstr%>원
  		</td>
 	</tr>
 	<tr>
  		<td colspan=2>
  		<div style="text-align:center">
   			<input type="hidden" name="total" value=<%=total%>>
   			<input type="hidden" name="count" value=<%=count%>>
   			<input type="button" value=" 확인 " onclick="check(this.form)" >
   			<input type="reset" value=" 다시쓰기 " >
   		</div>
  		</td>
 	</tr>
</table>
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