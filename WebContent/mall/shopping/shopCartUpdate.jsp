<%@page import="cart.CartDTO"%>
<%@page import="cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=utf-8");

CartDAO cartDAO = CartDAO.getInstance();
String id = request.getParameter("id");
int product_id = Integer.parseInt(request.getParameter("product_id"));
int product_amount = Integer.parseInt(request.getParameter("product_amount"));
String code = request.getParameter("code");

if(code.equals("1")){
	cartDAO.updateCart(id, product_id, product_amount);

}


%>
</body>
</html>