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
import model.Evaluate;
import model.Goods;
import model.Order;
import model.User;
import model.Wallet;

/**
 * Servlet implementation class BuyServlet
 */
@WebServlet("/BuyServlet")
public class BuyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuyServlet() {
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
			String type = request.getParameter("type");
			Method method = BuyServlet.class.getMethod(type, HttpServletRequest.class, HttpServletResponse.class);
			method.invoke(this, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//1.searchGoods 
	public void searchGoods(HttpServletRequest request, HttpServletResponse response) {
		//先从浏览器请求信息中获得相关数据
		String searchText = (String)request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		//使用数据访问层获得goods对象
		Goods[] goodss = Mysql.searchGoods(searchText, page); 
		//设置一些属性，然后转发到用户表现层
		request.setAttribute("searchText", searchText);
		request.setAttribute("page", page);
		request.setAttribute("goodss", goodss);
		try {
			request.getRequestDispatcher("buy/searchGoods.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//2.goodsInfo 
	public void goodsInfo(HttpServletRequest request, HttpServletResponse response) {
		String goodsID = request.getParameter("goodsID");
		Goods goods = null;
		if(goodsID!=null) {
			goods = Mysql.getGoodsByID(goodsID);
		}
		HttpSession session = request.getSession();
		session.setAttribute("goods", goods); //供创建订单使用
		try {
			request.getRequestDispatcher("buy/goodsInfo.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//3.createOrder 
	public void createOrder(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if(user == null) {
			try {
				response.sendRedirect("UserServlet?type=login");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return;
		}
		
		String number = request.getParameter("buyNumber");
		if(number == null || number.equals("")) {
			try {
				request.getRequestDispatcher("buy/orderForm.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} else {
			//buyNumber 和 toAddress 从表单获取
			Goods goods = (Goods)session.getAttribute("goods");
			Date date = new Date();
			String orderID = user.getUserID() + date.getTime();
			String buyerID = user.getUserID();
			String sellerID = goods.getOwnerID();
			String goodsID = goods.getGoodsID();
			int buyNumber = Integer.parseInt(request.getParameter("buyNumber")); //从表单获取
			double buyPrice = goods.getPrice();
			double totalMoney = buyNumber*buyPrice;
			int orderStatus = Order.DaiFuKuan;
			Timestamp startTime = new Timestamp(date.getTime());
			Timestamp endTime = new Timestamp(0);
			String toAddress = request.getParameter("toAddress"); //从表单获取
			String expressID = "";
			
			Order order = new Order(orderID, buyerID, sellerID, goodsID, buyNumber, buyPrice, totalMoney, orderStatus, startTime, endTime, toAddress, expressID);
			boolean a = Mysql.insertOrder(order);
			goods.setNumber(goods.getNumber()-buyNumber);
			session.setAttribute("goods", goods);
			boolean b = Mysql.updateGoodsByID(goodsID, goods);
			if(a && b) {
				try {
					response.sendRedirect("BuyServlet?type=orderInfo&orderID="+order.getOrderID());
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				System.out.print(a+"\t"+b);
			}
		}
	}
	
	//4.orderInfo 
	public void orderInfo(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String orderID = request.getParameter("orderID");
		Order order = Mysql.getOrderByID(orderID);
		
		try {
			session.setAttribute("order", order);
			request.getRequestDispatcher("buy/orderInfo.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//5.payOrder 
	public void payOrder(HttpServletRequest request, HttpServletResponse response) {
		String payPassword = request.getParameter("payPassword");
		if(payPassword==null) {
			try {
				request.getRequestDispatcher("buy/payOrder.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} else {
			HttpSession session = request.getSession();
			User user = (User)session.getAttribute("user");
			Wallet wallet = Mysql.getWalletByID(user.getUserID());
			Order order = (Order)session.getAttribute("order");
			
			if(payPassword.equals(wallet.getPayPassword())) { //密码正确，开始扣钱,并更新订单状态为“待发货”
				wallet.setBalance(wallet.getBalance()-order.getTotalMoney());
				order.setOrderStatus(Order.DaiFaHuo);
				Mysql.updateWallet(wallet);
				Mysql.updateOrderByID(order.getOrderID(), order);
				try {
					response.sendRedirect("BuyServlet?type=orderInfo&orderID="+order.getOrderID()+"");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else { //密码错误
				session.setAttribute("message", "支付密码错误");
				try {
					response.sendRedirect("BuyServlet?type=payOrder");;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	//6.commentOrder 
	public void commentOrder(HttpServletRequest request, HttpServletResponse response) {
		String text = request.getParameter("text");
		if(text != null) {
			HttpSession session = request.getSession();
			Order order = (Order)session.getAttribute("order");
			
			String orderID = order.getOrderID();
			String goodsID = order.getGoodsID();
			String userID = order.getBuyerID();
			Timestamp cmTime = new Timestamp((new Date()).getTime());
			int stars = Integer.parseInt(request.getParameter("stars"));
			String comment = text;
			Evaluate evaluate = new Evaluate(orderID, goodsID, userID, cmTime, stars, comment);
			
			if(Mysql.insertEvaluate(evaluate)) {
				order.setOrderStatus(Order.YiChengJiao);
				Mysql.updateOrderByID(order.getOrderID(), order);
				try {
					response.sendRedirect("BuyServlet?type=orderInfo&orderID="+order.getOrderID()+"");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				System.out.println("error: commentOrder");
			}
		} else {
			try {
				request.getRequestDispatcher("buy/commentOrder.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	//buyOrderList
	public void buyOrderList(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		int page = Integer.parseInt(request.getParameter("page"));
		Order[] orders = Mysql.getBuyOrderList(user.getUserID(), page);
		request.setAttribute("page", page);
		request.setAttribute("orders", orders);
		try {
			request.getRequestDispatcher("buy/buyOrderList.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//确认收货
	public void receive(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Order order = (Order)session.getAttribute("order");
		
		if(order.getOrderStatus()==Order.DaiShoHuo) {
			order.setOrderStatus(Order.DaiPingJia);
			order.setEndTime(new Timestamp((new Date()).getTime()));
			Wallet sellerWallet = Mysql.getWalletByID(order.getSellerID());
			sellerWallet.setBalance(sellerWallet.getBalance() + order.getTotalMoney());
			Mysql.updateWallet(sellerWallet);
			Mysql.updateOrderByID(order.getOrderID(), order);
		}
		try {
			response.sendRedirect("BuyServlet?type=orderInfo&orderID="+order.getOrderID()+"");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//查看商品评论
	public static void seeGoodsEvaluate(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Goods goods = (Goods)session.getAttribute("goods");
		
		int page = Integer.parseInt(request.getParameter("page"));
		Evaluate[] evaluates = Mysql.getEvaluatesByGoodsID(goods.getGoodsID(), page);
		request.setAttribute("page", page);
		request.setAttribute("evaluates", evaluates);
		try {
			request.getRequestDispatcher("buy/seeGoodsEvaluate.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
}
























