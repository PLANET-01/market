<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Goods" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品详情页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<!-- goodsinfo.jsp用于向购买者显示商品详情 -->
	<% 
	Goods goods = (Goods)session.getAttribute("goods");
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
	<a href="BuyServlet?type=seeGoodsEvaluate&page=0">查看评论</a>
	<a href="BuyServlet?type=createOrder">购买</a>
	<hr>
	<table>
		<tr>
			<td valign="top">详细描述：</td>
			<td><%= goods.getDetail().replaceAll("\n", "<br>") %></td>
		</tr>
	</table>
</body>
</html>