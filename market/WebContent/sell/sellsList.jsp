<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Goods"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>出售商品列表页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<a href="SellServlet?type=addGoods">发布新商品</a>
	<table>
		<tr>
			<td>商品ID</td>
			<td>商品名称</td>
			<td>库存</td>
			<td>价格</td>
		</tr>
	<% 
	int page2 = (Integer)request.getAttribute("page");
	Goods[] goodss = (Goods[])request.getAttribute("goodss");
	for(int i=0; i<10 && goodss[i]!=null; i++) {
	%>
		<tr>
			<td><%= goodss[i].getGoodsID() %></td>
			<td><%= goodss[i].getTitle() %></td>
			<td><%= goodss[i].getNumber() %></td>
			<td><%= goodss[i].getPrice() %></td>
			<td><a href="SellServlet?type=myGoodsInfo&goodsID=<%= goodss[i].getGoodsID() %>">查看详情</a></td>
		</tr>
	<%
	}
	%>
	</table>
	<table>
		<tr>
			<td><a href="SellServlet?type=sellsList&page=<%= (page2-1)>=0? page2-1:0 %>">上一页</a></td>
			<td>当前页：<%= page2 %></td>
			<td><a href="SellServlet?type=sellsList&page=<%= (page2+1)>=0? page2+1:0 %>">下一页</a></td>
		</tr>
	</table>
</body>
</html>