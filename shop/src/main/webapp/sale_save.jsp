<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ֹ� �Ϸ�</title>
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
 	out.println("�ٱ��Ͽ� �־����ϴ�.");
 	out.print("[<a href=\"shop_list.jsp?go="+ request.getParameter("go"));
 	out.print("&cat="+ ca +"&pname="+pn+"\">��� �����ϱ�</a>]");
 	out.print("[<a href=\"sale_list.jsp?go="+ request.getParameter("go"));
 	out.print("&cat="+ ca +"&pname="+pn+"\">��ٱ��� ����</a>]");
 	out.println("</div>");

} catch (Exception e) {
	out.println(e);
	} 
%>
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
    