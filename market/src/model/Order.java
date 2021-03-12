package model;

import java.sql.Timestamp;

public class Order {
	public static final int DaiFuKuan = 0;
	public static final int DaiFaHuo = 1;
	public static final int DaiShoHuo = 2;
	public static final int DaiPingJia = 3;
	public static final int YiChengJiao = 4;
	private static final String[] statusMap = {"待付款","待发货","待收货","待评价","已成交"};
	
	private String orderID;
	private String buyerID;
	private String sellerID;
	private String goodsID;
	private int buyNumber;
	private double buyPrice;
	private double totalMoney;
	private int orderStatus;
	private Timestamp startTime;
	private Timestamp endTime;
	private String toAddress;
	private String expressID;
	
	public Order() {}

	public Order(String orderID, String buyerID, String sellerID, String goodsID, int buyNumber, double buyPrice,
			double totalMoney, int orderStatus, Timestamp startTime, Timestamp endTime, String toAddress,
			String expressID) {
		this.orderID = orderID;
		this.buyerID = buyerID;
		this.sellerID = sellerID;
		this.goodsID = goodsID;
		this.buyNumber = buyNumber;
		this.buyPrice = buyPrice;
		this.totalMoney = totalMoney;
		this.orderStatus = orderStatus;
		this.startTime = startTime;
		this.endTime = endTime;
		this.toAddress = toAddress;
		this.expressID = expressID;
	}

	public String getOrderID() {
		return orderID;
	}

	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}

	public String getBuyerID() {
		return buyerID;
	}

	public void setBuyerID(String buyerID) {
		this.buyerID = buyerID;
	}

	public String getSellerID() {
		return sellerID;
	}

	public void setSellerID(String sellerID) {
		this.sellerID = sellerID;
	}

	public String getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(String goodsID) {
		this.goodsID = goodsID;
	}

	public int getBuyNumber() {
		return buyNumber;
	}

	public void setBuyNumber(int buyNumber) {
		this.buyNumber = buyNumber;
	}

	public double getBuyPrice() {
		return buyPrice;
	}

	public void setBuyPrice(double buyPrice) {
		this.buyPrice = buyPrice;
	}

	public double getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(double totalMoney) {
		this.totalMoney = totalMoney;
	}

	public int getOrderStatus() {
		return orderStatus;
	}
	
	public String getOrderStatus2() { //转义输出
		return statusMap[orderStatus];
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	public Timestamp getStartTime() {
		return startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public Timestamp getEndTime() {
		return endTime;
	}
	
	public String getEndTime2() { //转义输出
		if(endTime.equals(new Timestamp(0))) return "";
		else return endTime.toString();
	}

	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}

	public String getToAddress() {
		return toAddress;
	}

	public void setToAddress(String toAddress) {
		this.toAddress = toAddress;
	}

	public String getExpressID() {
		return expressID;
	}

	public void setExpressID(String expressID) {
		this.expressID = expressID;
	}
}
