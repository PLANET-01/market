package model;

import java.sql.Timestamp;

public class User {
	private String userID;
	private String nickname;
	private String password;
	private String address;
	private Timestamp registerTime;
	
	public User() {

	}

	public User(String userID, String nickname, String password, String address, Timestamp registerTime) {
		this.userID = userID;
		this.nickname = nickname;
		this.password = password;
		this.address = address;
		this.registerTime = registerTime;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Timestamp getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Timestamp registerTime) {
		this.registerTime = registerTime;
	}

	@Override
	public String toString() {
		return "User [userID=" + userID + ", nickname=" + nickname + ", password=" + password + ", address=" + address
				+ ", registerTime=" + registerTime + "]";
	}
}
