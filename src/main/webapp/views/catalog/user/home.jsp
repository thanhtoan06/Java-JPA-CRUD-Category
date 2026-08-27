<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
    body { background-color: #f1f5f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    #sidebar { min-width: 260px; max-width: 260px; background: #1e293b; color: #fff; transition: all 0.3s; min-height: 100vh; }
    #sidebar.collapsed { margin-left: -260px; }
    #sidebar a { color: #cbd5e1; text-decoration: none; padding: 12px 20px; display: block; border-radius: 8px; margin: 4px 12px; }
    #sidebar a:hover, #sidebar a.active { background: #334155; color: #fff; }
    .top-navbar { background: #ffffff; border-bottom: 1px solid #e2e8f0; }
    .product-card { border: none; border-radius: 12px; transition: transform 0.2s, box-shadow 0.2s; background: #fff; }
    .product-card:hover { transform: translateY(-4px); box-shadow: 0 10px 20px rgba(0,0,0,0.08); }
    .product-img { height: 200px; object-fit: contain; padding: 15px; }
    .avatar-lg {
        width: 120px;
        height: 120px;
        object-fit: cover;
        border-radius: 50%;
        border: 4px solid #3b82f6;
        box-shadow: 0 4px 12px rgba(0,0,0,0.25);
    }
</style>
</head>
<body>
<div class="d-flex">
    <div id="sidebar" class="d-flex flex-column p-2 shadow">
        <div class="text-center py-4">
            <c:choose>
                <c:when test="${not empty sessionScope.account.avatar}">
                    <img src="${pageContext.request.contextPath}/uploads/${sessionScope.account.avatar}" 
                         class="avatar-lg mb-3" 
                         alt="Avatar"
                         onerror="this.onerror=null; this.src='https://cdn-icons-png.flaticon.com/512/149/149071.png';">
                </c:when>
                <c:otherwise>
                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" 
                         class="avatar-lg mb-3" 
                         alt="Default Avatar">
                </c:otherwise>
            </c:choose>
            <h5 class="mb-1 fw-bold text-white">${sessionScope.account.fullname}</h5>
            <span class="badge bg-primary px-3 py-1">User</span>
        </div>
        <hr class="border-secondary mx-3">
        <a href="${pageContext.request.contextPath}/user/home" class="active"><i class="fa fa-border-all me-2"></i>Xem sản phẩm</a>
        <a href="${pageContext.request.contextPath}/account/profile"><i class="fa fa-user-gear me-2"></i>Quản lý tài khoản</a>
    </div>

    <div class="flex-grow-1">
        <div class="top-navbar d-flex justify-content-between align-items-center p-3 shadow-sm">
            <div class="d-flex align-items-center">
                <button id="toggleBtn" class="btn btn-light me-3 border"><i class="fa fa-bars fs-5"></i></button>
                <h4 class="m-0 fw-bold text-dark me-3">Trang chủ</h4>
            </div>

            <form action="${pageContext.request.contextPath}/user/home" method="get" class="d-flex flex-grow-1 mx-4" style="max-width: 400px;">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" placeholder="Tìm tên sản phẩm..." value="${keyword}">
                    <button class="btn btn-primary" type="submit"><i class="fa fa-search"></i> Tìm</button>
                </div>
            </form>

            <div>
                <span class="me-3 text-secondary">Xin chào, <strong class="text-dark">${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm px-3"><i class="fa fa-right-from-bracket me-1"></i>Đăng xuất</a>
            </div>
        </div>

        <div class="p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="text-dark fw-bold m-0">Danh sách sản phẩm</h4>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/user/home" class="btn btn-sm btn-secondary"><i class="fa fa-rotate-left me-1"></i>Xem tất cả sản phẩm</a>
                </c:if>
            </div>

            <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                <c:forEach items="${productList}" var="p">
                    <div class="col">
                        <div class="card h-100 product-card shadow-sm">
                            <img src="${pageContext.request.contextPath}/uploads/${p.image}" class="card-img-top product-img" alt="${p.productName}" onerror="this.onerror=null; this.src='https://via.placeholder.com/200?text=No+Image';">
                            <div class="card-body d-flex flex-column">
                                <h6 class="card-title fw-bold text-dark mb-2">${p.productName}</h6>
                                <p class="card-text text-muted small flex-grow-1">${p.description}</p>
                                <div class="mt-3">
                                    <span class="text-danger fw-bold fs-5"><fmt:formatNumber value="${p.price}" pattern="#,###"/> VNĐ</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('toggleBtn').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('collapsed');
    });
</script>
</body>
</html>