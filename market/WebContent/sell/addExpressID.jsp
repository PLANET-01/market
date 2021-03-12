<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Order" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>订单发货页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<% 
	Order order = (Order)session.getAttribute("order");
	%>
	<form action="SellServlet?type=addExpressID" method="post">
	<table>
		<tr>
			<td>订单编号</td>
			<td><%= order.getOrderID() %></td>
		</tr>
		<tr>
			<td>购买者ID</td>
			<td><%= order.getBuyerID() %></td>
		</tr>
		<tr>
			<td>销售者ID</td>
			<td><%= order.getSellerID() %></td>
		</tr>
		<tr>
			<td>商品编号</td>
			<td><%= order.getGoodsID() %></td>
		</tr>
		<tr>
			<td>购买数量</td>
			<td><%= order.getBuyNumber() %></td>
		</tr>
		<tr>
			<td>购买价格</td>
			<td><%= order.getBuyPrice() %></td>
		</tr>
		<tr>
			<td>订单总金额</td>
			<td><%= order.getTotalMoney() %></td>
		</tr>
		<tr>
			<td>订单状态</td>
			<td><%= order.getOrderStatus2() %></td>
		</tr>
		<tr>
			<td>创建时间</td>
			<td><%= order.getStartTime() %></td>
		</tr>
		<tr>
			<td>成交时间</td>
			<td><%= order.getEndTime2() %></td>
		</tr>
		<tr>
			<td>收货地址</td>
			<td><%= order.getToAddress() %></td>
		</tr>
		<tr>
			<td>快递单号</td>
			<td><input type="text" name="expressID"></td>
		</tr>
	</table>
	<input type="submit" value="提交">
	</form>
</body>
</html>