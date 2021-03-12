<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DAL.Mysql"%>
<%@ page import="model.User"%>
<%@ page import="model.Goods"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>基于B/S架构的二手交易系统</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<h4>最新商品：</h4>
	<table>
		<tr>
			<td>商品编号</td>
			<td>商品名称</td>
			<td>商品标签</td>
			<td>商品价格</td>
			<td>上架时间</td>
		</tr>
	<% 
		String str = request.getParameter("page");
		int page3 = 0;
		if(str != null && !str.equals("")) {
			page3 = Integer.parseInt(str);
		}
		Goods[] goodss = Mysql.getLatestGoods(page3);
		for(int i=0; i<goodss.length && goodss[i]!=null; i++) {
	%>
		<tr>
			<td><%= goodss[i].getGoodsID() %></td>
			<td><%= goodss[i].getTitle() %></td>
			<td><%= goodss[i].getLabel() %></td>
			<td><%= goodss[i].getPrice() %></td>
			<td><%= goodss[i].getSubmitTime() %></td>
			<td><a href="BuyServlet?type=goodsInfo&goodsID=<%= goodss[i].getGoodsID() %>">查看详情</a></td>
		</tr>
	<%	}	%>
	</table>
	<table>
		<tr>
			<td><a href="index.jsp?page=<%= (page3-1)>=0? page3-1:0 %>">上一页</a></td>
			<td>当前页：<%= page3 %></td>
			<td><a href="index.jsp?page=<%= (page3+1)>=0? page3+1:0 %>">下一页</a></td>
		</tr>
	</table>
</body>
</html>