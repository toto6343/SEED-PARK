<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α���</title>
<link rel="stylesheet" href="style1.css">
</head>
<script type="text/javascript">	
		function checkFun() 
		{
			var f = document.loginForm;
			if(f.uID.value == "")
			{
				alert("���̵� �Է��� �ּ���.");
				f.uID.focus();
				return false;
			}
			else if(f.uPW.value == "")
			{
				alert("��й�ȣ�� �Է��� �ּ���.");
				f.uPW.focus();
				return false;
			}
			else return true;
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
	Home > �α���
	<hr>
	<form name="loginForm" action="loginSuccess.jsp" 
		method="post" onsubmit="return checkFun()" style="margin:auto">
		<fieldset style="width:260px; margin:auto">
			<legend> �α��� ȭ�� </legend><p>
			<table>
			<tr height="30">
				<td align="right">���̵�&nbsp;</td>
				<td><input type="text" name="uID"></td>
			</tr>
			<tr height="30">
				<td align="right">��й�ȣ&nbsp;</td>
				<td><input type="password" name="uPW"></td>
			</tr>
			<tr height="50">
				<td></td>
				<td><input type="submit" value=" �α��� ���� "></td>
			</tr>
			</table>
		</fieldset>
	</form>
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