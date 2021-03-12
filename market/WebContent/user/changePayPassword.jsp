<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>更改支付密码页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<% 
	String message = (String)request.getAttribute("message");
	if(message != null) {
		out.println(message);
	}
	%>
	<form name="changePayPassword" action="UserServlet?type=changePayPassword" method="post">
		<table>
			<tr>
				<td>原密码：</td>
				<td><input type="password" name="oldPassword" ></td>
			</tr>
			<tr>
				<td>新密码：</td>
				<td><input type="password" name="newPassword" ></td>
			</tr>
			<tr>
				<td>新密码：</td>
				<td><input type="password" name="newPassword2" ></td>
			</tr>
		</table>
		<input type="submit" name="submit" value="确认更改支付密码">
	</form>
</body>
</html>