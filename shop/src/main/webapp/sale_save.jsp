<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>주문 완료</title>
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
    
<%
try {
	session=request.getSession();
 	String id = request.getParameter("id"); 
 	int qty = Integer.parseInt(request.getParameter("quantity")); 
 	
 	String ca="";
 	String pn="";
 	
 	
 	if (request.getParameter("cat") != null) 
 		if( !(request.getParameter("cat").equals("")) )
 			ca=request.getParameter("cat");
 	
 	if (request.getParameter("pname") != null)
 		if ( !(request.getParameter("pname").equals("")) ) 
 			pn=request.getParameter("pname");
 	
 	String[] a = session.getValueNames();
 	
 	for (int i=0; i < a.length; i++) {
 		if (id.equals(a[i])) {
 			int old=((Integer)session.getValue(id)).intValue();
 			qty = qty+old;
 			}
 		}
 		
 	session.putValue(id, new Integer(qty));
 	out.println("<div style=\"text-align:center;\">");
 	out.println("<img src=images/addsuccess.png; witdh=500 height=300><br>");
 	out.println("바구니에 넣었습니다.");
 	out.print("[<a href=\"shop_list.jsp?go="+ request.getParameter("go"));
 	out.print("&cat="+ ca +"&pname="+pn+"\">계속 쇼핑하기</a>]");
 	out.print("[<a href=\"sale_list.jsp?go="+ request.getParameter("go"));
 	out.print("&cat="+ ca +"&pname="+pn+"\">장바구니 보기</a>]");
 	out.println("</div>");

} catch (Exception e) {
	out.println(e);
	} 
%>
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
    