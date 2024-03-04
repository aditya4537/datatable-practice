<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Product List</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">
<script	src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script src="/js/datatable.js"></script>
</head>
<body>
    <h1>Products</h1>
    <table id="productTable" class="display">
        <thead>
            <tr>
                <th>Category</th>
                <th>Product</th>
                <th>Price</th> <!-- New column for price -->
            </tr>
        </thead>
        <tbody>
            <!-- Loop through grouped products -->
            <c:forEach var="entry" items="${groupedProducts}">
                <tr>
                    <td rowspan="${entry.value.size()}">${entry.key}</td> <!-- Set rowspan for the category -->
                    <!-- Loop through products in the category -->
                    <c:forEach var="product" items="${entry.value}" varStatus="status">
                        <c:if test="${status.index != 0}">
                            <!-- Skip the first product -->
                            <tr>
                        </c:if>
                        <td>${product.name}</td>
                        <td>${product.price}</td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <script>
        $(document).ready(function() {
            $('#productTable').DataTable({
            	paging: true,
            	searching: true
            });
        });
    </script>
</body>


</html>
