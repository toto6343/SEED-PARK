<%@page import="java.text.NumberFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>쇼핑 목록</title>
<link rel="stylesheet" href="style1.css">
<script type="text/javascript">
function setvalue(f) {
	f.quantity.value=0;
	f.submit();
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
<p align=center>
<font color=#0000ff face=굴림 size=+1>
<strong> 쇼핑 목록 </strong>
</font>
</p> 
<table border=0 style="text-align:center; margin-left:auto; margin-right:auto" cellspacing="4" cellpadding="4">
	<tr>
  		<th width=5% bgcolor=#003399>
   		<font color=black face=굴림><nobr>번호</nobr></font>
  		</th>
  		<th width=20% bgcolor=#003399>
   		<font color=black face=굴림><nobr>상품명</nobr></font>
  		</th>
  		<th width=20% bgcolor=#003399>
   		<font color=black face=굴림><nobr>제조원</nobr></font>
  		</th>
  		<th width=25% bgcolor=#003399>
   		<font color=black face=굴림><nobr>주문 수량</nobr></font>
  		</th>
  		<th width=10% bgcolor=#003399>
  	 	<font color=black face=굴림><nobr>판매가(원)</nobr></font>
  		</th>
  		<th width=15% bgcolor=#003399>
   		<font color=black face=굴림><nobr>합계(수량*판매가)</nobr></font>
  		</th>
 	</tr>
<%
long id=0;
 
session = request.getSession();
 
String[] a = session.getValueNames();
 
String where="1";

String ca="";
String pn="";
int qty=0;
int count=0;
 
if (request.getParameter("go") != null)
	if(!(request.getParameter("go").equals("")) )
		where = request.getParameter("go");
 
if (request.getParameter("cat") != null) 
	if( !(request.getParameter("cat").equals("")) )
		ca=request.getParameter("cat");
 
if (request.getParameter("pname") != null) 
	if ( !(request.getParameter("pname").equals("")) ) 
		pn=request.getParameter("pname");

NumberFormat nf= NumberFormat.getNumberInstance();

String pricestr="";
String hap="";
int price=0;
long total=0;
 
Connection con= null;
Statement st =null;
ResultSet rs =null;
String sql=null;
 
try {
	Class.forName("oracle.jdbc.OracleDriver");
	} catch (ClassNotFoundException e ) {
		out.println(e);
		}

try{
	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "root" , "123456");
	} catch (SQLException e) {
		out.println(e);
		}
 
try {
	st = con.createStatement();
	
	for (int i=0; i < a.length; i++) {
		id = Long.parseLong(a[i].trim());
		qty = ((Integer)session.getValue(a[i])).intValue();
   		sql = "select * from product where id="+id; 
   		rs = st.executeQuery(sql);
   		
   		if (rs.next()) { 
   			count= count+1;
    		price=rs.getInt("downprice");
    		pricestr=nf.format(price); 
    		hap=nf.format(price*qty); 
    		total=total+(price*qty);
    		out.println("<form method=post action=\'sale_upd.jsp\'>");   
    		out.println("<tr>");
    		out.println("<th width=5%  bgcolor=#eeeeee>");
    		out.println(i+1+"</th>");
    		out.println("<td width=20% bgcolor=#eeeeee>");
    		out.println(rs.getString("pname")+ "</td>");
    		out.println("<td width=15% bgcolor=#eeeeee>");
    		out.println(rs.getString("sname")+ "</td>");
    		out.println("<td width=30% bgcolor=#eeeeee>");
    		out.println("<input type=text name=quantity size=2 value="+qty+">개<br/>");
    		out.println("<input type=hidden name=id value="+id+">");
    		out.println("<input type=hidden name=go value="+where+">");
    		out.println("<input type=hidden name=cat value="+ca+">");
    		out.println("<input type=hidden name=pname value="+pn+">");
    		out.println("<input type=submit value=수정>");
    		out.println("<input type=button value=삭제 onclick=\"setvalue(this.form);\">");
    		out.println("</td>");
    		out.println("<td width=10% bgcolor=#eeeeee align=right>");
    		out.println(pricestr+ "</td>");
    		out.println("<td width=10% bgcolor=#eeeeee align=right>");
    		out.println(hap+ "</td>");
    		out.println("</tr></form>");
    		}
   		}
%>
<% 
	out.println("<tr>");
  	out.println("<td width=10% align=right colspan=6>");
  	out.println("<div style=\"text-align:center;\">");
  	out.println("주문 상품 :"+count+ "품목&nbsp;&nbsp;");  
  	out.println("주문 총 합계 금액 :"+nf.format(total)+ "원</td>");
  	out.println("</div>");
  	out.println("</tr>");   
  	out.println("</table>");
  	st.close();
  	con.close();
  	
  	out.println("<div style=\"text-align:center;\">");
  	out.print("[<a href=\"shop_list.jsp?go="+ where);
  	out.print("&cat="+ ca +"&pname="+pn+"\">계속 쇼핑하기</a>]");
 
  	out.println("[<a href=\"order.jsp?total="+total+"&count="+count+"\">주문하기</a>]");
  	out.println("</div>");
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