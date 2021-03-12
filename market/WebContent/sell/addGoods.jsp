<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>发布新商品页</title>
</head>
<body>
	<%@ include file="/head.jsp" %>
	<form id="addGoods" action="SellServlet?type=addGoods" method="post">
	<table>
		<tr>
			<td>商品标题：</td>
			<td><input type="text" name="title"></td>
		</tr>
		<tr>
			<td>商品标签：</td>
			<td><input type="text" name="label"></td>
		</tr>
		<tr>
			<td>商品数量：</td>
			<td><input type="number" name="number"></td>
		</tr>
		<tr>
			<td>商品价格：</td>
			<td><input type="number" step="0.01" name="price"></td>
		</tr>
		<tr>
			<td>发货地址：</td>
			<td><input type="text" name="fromAddress"></td>
		</tr>
		<tr>
			<td>详细描述：</td>
			<td></td>
		</tr>
	</table>
	<textarea rows="10" cols="60" name="detail" form="addGoods"></textarea><br>
	<input type="submit" value="发布">
	</form>
</body>
</html>