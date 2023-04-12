<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head><title>상품 설명(이미지) 보기</title>
<script type="text/javascript">
function view(temp) {
	filename = "http://localhost:8090/shop/images/" + temp;
	i = window.open(filename, "win", "height=350,width=450,toolbar=0,menubar=0,scrollbars=1,resizable=1,status=0");
	}
</script>
</head>
<body>
<%

String ca="";
String pn="";

if (request.getParameter("cat") != null) 
	if( !(request.getParameter("cat").equals("")) )
		ca=request.getParameter("cat");
if (request.getParameter("pname") != null)
	if ( !(request.getParameter("pname").equals("")) )
		pn=request.getParameter("pname");
  
 //pn = new String(pn.getBytes("ISO-8859-1"),"euc-kr");
out.println(pn);

String sql=null;
Connection con= null;
Statement st =null;
ResultSet rs =null;
 
long id = Long.parseLong(request.getParameter("id"));
 
String url = "http://localhost:8090/shop/upload/";
String small=null;
 
out.print("[<A href=\"product_list.jsp?go="+ request.getParameter("go"));
out.print("&cat="+ ca +"&pname="+pn+"\">상품 목록으로</A>]");
 
try {
	Class.forName("oracle.jdbc.OracleDriver");
	} catch (ClassNotFoundException e ) {
		out.println(e);
	}

try {
	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","root","123456");
	} catch (SQLException e) {
		out.println(e);
		}
try {
	st = con.createStatement();
  	sql = "select * from product where id="+id;
  	rs = st.executeQuery(sql);
  	if (!(rs.next()))  {
  		out.println("해당 내용이 없습니다");
  		} else {
  			small=url+rs.getString("small");
   			out.println("<table width=500 border=0 >");
   			out.println("<tr><th rowspan=3>");
 
   			out.println("<a href=javascript:view(\""+rs.getString("large")+"\")>"); 
   			out.println("<img width=100 height=100 src="+small+">");
   			out.println("<br>확대</a></th>");
   			out.println("<th bgcolor=#003399>");
   			out.println("<font face=굴림 color=white>");
   			out.println(rs.getString("pname")+"("+rs.getLong("id")+")");
   			out.println("---작성자:"+rs.getString("wname"));
   			out.println("</font></th></tr>");  
   			out.println("<tr>");
   			out.println("<td>");
   			out.println("<u>상세 설명 :</u><br>");
   			out.println(rs.getString("description") );
   			out.println("</td></tr>"); 
   			out.println("<tr><td align=right>");   
   			out.println("제조(공급)원:"+rs.getString("sname")+"<br>");
   			out.println("시중가:<strike>"+rs.getString("price")+"</strike>원");
   			out.println("판매가:"+rs.getString("downprice")+"원");
   			out.println("</td></tr>");  
   			out.println("</table>");
   			}
  	rs.close();
  	st.close();
  	con.close();
  	} catch (SQLException e) {
  		out.println(e);
  		} 
%>
</body>
</html>