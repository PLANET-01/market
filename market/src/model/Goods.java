package model;

import java.sql.Timestamp;

public class Goods {
	public static final int WeiShenHe = 0;
	public static final int YiShenHe = 1;
	private static final String[] statusMap = {"未审核","已审核"};
	
	private String goodsID;
	private String ownerID;
	private String title;
	private String label;
	private int number;
	private double price;
	private Timestamp submitTime;
	private String fromAddress;
	private String detail;
	
	public Goods() {}

	public Goods(String goodsID, String ownerID, String title, String label, int number, double price,
			Timestamp submitTime, String fromAddress, String detail) {
		this.goodsID = goodsID;
		this.ownerID = ownerID;
		this.title = title;
		this.label = label;
		this.number = number;
		this.price = price;
		this.submitTime = submitTime;
		this.fromAddress = fromAddress;
		this.detail = detail;
	}

	public String getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(String goodsID) {
		this.goodsID = goodsID;
	}

	public String getOwnerID() {
		return ownerID;
	}

	public void setOwnerID(String ownerID) {
		this.ownerID = ownerID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Timestamp getSubmitTime() {
		return submitTime;
	}

	public void setSubmitTime(Timestamp submitTime) {
		this.submitTime = submitTime;
	}

	public String getFromAddress() {
		return fromAddress;
	}

	public void setFromAddress(String fromAddress) {
		this.fromAddress = fromAddress;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public static int getWeishenhe() {
		return WeiShenHe;
	}

	public static int getYishenhe() {
		return YiShenHe;
	}

	public static String[] getStatusmap() {
		return statusMap;
	}	
}

	