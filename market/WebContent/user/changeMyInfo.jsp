<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>更改我的信息页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<%
		User user = (User)session.getAttribute("user");
	%>
	<form name="changeMyInfo" action="UserServlet?type=changeMyInfo" method="post">
		<table>
			<tr>
				<td>手机号：</td>
				<td><input type="number" name="userID" value="<%= user.getUserID() %>"></td>
			</tr>
			<tr>
				<td>昵称：</td>
				<td><input type="text" name="nickname" value="<%= user.getNickname() %>"></td>
			</tr>
			<tr>
				<td>收货地址：</td>
				<td><input type="text" name="address" value="<%= user.getAddress() %>"></td>
			</tr>
			<tr>
				<td>注册时间：</td>
				<td><%= user.getRegisterTime() %></td>
			</tr>
		</table>
		<input type="submit" name="submit" value="确认更改我的信息">
	</form>
</body>
</html>