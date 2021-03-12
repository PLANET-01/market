<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Goods" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>确认删除商品页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<a href="SellServlet?type=sellsList&page=0">返回我的出售页</a><br>
	<% 
		Goods sellsGoods = (Goods)session.getAttribute("sellsGoods");
		if(sellsGoods!=null) {
	%>
	<table>
		<tr>
			<td>商品编号：</td>
			<td><%= sellsGoods.getGoodsID() %></td>
		</tr>
		<tr>
			<td>商品拥有者：</td>
			<td><%= sellsGoods.getOwnerID() %></td>
		</tr>
		<tr>
			<td>标题：</td>
			<td><%= sellsGoods.getTitle() %></td>
		</tr>
		<tr>
			<td>标签：</td>
			<td><%= sellsGoods.getLabel() %></td>
		</tr>
		<tr>
			<td>库存：</td>
			<td><%= sellsGoods.getNumber() %></td>
		</tr>
		<tr>
			<td>价格：</td>
			<td><%= sellsGoods.getPrice() %></td>
		</tr>
		<tr>
			<td>上架时间：</td>
			<td><%= sellsGoods.getSubmitTime() %></td>
		</tr>
		<tr>
			<td>发货地：</td>
			<td><%= sellsGoods.getFromAddress() %></td>
		</tr>
	</table>
	<%
		}
		String message = (String)request.getAttribute("message");
		if(message==null) message = "";
	%>
	<span><%= message %></span><br>
	<%
		if(message.equals("您确认删除该商品吗？")) {
	%>
	<a href="SellServlet?type=deleteGoods&comfirm=true">确认删除</a>
	<%
		}
	%>
	
</body>
</html>