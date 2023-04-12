<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ֹ� ó��</title>
<link rel="stylesheet" href="style1.css">
</head>
<% 

int total=Integer.parseInt(request.getParameter("total"));
int count=Integer.parseInt(request.getParameter("count"));
 
NumberFormat nf= NumberFormat.getNumberInstance();
String totalstr =  nf.format(total);   

%>
<script type="text/javascript">
function check(f) {\
	blank=false;
	for (i=0; i<f.elements.length;i++) {
		if (f.elements[i].value=="") {
			if (f.elements[i].name != "number")
				blank=true;
			if ((f.elements[i].name == "number") && (f.pay.value == "card"))
				blank=true;
			}
	}
	if (blank==true)
		alert("��� �׸��� �Է��ϼž� �մϴ�.");
	else
		f.submit();
	}
	
var passwordInput = document.getElementById("number");
var passwordValue = passwordInput.value;
if (passwordValue.length >= 8) {
  passwordInput.value = passwordValue.substring(0, 8);
}	

function maskNumber() {
    var input = document.getElementById("number").value; // �Է°� ��������
    var masked = input.substring(0, 8) + "********" + input.substring(16); // 8�ڸ��� ����ŷ ó��
    document.getElementById("number").value = masked; // ����ŷ ó���� ������ �Է°� ��ü
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
<p style="text-align:center; font-size:12pt" >
[<a href= "sale_list.jsp">��ٱ��� �ٽ� ����</a>] </p>
<form method=post action="order_save.jsp" name="order" id="order">
<table style="margin-left:auto; margin-right:auto">
	<tr>
  		<th bgcolor=#003399 colspan=2>
   			<font size=+1 color=white> �ֹ��� �ۼ��ϱ�</font>
  		</th>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>�̸�</font>
  		</th>
  			<td bgcolor=#eeeeee>
   				<input type="text" id="wname" name="wname" size=30>
  			</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>���� ����</font>
  		</th>
  			<td bgcolor=#eeeeee>
   				<font size=-1>
    				<input type="radio" name="pay" value="card">ī��
    				<input type="radio" name="pay" value="cash">�¶��� �Ա�
   				</font>
  			</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>ī�� ��ȣ</font>
  		</th>
  		<td bgcolor=#eeeeee>
   			<input type="password" id="number" name="number" size=30 oninput="maskNumber()">
  		</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>��� �ּ�</font>
  		</th>
  		<td bgcolor=#eeeeee>
   			<input type="text" id="addr" name="addr" size=30>
  		</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>��ȭ��ȣ</font>
  		</th>
  		<td bgcolor=#eeeeee>
   			<input type="text" id="tel" name="tel" size=30>
  		</td>
 	</tr>
 	<tr>
  		<th width=30% bgcolor=#0033cc>
   			<font size=-1 color=white>�ֹ� �� �ݾ�</font>
  		</th>
  		<td bgcolor=#eeeeee>
   			<%=totalstr%>��
  		</td>
 	</tr>
 	<tr>
  		<td colspan=2>
  		<div style="text-align:center">
   			<input type="hidden" name="total" value=<%=total%>>
   			<input type="hidden" name="count" value=<%=count%>>
   			<input type="button" value=" Ȯ�� " onclick="check(this.form)" >
   			<input type="reset" value=" �ٽþ��� " >
   		</div>
  		</td>
 	</tr>
</table>
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