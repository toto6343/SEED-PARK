<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������</title>
<link rel="stylesheet" href="style1.css">
<script type="text/javascript">	
		function checkFun() 
		{
			var f = document.user_info;
			if(f.userID.value.length < 2 || f.userID.value.length > 16)
			{
				alert("���̵�� 2~16�� �̳��� �Է��ؾ� �մϴ�.");
				f.userID.focus();
				return false;
			}
			else if(f.userPW.value.length < 6)
			{
				alert("��й�ȣ�� 6�� �̻����� �Է��ؾ� �մϴ�.");
				f.userPW.focus();
				return false;
			}
			else if(f.userMAIL.value == "")
			{
				alert("�̸��� �ּҴ� �ݵ�� �Է��ؾ� �մϴ�.");
				f.userMAIL.focus();
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
	Home > ȸ�� ����
	<hr>
	<form action="insertDB.jsp" name="user_info" 
		method="post" onsubmit="return checkFun()" style="margin:auto">
		<fieldset style="width:230px; margin:auto">
			<legend> ȸ�� ���� ȭ�� </legend><p>
	
			���̵� : <br>
			<input type="text" size = "16" name="userID"><br><br>
		
			��й�ȣ : <br> 
			<input type="password" size = "16" name="userPW"><br><br>
			
			�̸��� : <br>
			<input type="email" size="30" name="userMAIL"><br>		
			<hr>
			<div style="text-align:center">
			<input type="reset" value=" �� �ٽ��ۼ� ">
			<input type="submit" value=" �����ϱ� �� ">
			<br><br>
			</div>
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