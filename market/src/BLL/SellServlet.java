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
import model.*;

/**
 * Servlet implementation class SellServlet
 */
@WebServlet("/SellServlet")
public class SellServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			String type = request.getParameter("type");
			Method method = SellServlet.class.getMethod(type, HttpServletRequest.class, HttpServletResponse.class);
			method.invoke(this, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//1.sellsList 传入一个包含user对象的session，和页码page；返回该用户的在售商品的对象数组 
	public void sellsList(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		int page = Integer.parseInt(request.getParameter("page"));
		Goods[] goodss = Mysql.getGoodsByOwner(user.getUserID(), page);
		request.setAttribute("page", page);
		request.setAttribute("goodss", goodss);
		try {
			request.getRequestDispatcher("sell/sellsList.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	//2.addGoods 传入一个表单，其中包含Goods的各个属性； //TODO
	//添加商品成功，则重定向到出售商品详情页，否则将通过请求转发携带错误信息返回原页面；
	public void addGoods(HttpServletRequest request, HttpServletResponse response) {
		String hasData = request.getParameter("title");
		if(hasData == null || hasData.equals("")) {
			try {
				request.getRequestDispatcher("sell/addGoods.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} else {
			HttpSession session = request.getSession();
			User user = (User)session.getAttribute("user");
			
			Date date = new Date();
			String goodsID = user.getUserID() + date.getTime();
			String ownerID = user.getUserID();
			String title = request.getParameter("title");
			String label = request.getParameter("label");
			int number = Integer.parseInt(request.getParameter("number"));			
			double price = Double.parseDouble(request.getParameter("price"));
			Timestamp submitTime = new Timestamp(date.getTime());
			String fromAddress = request.getParameter("fromAddress");
			String detail = request.getParameter("detail");
			
			Goods goods = new Goods(goodsID, ownerID, title, label, number, price, submitTime, fromAddress, detail);
			if(Mysql.insertGoods(goods)) {
				try {
					response.sendRedirect("SellServlet?type=myGoodsInfo&goodsID="+goodsID+"");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				request.setAttribute("message", "添加出错，请重试");
				try {
					request.getRequestDispatcher("sell/addGoods.jsp").forward(request, response);
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	//3.myGoodsInfo 传入一个商品的ID；返回这个商品的对象 //TODO
	public void myGoodsInfo(HttpServletRequest request, HttpServletResponse response) {
		String goodsID = request.getParameter("goodsID");
		Goods sellGoods = null;
		if(goodsID!=null) {
			sellGoods = Mysql.getGoodsByID(goodsID);
		}
		HttpSession session = request.getSession();
		session.setAttribute("sellsGoods", sellGoods);
		try {
			request.getRequestDispatcher("sell/myGoodsInfo.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//4.changeGoodsInfo //传入一个更改后的商品表单；更改成功，则返回myGoodsInfo页，否则附带错误信息返回原表单页 //TODO
	public static void changeGoodsInfo(HttpServletRequest request, HttpServletResponse response) {
		String title = request.getParameter("title");
		if(title == null) {
			try {
				request.getRequestDispatcher("sell/changeGoodsInfo.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} else {
			String label = request.getParameter("label");
			int number = Integer.parseInt(request.getParameter("number"));
			double price = Double.parseDouble(request.getParameter("price"));
			String fromAddress = request.getParameter("fromAddress");
			String detail = request.getParameter("detail");
			
			HttpSession session = request.getSession();
			Goods sellsGoods = (Goods)session.getAttribute("sellsGoods");
			sellsGoods.setTitle(title);
			sellsGoods.setLabel(label);
			sellsGoods.setNumber(number);
			sellsGoods.setPrice(price);
			sellsGoods.setFromAddress(fromAddress);
			sellsGoods.setDetail(detail);
			Mysql.updateGoodsByID(sellsGoods.getGoodsID(), sellsGoods);
			try {
				response.sendRedirect("SellServlet?type=myGoodsInfo&goodsID="+sellsGoods.getGoodsID()+"");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	} 
	
	//5.seeGoodsEvaluate //传入一个包含了sellsGoods对象的session,和页数page; 返回与这个对象相关的评论页面
	public static void seeGoodsEvaluate(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Goods sellsGoods = (Goods)session.getAttribute("sellsGoods");
		
		int page = Integer.parseInt(request.getParameter("page"));
		Evaluate[] evaluates = Mysql.getEvaluatesByGoodsID(sellsGoods.getGoodsID(), page);
		request.setAttribute("page", page);
		request.setAttribute("evaluates", evaluates);
		try {
			request.getRequestDispatcher("sell/seeGoodsEvaluate.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//6.deleteGoods //传入传入一个包含了sellsGoods对象的session；返回一个下架成功页
	public void deleteGoods(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Goods sellsGoods = (Goods)session.getAttribute("sellsGoods");
		
		if(sellsGoods == null) {
			try {
				response.getWriter().println("该商品不存在");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return;
		}
		else if(request.getParameter("comfirm") == null) {
			try {
				request.setAttribute("message", "您确认删除该商品吗？");
				request.getRequestDispatcher("sell/deleteGoods.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} 
		else if(request.getParameter("comfirm").equals("true")) {
			try {
				if (Mysql.deleteGoods(sellsGoods.getGoodsID())) {
					session.removeAttribute("sellsGoods");
					request.setAttribute("message", "删除成功");
					request.getRequestDispatcher("sell/deleteGoods.jsp").forward(request, response);
				} else {
					request.setAttribute("message", "删除出错，请联系管理员");
					request.getRequestDispatcher("sell/deleteGoods.jsp").forward(request, response);
				}
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	//7.sellOrderList //传入一个包含user对象的session，和页码page；返回这个用户的售出订单列表页
	public static void sellOrderList(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		int page = Integer.parseInt(request.getParameter("page"));
		Order[] orders = Mysql.getSellOrderList(user.getUserID(), page);
		request.setAttribute("page", page);
		request.setAttribute("orders", orders);
		try {
			request.getRequestDispatcher("sell/sellOrderList.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//8.sellOrderInfo //传入一个订单orderID；返回一个设置了order对象的,转到卖方订单详情页
	public void sellOrderInfo(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		String orderID = request.getParameter("orderID");
		Order order = Mysql.getOrderByID(orderID);
		try {
			session.setAttribute("order", order);
			request.getRequestDispatcher("sell/sellOrderInfo.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//9.addExpressID //面向卖家的发货功能 
	//从session中获取order对象，并为该对象设置expressID属性，跟新对应的数据库和session；
	public void addExpressID(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		String expressID = request.getParameter("expressID");		
		if(expressID == null) {
			try {
				request.getRequestDispatcher("sell/addExpressID.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} else {
			Order order = (Order)session.getAttribute("order");
			order.setExpressID(expressID);
			order.setOrderStatus(Order.DaiShoHuo);
			Mysql.updateOrderByID(order.getOrderID(), order);
			try {
				response.sendRedirect("SellServlet?type=sellOrderInfo&orderID="+order.getOrderID()+"");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
