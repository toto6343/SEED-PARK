<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ �α���</title>
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
Home > ������ �α���
	<hr>
	<%
		String u_id = request.getParameter("uID");
		String u_pw = request.getParameter("uPW");
		
		if(u_id.equals("root") && u_pw.equals("123456"))
		{
			session.setAttribute("memberId", u_id);
			session.setAttribute("memberPw", u_pw);
			
			out.println("<p style=text-align:center><strong style=color:black>���ο� ���� ���� ���� ! <br>");
			out.println("������ [ " + u_id + " ]���� �����Ͽ����ϴ�. </strong></p>");
		}
		else
		{
			response.sendRedirect("loginErr.jsp");
		}
	%>
	<table border="0" style="margin-left:auto; margin-right:auto">
		<tr>
			<td align="center">
				<form action="membersList.jsp" method="post" >
					<input type="submit" value=" �� ��� ȸ�� �����ϱ� " >
				</form>
			</td>
			<td align="center">
				<form action="logout.jsp" method="post" >
					<input type="submit" value=" �α� �ƿ� ��" >
				</form>
			</td>
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