<%@page import="manager.product.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="manager.product.ProductDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	request.setCharacterEncoding("utf-8");
	
	String realFolder = "c:/images_yhmall";
	int maxSize = 1024 * 1024 * 5 ;
	String encType = "utf-8";
	String fileName = "";
	MultipartRequest multi = null;
	
	try{
		multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration<?> files = multi.getFileNames();
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			fileName = multi.getFilesystemName(name);
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	String category = multi.getParameter("category");
	String search = request.getParameter("search");
	String pageNum = multi.getParameter("pageNum");
	if (pageNum == null) pageNum = "1";
	
	ProductDAO productDAO = ProductDAO.getInstance();
	int product_id = Integer.parseInt(multi.getParameter("product_id"));
	String product_kind = multi.getParameter("product_kind");
	String product_name = multi.getParameter("product_name");
	int product_price = Integer.parseInt(multi.getParameter("product_price"));
	int product_sale_price = Integer.parseInt(multi.getParameter("product_sale_price"));
	int product_qty = Integer.parseInt(multi.getParameter("product_qty"));
	String product_brand = multi.getParameter("product_brand");
	String product_content = multi.getParameter("product_content");
	String pre_product_image = multi.getParameter("pre_product_image");
	
	ProductDTO product = new ProductDTO();
	product.setProduct_id(product_id);
	product.setProduct_kind(product_kind);
	product.setProduct_name(product_name);
	product.setProduct_price(product_price);
	product.setProduct_sale_price(product_sale_price);
	product.setProduct_qty(product_qty);
	product.setProduct_brand(product_brand);
	product.setProduct_content(product_content);
	if(fileName == null) product.setProduct_image(pre_product_image);
	else product.setProduct_image(fileName);
	
	
	int result = productDAO.updateProduct(product); 
	
	if(result == 1){%>
		<script> 
			alert("상품이 수정되었습니다."); 
			location="productManagement.jsp?pageNum=<%=pageNum%>&category<%=category%>&search=<%=search%>"
		</script>
	<%}else{%>
		<script> 
			alert("상품수정에 실패하였습니다."); 
			history.back();
		</script>
	<%}%>
	
</body>
</html>