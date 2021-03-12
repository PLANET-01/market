<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="index.jsp">返回首页</a>
	<form name="login" action="UserServlet?type=register" method="post">
		<table>
			<tr>
				<td>手机号：</td>
				<td><input type="number" name="userID"></td>
			</tr>
			<tr>
				<td>昵称：</td>
				<td><input type="text" name="nickname"></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td>确认密码：</td>
				<td><input type="password" name="password2"></td>
			</tr>
			<tr>
				<td>收货地址：</td>
				<td><input type="text" name="address"></td>
			</tr>
		</table>
		<input type="submit" value="注册">
	</form>
	<%  
	String error = (String)request.getAttribute("error");
	if(error != null) {
		out.println("出错，注册失败");
	}
	%>
</body>
</html>