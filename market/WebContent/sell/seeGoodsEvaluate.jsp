<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Evaluate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品评论查看页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<table>
		<tr>
			<td>订单编号</td>
			<td>购买者编号</td>
			<td>评论时间</td>
			<td>评星（1-5）</td>
			<td>评论</td>		
		</tr>
	<%
		int page2 = (Integer)request.getAttribute("page");
		Evaluate[] evaluates = (Evaluate[])request.getAttribute("evaluates");
		for(int i=0; i<10 && evaluates[i]!=null; i++) {
	%>
		<tr>
			<td><%= evaluates[i].getOrderID() %></td>
			<td><%= evaluates[i].getUserID() %></td>
			<td><%= evaluates[i].getCmTime() %></td>
			<td><%= evaluates[i].getStars() %></td>
			<td><%= evaluates[i].getComment() %></td>
			<td><a href="SellServlet?type=seeGoodsEvaluate&page=<%= page2 %>">回复（未实现）</a></td>
		</tr>
	<%
	}
	%>
	</table>
	<table>
		<tr>
			<td><a href="SellServlet?type=seeGoodsEvaluate&page=<%= (page2-1)>=0? page2-1:0 %>">上一页</a></td>
			<td>当前页：<%= page2 %></td>
			<td><a href="SellServlet?type=seeGoodsEvaluate&page=<%= (page2+1)>=0? page2+1:0 %>">下一页</a></td>
		</tr>	
	</table>
</body>
</html>