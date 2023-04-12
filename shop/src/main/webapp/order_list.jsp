<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>주문서 내역</title>
<meta charset="CP949">
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
	Home > 주문 내역
	<hr>
[<a href="shop_list.jsp">쇼핑 목록으로 </a>]
<%
String sql=null;
Connection con= null;
Statement st1 =null;
Statement st2 =null;
ResultSet rs1 =null;
ResultSet rs2 =null;

int count=0;
int price=0;
int qty=0;
String cond="";
long id=0;

if (request.getParameter("id")!=null) {
	id = Long.parseLong(request.getParameter("id"));
	cond = " where id="+id;
	} else 
		cond = " order by id desc";  

NumberFormat nf= NumberFormat.getNumberInstance();
String totalstr="";
 
try {
	Class.forName("oracle.jdbc.OracleDriver");
	} catch (ClassNotFoundException e ) {
		out.println(e);
		}
 
try{
	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","root","123456");
	} catch (SQLException e) {
		out.println(e);
		}

try {
	st1 = con.createStatement();
	st2 = con.createStatement();
	
	sql = "select * from saleorder"+ cond;
	rs1 = st1.executeQuery(sql);
	
	if (!(rs1.next())) 
		out.println("해당 내용이 없습니다");
	else {
		do {
			totalstr =nf.format(rs1.getLong("total"));
			count =rs1.getInt("prodcount");
			id=rs1.getLong("id");
			out.println("<table width=500 border=0 >");
			out.println("<tr><th colspan=2 bgcolor=003399>");
			out.println("<font color=white>주문 내역서</font></th></tr>");
			out.println("<tr><td width=20% bgcolor=eeeeee>");
			out.println("주문 번호</td>");
			out.println("<td bgcolor=eeeeee>"+id+"</td></tr>");
			out.println("<tr><td width=20% bgcolor=eeeeee>");
			out.println("주문 날짜</td>");
			out.println("<td bgcolor=eeeeee>"+rs1.getString("orderdate")+"</td></tr>");
			out.println("<tr><td bgcolor=eeeeee>고객 이름</td>");
			out.println("<td bgcolor=eeeeee>"+rs1.getString("name")+"</td></tr>");
			out.println("<tr><td bgcolor=eeeeee>결제 유형</td>");
			out.println("<td bgcolor=eeeeee>");
			out.println(rs1.getString("pay")+"("+rs1.getString("cardno")+")");
			out.println("</td></tr>"); 
			out.println("<tr><td bgcolor=eeeeee>배달 주소</td>");
			out.println("<td bgcolor=eeeeee>"+rs1.getString("addr")+"</td></tr>");
			out.println("<tr><td bgcolor=eeeeee>전화 번호</td>");
			out.println("<td bgcolor=eeeeee>"+rs1.getString("tel"));
			out.println("</td></tr></table>"); 
			
			sql = "select * from item where orderid="+id+" order by mynum";
			rs2 = st2.executeQuery(sql);
			
			
			if (rs2.next()) {
				out.println("<table width=500 border=0 >");
     			out.println("<tr><th colspan=2 bgcolor=0033cc>");
     			out.println("<font color=white>상품 코드</font></th>");
     			out.println("<th  bgcolor=0033cc>");
     			out.println("<font color=white>상품 이름</font></th>");
     			out.println("<th  bgcolor=0033cc>");
     			out.println("<font color=white>주문 수량</font></th>");
     			out.println("<th  bgcolor=0033cc>");
     			out.println("<font  color=white>판매가격</font></th>");
     			out.println("<th  bgcolor=0033cc>");
     			out.println("<font color=white>판매가격*수량</font></th></tr>");
     			
     			
     			do {
     				qty=rs2.getInt("quantity");
      				price=rs2.getInt("price");
      				
      				out.println("<tr><th width=5% bgcolor=0033cc>");
      				out.println("<font color=white>"+rs2.getInt("mynum"));
      				out.println("</font></th>");
      				out.println("<td width=15% bgcolor=eeeeee>");
      				out.println(rs2.getLong("prodid")+"</td>");
      				out.println("<td width=100 bgcolor=eeeeee>");
      				out.println(rs2.getString("pname")+"</td>");
      				out.println("<td align=right bgcolor=eeeeee>"+qty+"</td>");
      				out.println("<td align=right bgcolor=eeeeee>");
      				out.println(nf.format(price)+"</td>");
      				out.println("<td align=right bgcolor=eeeeee>");
      				out.println(nf.format(price*qty)+"</td></tr>");
      				
     			} while(rs2.next());
     			out.println("<tr><td align=right colspan=6>");
     			out.println("주문 상품 :"+count+"품목&nbsp;합계금액 :"+totalstr+"원");
     			out.println("</td></tr></table><br>");
     			}
			}while(rs1.next());   
		}
	
	st1.close();
  	st2.close();
  	con.close();
  	} catch (SQLException e) {
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