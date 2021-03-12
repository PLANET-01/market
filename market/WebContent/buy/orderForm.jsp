<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Goods" %>
<%@page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>订单创建页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<!-- orderForm.jsp用于给购买者填写购物订单 -->
	<%
		Goods goods = (Goods)session.getAttribute("goods");
		User user = (User)session.getAttribute("user");
	%>
	<table>
		<tr>
			<td>商品编号：</td>
			<td><%= goods.getGoodsID() %></td>
		</tr>
		<tr>
			<td>商品拥有者：</td>
			<td><%= goods.getOwnerID() %></td>
		</tr>
		<tr>
			<td>标题：</td>
			<td><%= goods.getTitle() %></td>
		</tr>
		<tr>
			<td>标签：</td>
			<td><%= goods.getLabel() %></td>
		</tr>
		<tr>
			<td>库存：</td>
			<td><%= goods.getNumber() %></td>
		</tr>
		<tr>
			<td>价格：</td>
			<td><%= goods.getPrice() %></td>
		</tr>
		<tr>
			<td>上架时间：</td>
			<td><%= goods.getSubmitTime() %></td>
		</tr>
		<tr>
			<td>发货地：</td>
			<td><%= goods.getFromAddress() %></td>
		</tr>
	</table>
	<form action="BuyServlet?type=createOrder" method="post">
	<table>
		<tr>
			<td>购买数量：</td>
			<td><input type="number" name="buyNumber"></td>
		</tr>
		<tr>
			<td>收货地址：</td>
			<td><input type="text" name="toAddress" value="<%= user.getAddress() %>"></td>
		</tr>
		<tr>
			<td><input type="submit" value="提交"></td>
		</tr>
	</table>
	</form>
</body>
</html>