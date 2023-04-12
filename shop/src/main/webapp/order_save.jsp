<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<body>
		<main>


<%
session = request.getSession();
 
String[] a = session.getValueNames();
 
String cardno="";
String wname = request.getParameter("wname");
String addr = request.getParameter("addr");
String tel = request.getParameter("tel");
String pay = request.getParameter("pay");

if ("card".equals(pay))  
	cardno=request.getParameter("number");

int count = Integer.parseInt(request.getParameter("count"));
long total = Long.parseLong(request.getParameter("total"));

long id = 0;
int num= 0;
int qty= 0;
String pname= ""; 

java.util.Date yymmdd = new java.util.Date() ;
SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
String ymd=myformat.format(yymmdd);
String sql=null;

Connection con=null;
Statement st=null; 
ResultSet rs=null;  

int cnt=0; 
int cnt2=0; 
int price=0; 

try {
	Class.forName("oracle.jdbc.OracleDriver");
	} catch (java.lang.ClassNotFoundException e){
		out.println(e.getMessage());
		}
try {
	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","root","123456");
  	st = con.createStatement();
  	
  	sql = "select max(id) from saleorder";
  	rs = st.executeQuery(sql);
  	
  	if (rs.next()) 
  		id= rs.getLong(1) + 1 ;
  	else 
  		id=1;
  	
  	
  	sql= "insert into saleorder(id,name,orderdate,addr,tel," ;
  	sql= sql + "pay,cardno,prodcount,total)" ; 
  	sql= sql + " values("+id+",'"+wname+"','"+ymd+"','"+addr+"','"+tel  ;
  	sql= sql + "','" + pay + "','" + cardno + "',"+count+","+total+")" ;
  	cnt = st.executeUpdate(sql);
  	
  	
  	if (cnt >0) {
  		for (int i=0; i< a.length ;i++) {
  			long pid =Long.parseLong(a[i].trim());
  			qty = ((Integer)session.getValue(a[i])).intValue();
  			num=i+1;
    		sql = "select pname,downprice from product where id="+pid; 
    		rs = st.executeQuery(sql);
    		rs.next();
    		pname=rs.getString(1);
    		price=rs.getInt(2);
    		sql = "insert into item(orderid,mynum,prodid,pname,quantity,price)" ;
    		sql = sql + " values("+id+","+num+","+pid+",'"+pname+"',"+qty+","+ price+")" ;
    		cnt2 = cnt2+st.executeUpdate(sql);
    		}
  		
  		
  		if (cnt2==count) {
  			out.println("주문이 정상적으로 처리되었습니다.");
  			session.invalidate();
  			out.println("[<a href=\"order_list.jsp?id="+id+"\">주문서보기</a>]");
  			} else {
  				out.println("상품에 대한 주문이 처리되지 못했습니다.");
     			out.println("[<a href=\"shop_list.jsp\">상품 목록으로</a>]");
     			}  
  		}         
  	st.close();
  	con.close();
  	} catch (SQLException e) {
  		out.println(e.getMessage());
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
    