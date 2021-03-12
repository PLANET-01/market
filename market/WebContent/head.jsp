<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User"%>
<%-- 该文件不作为单独的网页页面，而是作为每个网页的头部，被其它网页包含 --%>
	<style>
		a:link {
			color: blue;	
		}
		a:visited {
			color: blue;	
		}
	</style>
	<div id="head">
		<h2>基于B/S架构的二手交易系统</h2>
		<%
			User user2 = null;
			String nickname = null;
			user2 = (User)session.getAttribute("user");
			if(user2 != null) nickname = user2.getNickname();
			if(nickname != null) {
		%>
		<form name="seach" action="BuyServlet" method="get">
			<table>
				<tr>
					<td><a href="/market/">本站首页 </a></td>
					<td><a href="/market/UserServlet?type=myInfo"> 你好，<%= nickname %> </a></td>
					<td><a href="/market/UserServlet?type=myWalletInfo"> 我的钱包 </a></td>
					<td><a href="/market/SellServlet?type=sellsList&page=0"> 我的商品 </a></td>
					<td><a href="/market/BuyServlet?type=buyOrderList&page=0"> 购买订单 </a></td>
					<td><a href="/market/SellServlet?type=sellOrderList&page=0"> 售出订单 </a></td>
					<td><input type="text" name="searchText" placeholder="输入多个关键字以搜索商品，用空格隔开" size=38><input type="submit" value="搜索"></td>
				</tr>
			</table>
			<input type="hidden" name="page" value="0">
			<input type="hidden" name="type" value="searchGoods">
		</form>
		<%
			} else {
		%>
		<form name="seach" action="BuyServlet" method="get">
			<table>
				<tr>
					<td><a href="/market/UserServlet?type=login"> 登录 </a></td>
					<td><a href="/market/UserServlet?type=register"> 注册 </a></td>
					<td> <input type="text" name="searchText" placeholder="输入多个关键字以搜索商品，用空格隔开" size=38><input type="submit" value="搜索"></td>
				</tr>
			</table>
			<input type="hidden" name="page" value="0">
			<input type="hidden" name="type" value="searchGoods">
		</form>
		<% } %>
		<hr>
	</div>