<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� Ż�� ����</title>
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
	Home > ȸ�� Ż�� ����
	<hr>
	<p style="text-align:center; font-size:20px; color:black"> �׵��� �����߽��ϴ�. <p>

	<table border="0" style="margin-left:auto; margin-right:auto">
		<tr>
			<td>
				<form action="main.jsp" method="post" >
					<input type="submit" value=" �� ���� ȭ������ " >
				</form>	
			</td>
			<td>		
				<form action="signup.jsp" method="post" >
					<input type="submit" value=" �ٽ� �����ϱ� ��" >
				</form>
			</td>
		</tr>	 
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