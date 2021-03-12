package model;

import java.sql.Timestamp;

public class Evaluate {
	private String orderID;
	private String goodsID;
	private String userID;
	private Timestamp cmTime;
	private int stars;
	private String comment;
	
	public Evaluate() {}

	public Evaluate(String orderID, String goodsID, String userID, Timestamp cmTime, int stars, String comment) {
		this.orderID = orderID;
		this.goodsID = goodsID;
		this.userID = userID;
		this.cmTime = cmTime;
		this.stars = stars;
		this.comment = comment;
	}

	public String getOrderID() {
		return orderID;
	}

	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}

	public String getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(String goodsID) {
		this.goodsID = goodsID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public Timestamp getCmTime() {
		return cmTime;
	}

	public void setCmTime(Timestamp cmTime) {
		this.cmTime = cmTime;
	}

	public int getStars() {
		return stars;
	}

	public void setStars(int stars) {
		this.stars = stars;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
}
