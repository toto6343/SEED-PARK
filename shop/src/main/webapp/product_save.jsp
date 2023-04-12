<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String fileurl= "E:/JSP/shop/upload/";
String saveFolder="upload";
String encType="euc-kr";
int Maxsize = 5*1024*1024;
 
ServletContext context = getServletContext();
MultipartRequest multi = null;
DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
multi = new MultipartRequest(request,fileurl,Maxsize,encType,policy);
 
String wn = multi.getParameter("wname");
String cat= multi.getParameter("category");
String pn = multi.getParameter("pname");
String sn = multi.getParameter("sname");
int price = Integer.parseInt(multi.getParameter("price"));
int dprice = Integer.parseInt(multi.getParameter("dprice"));
int stock = Integer.parseInt(multi.getParameter("stock"));
String des = multi.getParameter("description");
 
long id = 0;
int pos=0;
 
while ((pos=des.indexOf("\'", pos)) != -1) {
	String left=des.substring(0, pos);
	String right=des.substring(pos, des.length());
	des = left + "\'" + right;
	pos += 2;
}

java.util.Date yymmdd = new java.util.Date() ;
SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
 
String ymd=myformat.format(yymmdd);
 
String sql=null;
Connection con=null;
Statement st=null; 
ResultSet rs=null;  
int cnt=0; 
 
try {
	Class.forName("oracle.jdbc.OracleDriver");
	} catch (java.lang.ClassNotFoundException e){
		out.println(e.getMessage());
		}

try {
	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl?useUnicode=true&characterEncoding=UTF-8","root","123456");
  	st = con.createStatement();
  	sql = "select max(id) from  product where category= '"+cat+"'";
 
  	rs = st.executeQuery(sql);
  	rs.next();
  	id= rs.getLong(1);
  	
  	if (id==0) 
  		id=Integer.parseInt(cat+"00001");
  	else
  		id= id + 1 ;
  	
  	Enumeration files = multi.getFileNames();
  	String fname1 = (String) files.nextElement();
  	String filename1 = multi.getFilesystemName(fname1);
  	String fname2 = (String) files.nextElement();
  	String filename2 = multi.getFilesystemName(fname2);
  	
  	if (filename2 == null)
  		filename2=filename1;
  	sql = "insert into product(id,category,wname,pname,sname,price,downprice" ;
  	sql = sql+",inputdate,stock,small,large,description) values("+id+",'";      
  	sql = sql+cat+"','"+wn+"','"+pn+"','"+sn+"',"+price+","+dprice+",'"+ymd;
  	sql = sql+"',"+stock+",'"+filename2+"','"+filename1+"','"+des+"')" ;
 
  	cnt = st.executeUpdate(sql);
  	
  	if (cnt >0)
  		out.println("��ǰ�� ����߽��ϴ�.");
  	else
  		out.println("��ǰ�� ��ϵ��� �ʾҽ��ϴ�. ");
  	
  	st.close();
  	con.close();
  	
} catch (SQLException e) {
	out.println(e);
	}
%>
<p>
<a href="product_list.jsp">[��ǰ �������]</a> &nbsp;
<a href="product_write.html">[��ǰ �ø��� ������]</a>
</p>