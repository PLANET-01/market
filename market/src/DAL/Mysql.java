package DAL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Properties;

import javax.sql.rowset.CachedRowSet;
import javax.sql.rowset.RowSetFactory;
import javax.sql.rowset.RowSetProvider;

import model.Evaluate;
import model.Goods;
import model.Order;
import model.User;
import model.Wallet;

public class Mysql {
	
	//给execute方法作返回值用的内部类
	private static class Temp {
		CachedRowSet crs;
		int updateCount;
	}
	
	//执行一条传入的sql，并返回一个Temp结构的结果
	private static Temp execute(String sql) {
		Temp temp = new Temp();		
		Connection conn = null;
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			Properties info = new Properties();
			info.setProperty("user", "root");
			info.setProperty("password", "8569");
			info.setProperty("useUnicode", "true");
			info.setProperty("characterEncoding", "utf8");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/market", info);
			Statement stat = conn.createStatement();
			ResultSet rs = null;
			CachedRowSet crs = null;
			
			boolean isResult = stat.execute(sql);			
			if(isResult) {
				rs = stat.getResultSet();
				RowSetFactory rsft = RowSetProvider.newFactory();
				crs = rsft.createCachedRowSet();
				crs.populate(rs);
				temp.crs = crs;
				temp.updateCount = -1;
			} else {
				temp.updateCount = stat.getUpdateCount();
				temp.crs = null;
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return temp;
	}
	
	//以下，是UserServlet.java要调用的函数
	//1。登录验证使用
	public static User getUserByID(String ID) {
		String sql = "SELECT * FROM user WHERE userID = '"+ID+"';";
		CachedRowSet crs = Mysql.execute(sql).crs;
		User user = null;
		try {
			if(crs.next()) {
				String userID = crs.getString(1);
				String nickname = crs.getString(2);
				String password = crs.getString(3);
				String address = crs.getString(4);
				Timestamp registerTime = crs.getTimestamp(5);
				user = new User(userID, nickname, password, address, registerTime);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
	
	//2.注册使用
	public static boolean insertUser(User user) {
		String sql = "INSERT INTO user\r\n"
				+ "VALUES ('?','?','?','?','?');"; 
		sql = sql.replaceFirst("\\?", user.getUserID());
		sql = sql.replaceFirst("\\?", user.getNickname());
		sql = sql.replaceFirst("\\?", user.getPassword());
		sql = sql.replaceFirst("\\?", user.getAddress());
		sql = sql.replaceFirst("\\?", user.getRegisterTime().toString());
		int updateCount = Mysql.execute(sql).updateCount;
		if(updateCount == 1) return true;
		else return false;
	}
	
	//3.更改个人信息
	public static boolean updateUserByID(String beforeID, User newUser) {
		String sql = "UPDATE user\r\n"
				+ "SET userID='?', nickname='?', password='?', address='?', registerTime='?'\r\n"
				+ "WHERE userID='?';";
		sql = sql.replaceFirst("\\?", newUser.getUserID());
		sql = sql.replaceFirst("\\?", newUser.getNickname());
		sql = sql.replaceFirst("\\?", newUser.getPassword());
		sql = sql.replaceFirst("\\?", newUser.getAddress());
		sql = sql.replaceFirst("\\?", newUser.getRegisterTime().toString());
		sql = sql.replaceFirst("\\?", beforeID);
		int n = Mysql.execute(sql).updateCount;
		if(n==1) return true;
		else return false;
	}
	//以上，是UserServlet.java要调用的函数

	//以下，是BuyServlet.java要调用的函数
	//1.按关键字搜索商品
	public static Goods[] searchGoods(String keyword, int page) { //page>=0
		final int PAGESIZE = 10;
		String[] keywords = keyword.split("\\s+");
		int length = keywords.length;
		CachedRowSet crs = null;
		
		if(length>=1) {
			//以下，用交查询拼接多个SQL查询语句
			StringBuffer sql = new StringBuffer();
			for(int i=0; i<length; i++) {
				sql.append("(SELECT goodsID, title, label, price\r\n"
						+ "FROM goods\r\n"
						+ "WHERE title LIKE '%"+keywords[i]+"%' OR label LIKE '%"+keywords[i]+"%')\r\n"
						+ "AS a" + i + "\r\n"
						+ "NATURAL JOIN\r\n");
			}
			sql.delete(sql.length()-14, sql.length());
			String sql2 = "SELECT goodsID, title, label, price\r\n"
						+ "FROM (\r\n" + sql.toString() + ")\r\n"
						+ "ORDER BY title LIMIT "+page*PAGESIZE+", "+PAGESIZE;
			crs = Mysql.execute(sql2).crs;
		} else { 
			String sql = "SELECT goodsID, title, label, price\r\n"
					+ "FROM goods\r\n"
					+ "ORDER BY name\r\n"
					+ "LIMIT "+page*PAGESIZE+", "+PAGESIZE;
			crs = Mysql.execute(sql).crs;
		}
		Goods[] goods = new Goods[PAGESIZE];
		try {
			for(int i=0; crs.next(); i++) {
				goods[i] = new Goods();
				goods[i].setGoodsID(crs.getString(1));
				goods[i].setTitle(crs.getString(2));
				goods[i].setLabel(crs.getString(3));
				goods[i].setPrice(crs.getDouble(4));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goods;
	}
	
	//2获得商品的详细信息
	public static Goods getGoodsByID(String ID) {
		Goods goods = null;
		String sql = "SELECT * FROM goods WHERE goodsID = '"+ID+"'";
		CachedRowSet crs = Mysql.execute(sql).crs;
		try {
			if(crs.next()) {
				String goodsID = crs.getString(1);
				String ownerID = crs.getString(2);
				String title = crs.getString(3);
				String label = crs.getString(4);
				int number = crs.getInt(5);
				double price = crs.getDouble(6);
				Timestamp submitTime = crs.getTimestamp(7);
				String fromAddress = crs.getString(8);
				String detail = crs.getString(9);
				goods = new Goods(goodsID, ownerID, title, label, number, price, submitTime, fromAddress, detail);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goods;
	}
	
	//3.插入新订单 
	public static boolean insertOrder(Order order) {
		String sql = "INSERT INTO `order` VALUES ('" 
				+ order.getOrderID() + "','" 
				+ order.getBuyerID() + "','"
				+ order.getSellerID() + "','"
				+ order.getGoodsID() + "','" 
				+ order.getBuyNumber() + "','" 
				+ order.getBuyPrice() + "','"
				+ order.getTotalMoney() + "','" 
				+ order.getOrderStatus() + "','" 
				+ order.getStartTime() + "','"
				+ order.getEndTime() + "','" 
				+ order.getToAddress() + "','"
				+ order.getExpressID() + "');";
		int updateCount = Mysql.execute(sql).updateCount;
		if(updateCount == 1) return true;
		else return false;
	}
	
	//4查询特定的订单
		public static Order getOrderByID(String ID) {
			Order order = null;
			String sql = "SELECT * FROM `order` WHERE orderID = '"+ID+"'";
			CachedRowSet crs = Mysql.execute(sql).crs;
			try {
				if(crs.next()) {
					String orderID = crs.getString(1);
					String buyerID = crs.getString(2);
					String sellerID = crs.getString(3);
					String goodsID = crs.getString(4);
					int buyNumber = crs.getInt(5);
					double buyPrice = crs.getDouble(6);
					double totalMoney = crs.getDouble(7);
					int orderStatus = crs.getInt(8);
					Timestamp startTime = crs.getTimestamp(9);
					Timestamp endTime = crs.getTimestamp(10);
					String toAddress = crs.getString(11);
					String expressID = crs.getString(12);
					order = new Order(orderID, buyerID, sellerID, goodsID, buyNumber, buyPrice, totalMoney, orderStatus, startTime, endTime, toAddress, expressID);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return order;
		}
	
	//5.更新订单 
	public static boolean updateOrderByID(String ID, Order order) {
		String sql = "UPDATE `order`\r\n"
				+ "SET\r\n"
				+ "orderID='"+order.getOrderID()+"',"
				+ "buyerID='"+order.getBuyerID()+"',"
				+ "sellerID='"+order.getSellerID()+"',"
				+ "goodsID='"+order.getGoodsID()+"',"
				+ "buyNumber='"+order.getBuyNumber()+"',"
				+ "buyPrice='"+order.getBuyPrice()+"',"
				+ "totalMoney='"+order.getTotalMoney()+"',"
				+ "orderStatus='"+order.getOrderStatus()+"',"
				+ "startTime='"+order.getStartTime()+"',"
				+ "endTime='"+order.getEndTime()+"',"
				+ "toAddress='"+order.getToAddress()+"',"
				+ "expressID='"+order.getExpressID()+"'\r\n"
				+ "WHERE orderID='"+ID+"'";
		int n = Mysql.execute(sql).updateCount;
		if(n==1) return true;
		else return false;
	}
	
	//6.插入评论 
	public static boolean insertEvaluate(Evaluate evaluate) {
		String sql = "INSERT INTO evaluate VALUES ('"
				+evaluate.getOrderID()+"','"
				+evaluate.getGoodsID()+"','"
				+evaluate.getUserID()+"','"
				+evaluate.getCmTime()+"','"
				+evaluate.getStars()+"','"
				+evaluate.getComment()+"');";
		int n = Mysql.execute(sql).updateCount;
		if(n==1) return true;
		else return false;
	}
	
	//7.得到自己的钱包
	public static Wallet getWalletByID(String ID) {
		Wallet wallet = null;
		String sql = "SELECT * FROM wallet WHERE userID = '"+ID+"'";
		CachedRowSet crs = Mysql.execute(sql).crs;
		try {
			if(crs.next()) {
				String userID = crs.getString(1);
				double balance = crs.getDouble(2);
				String payPassword = crs.getString(3);
				wallet = new Wallet(userID, balance, payPassword);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return wallet;
	}
	
	//8.更新自己的钱包 
	public static boolean updateWallet(Wallet wallet) {
		double balance = wallet.getBalance();
		String payPassword = wallet.getPayPassword();
		String userID = wallet.getUserID();
		String sql = "UPDATE wallet\r\n"
				+ "SET payPassword='"+payPassword+"', balance='"+balance+"'\r\n"
				+ "WHERE userID='"+userID+"'";
		int n = Mysql.execute(sql).updateCount;
		if(n==1) return true;
		else return false;
	}

	//9.更新商品 
	public static boolean updateGoodsByID(String ID, Goods goods) {
		String sql = "UPDATE goods\r\n"
				+ "SET\r\n"
				+ "goodsID='"+goods.getGoodsID()+"',"
				+ "ownerID='"+goods.getOwnerID()+"',"
				+ "title='"+goods.getTitle()+"',"
				+ "label='"+goods.getLabel()+"',"
				+ "number='"+goods.getNumber()+"',"
				+ "price='"+goods.getPrice()+"',"
				+ "submitTime='"+goods.getSubmitTime()+"',"
				+ "fromAddress='"+goods.getFromAddress()+"',"
				+ "detail='"+goods.getDetail()+"'\r\n"
				+ "WHERE goodsID='"+ID+"'";
		int n = Mysql.execute(sql).updateCount;
		if(n==1) return true;
		else return false;
	}

	public static Order[] getBuyOrderList(String buyerID, int page) {
		final int PAGESIZE = 10;
		CachedRowSet crs = null;
		
		String sql = "SELECT orderID, startTime, goodsID, totalMoney, orderStatus\r\n"
				+ "FROM `order`\r\n"
				+ "WHERE buyerID='"+buyerID+"'\r\n"
				+ "ORDER BY startTime DESC\r\n"
				+ "LIMIT "+page*PAGESIZE+", "+PAGESIZE;
		crs = Mysql.execute(sql).crs;
		
		Order[] goods = new Order[PAGESIZE];
		try {
			for(int i=0; crs.next(); i++) {
				String orderID = crs.getString(1);
				Timestamp startTime = crs.getTimestamp(2);
				String goodsID = crs.getString(3);
				double totalMoney = crs.getDouble(4);
				int orderStatus = crs.getInt(5);
				goods[i] = new Order();
				goods[i].setOrderID(orderID);
				goods[i].setStartTime(startTime);
				goods[i].setGoodsID(goodsID);
				goods[i].setTotalMoney(totalMoney);
				goods[i].setOrderStatus(orderStatus);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goods;
	}
	//以上，是BuyServlet.java要调用的函数

	//以下，是SellServlet.java要调用的函数
	//1.sellsList()展示自己的商品列表
	public static Goods[] getGoodsByOwner(String ownerID, int page) { 
		final int PAGESIZE = 10;
		CachedRowSet crs = null;
		String sql = "SELECT goodsID, title, number, price\r\n"
				+ "FROM `goods`\r\n"
				+ "WHERE ownerID='"+ownerID+"'\r\n"
				+ "ORDER BY title\r\n"
				+ "LIMIT "+page*PAGESIZE+", "+PAGESIZE;
		crs = Mysql.execute(sql).crs;
		Goods[] goods = new Goods[PAGESIZE];
		try {
			for(int i=0; crs.next(); i++) {
				String goodsID = crs.getString(1);
				String title = crs.getString(2);
				int number = crs.getInt(3);
				double price = crs.getDouble(4);
				goods[i] = new Goods();
				goods[i].setGoodsID(goodsID);
				goods[i].setTitle(title);
				goods[i].setNumber(number);
				goods[i].setPrice(price);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goods;
	}
	
	//2.insertGoods() 增加自己的商品
	public static boolean insertGoods(Goods goods) { 
		String sql = "INSERT INTO `goods` VALUES ('"
				+goods.getGoodsID()+"', '"
				+goods.getOwnerID()+"', '"
				+goods.getTitle()+"', '"
				+goods.getLabel()+"', '"
				+goods.getNumber()+"', '"
				+goods.getPrice()+"', '"
				+goods.getSubmitTime()+"', '"
				+goods.getFromAddress()+"', '"
				+goods.getDetail()+"');";  
		int updateCount = Mysql.execute(sql).updateCount;
		if(updateCount == 1) return true;
		else return false;
	}
	
	//3.getCommensByGoodsID() 用于查看商品的评论
	public static Evaluate[] getEvaluatesByGoodsID(String goodsID, int page) { 
		final int PAGESIZE = 10;
		CachedRowSet crs = null;
		String sql = "SELECT *\r\n"
				+ "FROM `evaluate`\r\n"
				+ "WHERE goodsID='"+goodsID+"'\r\n"
				+ "ORDER BY orderID DESC\r\n"
				+ "LIMIT "+page*PAGESIZE+", "+PAGESIZE;
		crs = Mysql.execute(sql).crs;
		Evaluate[] evaluates = new Evaluate[PAGESIZE];
		try {
			for(int i=0; crs.next(); i++) {
				String orderID = crs.getString(1);
				String userID = crs.getString(3);
				Timestamp cmTime = crs.getTimestamp(4);
				int stars = crs.getInt(5);
				String comment = crs.getString(6);
				evaluates[i] = new Evaluate(orderID, goodsID, userID, cmTime, stars, comment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return evaluates;
	}
	
	//4.deleteGoods() 删除自己的商品 
	public static boolean deleteGoods(String ID) { 
		String sql = "DELETE FROM goods\r\n"
				+ "WHERE goodsID='"+ID+"';";  
		int updateCount = Mysql.execute(sql).updateCount;
		if(updateCount == 1) return true;
		else return false;
	}
	
	//5.getSellOrderList //传入一个用户ID，和页码page；返回这个用户的售出订单的对象数组
	public static Order[] getSellOrderList(String ID, int page) {
		final int PAGESIZE = 10;
		CachedRowSet crs = null;
		
		String sql = "SELECT orderID, startTime, goodsID, totalMoney, orderStatus\r\n"
				+ "FROM `order`\r\n"
				+ "WHERE sellerID='"+ID+"'\r\n"
				+ "ORDER BY startTime DESC\r\n"
				+ "LIMIT "+page*PAGESIZE+", "+PAGESIZE;
		crs = Mysql.execute(sql).crs;
		
		Order[] goods = new Order[PAGESIZE];
		try {
			for(int i=0; crs.next(); i++) {
				String orderID = crs.getString(1);
				Timestamp startTime = crs.getTimestamp(2);
				String goodsID = crs.getString(3);
				double totalMoney = crs.getDouble(4);
				int orderStatus = crs.getInt(5);
				goods[i] = new Order();
				goods[i].setOrderID(orderID);
				goods[i].setStartTime(startTime);
				goods[i].setGoodsID(goodsID);
				goods[i].setTotalMoney(totalMoney);
				goods[i].setOrderStatus(orderStatus);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goods;
	}
	//以上，是SellServlet.java要调用的函数
	
	//下面，是首页用的函数，用于获得最新的商品
	public static Goods[] getLatestGoods(int page) { //page>=0
		final int PAGESIZE = 10;
		String sql = "SELECT goodsID, title, label, price, submitTime\r\n"
				+ "FROM goods\r\n"
				+ "ORDER BY submitTime DESC\r\n"
				+ "LIMIT "+page*PAGESIZE+", "+PAGESIZE;
		
		CachedRowSet crs = Mysql.execute(sql).crs;
		
		Goods[] goods = new Goods[PAGESIZE];
		try {
			for(int i=0; crs.next(); i++) {
				goods[i] = new Goods();
				goods[i].setGoodsID(crs.getString(1));
				goods[i].setTitle(crs.getString(2));
				goods[i].setLabel(crs.getString(3));
				goods[i].setPrice(crs.getDouble(4));
				goods[i].setSubmitTime(crs.getTimestamp(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goods;
	}
}
