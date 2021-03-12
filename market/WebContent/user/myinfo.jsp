<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的信息页</title>
</head>
<body> 
	<%@ include file="/head.jsp" %>
	<% 
	String message = (String)session.getAttribute("message");
	if(message != null) {
		out.println(message);
		session.removeAttribute("message");
	}
	User user = (User)session.getAttribute("user");
	%>
	<table>
	<tr><td>手机号：</td><td><%= user.getUserID() %></td></tr>
	<tr><td>昵称：</td><td><%= user.getNickname() %></td></tr>
	<tr><td>收货地址：</td><td><%= user.getAddress() %></td></tr>
	<tr><td>注册时间：</td><td><%= user.getRegisterTime() %></td></tr>
	</table>
	<a href="UserServlet?type=changeMyInfo">修改个人信息</a>
	<a href="UserServlet?type=changePassword">修改密码</a>
	<a href="UserServlet?type=logout">退出登录</a>
</body>
</html>