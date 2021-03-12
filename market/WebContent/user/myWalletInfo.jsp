<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Wallet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的钱包页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<% 
	String message = (String) session.getAttribute("message");
	if(message != null) {
		out.println(message);
		session.removeAttribute("message");
	}
	Wallet wallet = (Wallet)session.getAttribute("wallet");
	%>
	<table>
	<tr><td>账户ID：</td><td><%= wallet.getUserID() %></td></tr>
	<tr><td>账户余额：</td><td><%= wallet.getBalance() %></td></tr>
	</table>
	<a href="UserServlet?type=recharge">充值</a>
	<a href="UserServlet?type=withdraw">提现</a>
	<a href="UserServlet?type=changePayPassword">修改支付密码</a>
</body>
</html>