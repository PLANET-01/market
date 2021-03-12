package model;

public class Wallet {
	private String userID;
	private double balance;
	private String payPassword;
	
	public Wallet() {}

	public Wallet(String userID, double balance, String payPassword) {
		this.userID = userID;
		this.balance = balance;
		this.payPassword = payPassword;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public String getPayPassword() {
		return payPassword;
	}

	public void setPayPassword(String payPassword) {
		this.payPassword = payPassword;
	}
}
