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
<head><title>�����ϱ� </title>
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
				<li><a href="#">ȸ�� �޴�<span>��</span></a>
            <ul>
              <li><a href="signup.jsp">ȸ������</a></li>
              <li><a href="login.jsp">�α���</a></li>
            </ul>
          </li>
              	<li><a href="product_write.html">��ǰ ����ϱ�</a></li>
				<li><a href="shop_list.jsp">�����ϱ�</a></li>
				<li><a href="product_list.jsp">��ü ��ǰ ����</a></li>
			</ul>
		</nav>
		</header>
<main>
	Home > �����ϱ�
	<hr>
<p align=center>
<font color=#000080 face=���� size=3>
<strong>�����ϱ�</strong>
</font>
</p> 
 
<form method=post name=search action="shop_list.jsp" style="margin:auto">
<table style="margin-left:auto; margin-right:auto;">
 <tr>
  	<th align=right>
   	<font size=-1>��ǰ������ ã��</font>
   	<input type=text name=pname>
   	<input type=submit value="�˻�">
   	</th>
 </tr>
 <tr>
  	<th>
   	<font size=-1>
    <a href="shop_list.jsp">��ü</a>-
    <a href="shop_list.jsp?cat=11">����</a>-
    <a href="shop_list.jsp?cat=22">����/����</a>-
    <a href="shop_list.jsp?cat=33">�ξ���ǰ</a>-
    <a href="shop_list.jsp?cat=44">�Ƿ�</a>-
    <a href="shop_list.jsp?cat=55">���� �� �Ǽ��縮</a>-
    <a href="shop_list.jsp?cat=66">�ｺ �ⱸ</a>-
    <a href="shop_list.jsp?cat=77">��ǻ�� ����</a>-
    <a href="shop_list.jsp?cat=88">��Ÿ</a>
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
   out.println("��ǰ�� �����ϴ�");
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
    out.println("<br>Ȯ��</a></th>");
    out.println("<td bgcolor=#dfedff>");
    out.println("<font face='����ü' color=black>");
    out.println( pname.elementAt(j)+"(�ڵ�:"+id+")");
    out.println("</font></td></tr>");
    out.println("<tr>");
    out.println("<td   bgcolor=#eeeeee>");
    out.println(description.elementAt(j));
    out.println("</td></tr>"); 
    out.println("<tr><td align=right>");
    out.println("���߰�: <strike>"+ pricestr+"</strike>��&nbsp;&nbsp;");  
    out.println("�ǸŰ�: "+ dpricestr+"��");  
    out.println("</td></tr>"); 
    out.println("<form method=post name=search action=\"sale_save.jsp\">");
	out.println("<tr>");
    out.println("<td align=right >");
    out.println("����(����)�� : "+sname.elementAt(j)+"&nbsp;&nbsp;");

    if (stocki >0) { 
     out.println("�ֹ�����");
     out.println("<input type=text name=quantity size=2 value=1>��");
     out.println("<input type=hidden name=id value="+id+">");
     out.println("<input type=hidden name=go value="+where+">");
     out.println("<input type=hidden name=cat value="+ca+">");
     out.println("<input type=hidden name=pname value="+pn+">");
     out.println("<input type=submit value=\"�ٱ��Ͽ� ���\">");
    } else
     out.println("ǰ��");
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
  out.print("&cat="+ca+"&pname="+pn+"\">ó��</a>]");
  out.print("[<a href=\"shop_list.jsp?go="+priorpage);
  out.print("&cat="+ca+"&pname="+pn+ "\">����</a>]");
 } else {
  out.println("[ó��]") ;
  out.println("[����]") ;
 }
 
 if (where < totalpages) {
  out.print("[<a href=\"shop_list.jsp?go="+ nextpage);
  out.print("&cat="+ca+"&pname="+pn+"\">����</a>]");
  out.print("[<a href=\"shop_list.jsp?go="+ totalpages);
  out.print("&cat="+ca+"&pname="+pn+"\">������</a>]");
 } else {
  out.println("[����]");
  out.println("[������]");
 }
 
 out.println (where+"/"+totalpages); 
 out.println ("��ü ��ǰ�� :"+totalrows); 
 out.println("</div>");
%>
</table>
</main>
<footer>
<div id="bottomMenu">
    	<ul>
          <li><a href="#">ȸ�� �Ұ�</a></li>
          <li><a href="#">��������ó����ħ</a></li>
          <li><a href="#">������</a></li>
          <li><a href="#">����Ʈ��</a></li>
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
        	<p>��õ�� ����Ȧ�� �־ȷ� 100�� Tel) 032-458-3254 ������ : �����<br></p>
        	<p>�̸��� : admall@damall.com</p> 
      	</div>  
</footer>
</body>
</html>