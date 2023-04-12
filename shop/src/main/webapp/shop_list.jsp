<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head><title>쇼핑하기 </title>
<link rel="stylesheet" href="style1.css">
<script type="text/javascript">
function view(temp) {
	if (temp.length > 0) { 
		url = "http://localhost:8090/shop/upload/" + temp;
		window.open(url, "win", "height=350,width=450,toolbar=0,menubar=0,scrollbars=1,resizable=1,status=0");
  }
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
	Home > 쇼핑하기
	<hr>
<p align=center>
<font color=#000080 face=굴림 size=3>
<strong>쇼핑하기</strong>
</font>
</p> 
 
<form method=post name=search action="shop_list.jsp" style="margin:auto">
<table style="margin-left:auto; margin-right:auto;">
 <tr>
  	<th align=right>
   	<font size=-1>상품명으로 찾기</font>
   	<input type=text name=pname>
   	<input type=submit value="검색">
   	</th>
 </tr>
 <tr>
  	<th>
   	<font size=-1>
    <a href="shop_list.jsp">전체</a>-
    <a href="shop_list.jsp?cat=11">가구</a>-
    <a href="shop_list.jsp?cat=22">전기/전자</a>-
    <a href="shop_list.jsp?cat=33">부엌용품</a>-
    <a href="shop_list.jsp?cat=44">의류</a>-
    <a href="shop_list.jsp?cat=55">보석 및 악세사리</a>-
    <a href="shop_list.jsp?cat=66">헬스 기구</a>-
    <a href="shop_list.jsp?cat=77">컴퓨터 관련</a>-
    <a href="shop_list.jsp?cat=88">기타</a>
   	</font>
  	</th>
 </tr>
</table>
</form>
 
<table style="margin-left:auto; margin-right:auto">
<% 
 String cond="";
 String ca="";
 String pn="";
 
 if (request.getParameter("cat") != null) {
  if( !(request.getParameter("cat").equals("")) ) {
   ca=request.getParameter("cat");
   cond= " where category = '"+ ca+"'";
  }
 }
 
 if (request.getParameter("pname") != null) {
  if ( !(request.getParameter("pname").equals("")) ) {
   pn=request.getParameter("pname");
   cond= " where pname like '%"+ pn+"%'";
  }
 }

 Vector pname=new Vector();
 Vector sname=new Vector();
 Vector keyid=new Vector();
 Vector price=new Vector();
 Vector dprice=new Vector();
 Vector stock=new Vector();
 Vector small=new Vector();
 Vector large=new Vector();
 Vector description=new Vector();
 
 String url = "http://localhost:8090/shop/upload/";
 
 NumberFormat nf= NumberFormat.getNumberInstance();
 
 int stocki;
 String pricestr=null;
 String dpricestr=null;
 String filename="";
 
 int where=1;
 
 if (request.getParameter("go") != null) 
  where = Integer.parseInt(request.getParameter("go"));
 
 int nextpage=where+1;
 int priorpage = where-1;
 int startrow=0;
 int endrow=0;
 int maxrows=3;
 int totalrows=0;
 int totalpages=0;
 
 long id=0;
 
 Connection con= null;
 Statement st =null;
 ResultSet rs =null;
 
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
  st = con.createStatement();
  String sql = "select * from product" ;
  sql = sql+ cond+  " order by id desc";
  rs = st.executeQuery(sql);
 
  if (!(rs.next()))  
   out.println("상품이 없습니다");
  else {
   do {
    keyid.addElement(new Long(rs.getLong("id")));
    pname.addElement(rs.getString("pname"));
    sname.addElement(rs.getString("sname"));
    price.addElement(new Integer(rs.getInt("price")));
    dprice.addElement(new Integer(rs.getInt("downprice"))); 
    stock.addElement(new Integer(rs.getInt("stock")));
    description.addElement(rs.getString("description"));
    small.addElement(rs.getString("small"));
    large.addElement(rs.getString("large"));
   }while(rs.next());
      
   totalrows = pname.size();
   totalpages = (totalrows-1)/maxrows +1;
 
   startrow = (where-1) * maxrows;
   endrow = startrow+maxrows-1  ;
 
   if (endrow >= totalrows)
    endrow=totalrows-1;
      
   for(int j=startrow;j<=endrow;j++) { 
    id= ((Long)keyid.elementAt(j)).longValue();
    stocki= ((Integer)stock.elementAt(j)).intValue();
    filename = url+(String)small.elementAt(j);
    pricestr= nf.format(price.elementAt(j)); 
    dpricestr=nf.format(dprice.elementAt(j)); 
 
    out.println("<tr ><th rowspan=4>");
    out.println("<a href=javascript:view(\""+large.elementAt(j)+"\")>"); 
    out.println("<img border=0 width=70 height=70 src=\""+filename+"\">");
    out.println("<br>확대</a></th>");
    out.println("<td bgcolor=#dfedff>");
    out.println("<font face='돋움체' color=black>");
    out.println( pname.elementAt(j)+"(코드:"+id+")");
    out.println("</font></td></tr>");
    out.println("<tr>");
    out.println("<td   bgcolor=#eeeeee>");
    out.println(description.elementAt(j));
    out.println("</td></tr>"); 
    out.println("<tr><td align=right>");
    out.println("시중가: <strike>"+ pricestr+"</strike>원&nbsp;&nbsp;");  
    out.println("판매가: "+ dpricestr+"원");  
    out.println("</td></tr>"); 
    out.println("<form method=post name=search action=\"sale_save.jsp\">");
	out.println("<tr>");
    out.println("<td align=right >");
    out.println("제조(공급)원 : "+sname.elementAt(j)+"&nbsp;&nbsp;");

    if (stocki >0) { 
     out.println("주문수량");
     out.println("<input type=text name=quantity size=2 value=1>개");
     out.println("<input type=hidden name=id value="+id+">");
     out.println("<input type=hidden name=go value="+where+">");
     out.println("<input type=hidden name=cat value="+ca+">");
     out.println("<input type=hidden name=pname value="+pn+">");
     out.println("<input type=submit value=\"바구니에 담기\">");
    } else
     out.println("품절");
    out.println("</td></tr></form>"); 
   }
   rs.close();    
  }
  out.println("</table>");
  st.close();
  con.close();
 } catch (SQLException e) {
  out.println(e);
 } 
 out.println("<hr color=#FF0000>");
 out.println("<div style=\"text-align:center;\">");
 if (where > 1) {
  out.print("[<a href=\"shop_list.jsp?go=1"); 
  out.print("&cat="+ca+"&pname="+pn+"\">처음</a>]");
  out.print("[<a href=\"shop_list.jsp?go="+priorpage);
  out.print("&cat="+ca+"&pname="+pn+ "\">이전</a>]");
 } else {
  out.println("[처음]") ;
  out.println("[이전]") ;
 }
 
 if (where < totalpages) {
  out.print("[<a href=\"shop_list.jsp?go="+ nextpage);
  out.print("&cat="+ca+"&pname="+pn+"\">다음</a>]");
  out.print("[<a href=\"shop_list.jsp?go="+ totalpages);
  out.print("&cat="+ca+"&pname="+pn+"\">마지막</a>]");
 } else {
  out.println("[다음]");
  out.println("[마지막]");
 }
 
 out.println (where+"/"+totalpages); 
 out.println ("전체 상품수 :"+totalrows); 
 out.println("</div>");
%>
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