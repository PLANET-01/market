package BLL;


import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAL.Mysql;
import model.User;
import model.Wallet;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			response.setCharacterEncoding("utf-8");
			String type = request.getParameter("type");
			Method method = UserServlet.class.getMethod(type, HttpServletRequest.class, HttpServletResponse.class);
			method.invoke(this, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void login(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String loginID = request.getParameter("loginID");
		String loginPassword = request.getParameter("loginPassword");
		
		try {
			//第一次访问该服务，发送登录页面
			if(loginID == null) {
				request.getRequestDispatcher("user/login.jsp").forward(request, response);
				return;
			}
			
			//登录页面访问该服务，进行登录验证
			User user = Mysql.getUserByID(loginID);
			if(user != null) {
				if(user.getPassword().equals(loginPassword)) {
					//登录成功
					session.setAttribute("user", user);
					response.sendRedirect(".");
				} else {
					//密码错
					request.setAttribute("message", "密码错误，请重新登录");
					request.setAttribute("loginID", loginID);					
					request.getRequestDispatcher("user/login.jsp").forward(request, response);
					return;
				}
			} else {
				//账户不存在
				request.setAttribute("message", "用户名错误，请重新登录");
				request.getRequestDispatcher("user/login.jsp").forward(request, response);
				return;
			}
		} catch (IOException | ServletException e) {
			e.printStackTrace();
		}
	}
	
	public void register(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userID = request.getParameter("userID");
		String nickname = request.getParameter("nickname");
		String password = request.getParameter("password");
		String address = request.getParameter("address");
		Timestamp registerTime = new Timestamp((new Date()).getTime());
		User user = new User(userID, nickname, password, address, registerTime);
        try{
        	//第一次访问该服务，发送注册页面
			if(userID == null) {
				request.getRequestDispatcher("user/register.jsp").forward(request, response);
				return;
			}
        	
        	//第二次访问，进行注册服务
            if(Mysql.insertUser(user)) { //注册成功
            	session.setAttribute("user", user);
            	response.sendRedirect(".");
            } else { //注册失败
            	request.setAttribute("error", "error");
				request.getRequestDispatcher("user/register.jsp").forward(request, response);
				return;
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
	}
	
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
		try {
			response.sendRedirect(".");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void myInfo(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.getRequestDispatcher("user/myinfo.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	public void changeMyInfo(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		String userID = request.getParameter("userID");
		String nickname = request.getParameter("nickname");
		String address = request.getParameter("address");
		
		if(userID == null) { //发送修改个人信息的页面
			try {
				request.getRequestDispatcher("user/changeMyInfo.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} else { //处理修改事务
			User newUser = new User(userID, nickname, user.getPassword(), address, user.getRegisterTime());
			Mysql.updateUserByID(user.getUserID(), newUser);
			session.setAttribute("user", newUser);
			session.setAttribute("message", "信息更改成功");
			try {
				response.sendRedirect("UserServlet?type=myInfo");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void changePassword(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		String newPassword2 = request.getParameter("newPassword2");
		
		if(oldPassword ==null) { //发送修改密码的表单页
			try {
				request.getRequestDispatcher("user/changePassword.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return;
		} else { //处理修改事务
			if(!oldPassword.equals(user.getPassword())) { //原密码错误
				try {
					request.setAttribute("message", "原密码错误");
					request.getRequestDispatcher("user/changePassword.jsp").forward(request, response);
					return;
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				}
				
			} else if(!newPassword.equals(newPassword2)) { //两个新密码不同
				try {
					request.setAttribute("message", "两个新密码不同");
					request.getRequestDispatcher("user/changePassword.jsp").forward(request, response);
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				}
				return;
			} else {
				user.setPassword(newPassword);
				User newUser = user;
				Mysql.updateUserByID(user.getUserID(), newUser);
				session.setAttribute("user", newUser);
				session.setAttribute("message", "密码更改成功");
				try {
					response.sendRedirect("UserServlet?type=myInfo");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public void myWalletInfo(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		Wallet wallet = Mysql.getWalletByID(user.getUserID());
		session.setAttribute("wallet", wallet);
		try {
			request.getRequestDispatcher("user/myWalletInfo.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	public void changePayPassword(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Wallet wallet = (Wallet)session.getAttribute("wallet");
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		String newPassword2 = request.getParameter("newPassword2");
		
		if(oldPassword ==null) { //发送修改密码的表单页
			try {
				request.getRequestDispatcher("user/changePayPassword.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return;
		} else { //处理修改事务
			try {
				if(!oldPassword.equals(wallet.getPayPassword())) { //原密码错误
					request.setAttribute("message", "原密码错误");
					request.getRequestDispatcher("user/changePayPassword.jsp").forward(request, response);
					return;
				} else if(!newPassword.equals(newPassword2)) { //两个新密码不同
					request.setAttribute("message", "两个新密码不同");
					request.getRequestDispatcher("user/changePayPassword.jsp").forward(request, response);
					return;
				} else {
					wallet.setPayPassword(newPassword);
					Wallet newWallet = wallet;
					Mysql.updateWallet(newWallet);
					session.setAttribute("wallet", newWallet);
					session.setAttribute("message", "密码更改成功");
					response.sendRedirect("UserServlet?type=myWalletInfo");
					return;
				}
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void recharge(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.getWriter().println("该功能未实现，请联系管理员充值");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void withdraw(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.getWriter().println("该功能未实现，请联系管理员提现");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
