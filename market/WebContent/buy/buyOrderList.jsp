<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Order" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的购买订单列表</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<!-- buyOrderList.jsp用于向购买者提供一个订单列表页面 -->
	<table>
		<tr>
			<td>订单编号</td>
			<td>创建时间</td>
			<td>商品编号</td>
			<td>订单金额</td>
			<td>订单状态</td>
		</tr>
	<% 
	int page2 = (Integer)request.getAttribute("page");
	Order[] orders = (Order[])request.getAttribute("orders");
	for(int i=0; i<10 && orders[i]!=null; i++) {
	%>
		<tr>
			<td><%= orders[i].getOrderID() %></td>
			<td><%= orders[i].getStartTime() %></td>
			<td><%= orders[i].getGoodsID() %></td>
			<td><%= orders[i].getTotalMoney() %></td>
			<td><%= orders[i].getOrderStatus2() %></td>
			<td><a href="BuyServlet?type=orderInfo&orderID=<%= orders[i].getOrderID() %>">查看详情</a></td>
		</tr>
	<%
	}
	%>
	</table>
	<table>
		<tr>
			<td><a href="BuyServlet?type=buyOrderList&page=<%= (page2-1)>=0? page2-1:0 %>">上一页</a></td>
			<td>当前页：<%= page2 %></td>
			<td><a href="BuyServlet?type=buyOrderList&page=<%= (page2+1)>=0? page2+1:0 %>">下一页</a></td>
		</tr>
	</table>
</body>
</html>