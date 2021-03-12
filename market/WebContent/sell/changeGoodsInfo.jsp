<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Goods" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>更改商品信息页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<% 
		Goods sellsGoods = (Goods)session.getAttribute("sellsGoods");
	%>
	<form name="changeGoodsInfo" action="SellServlet?type=changeGoodsInfo" method="post">
	<table>
		<tr>
			<td>商品编号</td>
			<td><%= sellsGoods.getGoodsID() %></td>
		</tr>
		<tr>
			<td>商品拥有者：</td>
			<td><%= sellsGoods.getOwnerID() %></td>
		</tr>
		<tr>
			<td>标题：</td>
			<td><input type="text" name="title" value="<%= sellsGoods.getTitle() %>"></td>
		</tr>
		<tr>
			<td>标签：</td>
			<td><input type="text" name="label" value="<%= sellsGoods.getLabel() %>"></td>
		</tr>
		<tr>
			<td>库存：</td>
			<td><input type="number" name="number" value="<%= sellsGoods.getNumber() %>"></td>
		</tr>
		<tr>
			<td>价格：</td>
			<td><input type="number" step="0.01" name="price" value="<%= sellsGoods.getPrice() %>"></td>
		</tr>
		<tr>
			<td>上架时间：</td>
			<td><%= sellsGoods.getSubmitTime() %></td>
		</tr>
		<tr>
			<td>发货地址：</td>
			<td><input type="text" name="fromAddress" value="<%= sellsGoods.getFromAddress() %>"></td>
		</tr>
		<tr>
			<td>详细描述：</td>
			<td></td>
		</tr>
	</table>
	<textarea rows="10" cols="60" name="detail" form="changeGoodsInfo"><%= sellsGoods.getDetail() %></textarea><br>
	<input type="submit" value="提交更改">
	</form>
</body>
</html>