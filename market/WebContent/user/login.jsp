<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录/注册</title>
</head>
<body>
	<% 
	String loginID = (String)request.getAttribute("loginID");
	if(loginID == null) loginID = "";
	%>
	<a href="index.jsp">返回首页</a>
	<form name="login" action="UserServlet?type=login" method="post">
		<table>
			<tr>
				<td>手机号：</td>
				<td><input type="number" name="loginID" value="<%= loginID %>"></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input type="password" name="loginPassword"></td>
			</tr>
		</table>
		<input type="submit" name="submit" value="登录">
	</form>
	<%  
	String message = (String)request.getAttribute("message");
	if(message != null) {
		out.println(message);
	}
	%>
</body>
</html>