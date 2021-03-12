<%@page import="model.Goods" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品搜索页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<!-- searchGoods.jsp用于显示关键词搜索商品的结果 -->
	<table>
		<tr>
			<td>商品编号</td>
			<td>商品标题</td>
			<td>商品标签</td>
			<td>商品价格</td>
		</tr>
	<% 
	String searchText = (String)request.getAttribute("searchText");
	int page3 = (Integer)request.getAttribute("page");
	Goods[] goodss = (Goods[])request.getAttribute("goodss");
	for(int i=0; i<10 && goodss[i]!=null; i++) {
	%>
		<tr>
			<td><%= goodss[i].getGoodsID() %></td>
			<td><%= goodss[i].getTitle() %></td>
			<td><%= goodss[i].getLabel() %></td>
			<td><%= goodss[i].getPrice() %></td>
			<td><a href="BuyServlet?type=goodsInfo&goodsID=<%= goodss[i].getGoodsID() %>">查看详情</a></td>
		</tr>
	<%
	}
	%>
	</table>
	<table>
		<tr>
			<td><a href="BuyServlet?type=searchGoods&searchText=<%= searchText %>&page=<%= (page3-1)>=0? page3-1:0 %>">上一页</a></td>
			<td>当前页：<%= page3 %></td>
			<td><a href="BuyServlet?type=searchGoods&searchText=<%= searchText %>&page=<%= (page3+1)>=0? page3+1:0 %>">下一页</a></td>
		</tr>	
	</table>
</body>
</html>