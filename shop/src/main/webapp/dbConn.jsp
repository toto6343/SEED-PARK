<%@  page import = "java.sql.*" %>    
<%
	Connection conn = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "root";
	String passwd = "123456";
	
	Class.forName("oracle.jdbc.OracleDriver");
	conn = DriverManager.getConnection(url, user, passwd);
%>    