<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Goods" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的商品详情页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<% 
	Goods sellsGoods = (Goods)session.getAttribute("sellsGoods");
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
			<td>发货地址：</td>
			<td><%= sellsGoods.getFromAddress() %></td>
		</tr>
	</table>
	<a href="SellServlet?type=changeGoodsInfo">修改商品信息</a>
	<a href="SellServlet?type=seeGoodsEvaluate&page=0">查看评论</a>
	<a href="SellServlet?type=deleteGoods">删除该商品</a>
	<hr>
	<table>
		<tr>
			<td valign="top">详细描述：</td>
			<td><%= sellsGoods.getDetail().replaceAll("\n", "<br>") %></td>
		</tr>
	</table>
</body>
</html>