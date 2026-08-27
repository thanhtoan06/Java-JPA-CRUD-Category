<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f1f5f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        #sidebar { min-width: 260px; max-width: 260px; background: #1e293b; color: #fff; transition: all 0.3s; min-height: 100vh; }
        #sidebar.collapsed { margin-left: -260px; }
        #sidebar a { color: #cbd5e1; text-decoration: none; padding: 12px 20px; display: block; border-radius: 8px; margin: 4px 12px; }
        #sidebar a:hover, #sidebar a.active { background: #334155; color: #fff; }
        .top-navbar { background: #ffffff; border-bottom: 1px solid #e2e8f0; }
        .avatar-lg { width: 110px; height: 110px; object-fit: cover; border-radius: 50%; border: 4px solid #ef4444; }
        .stat-card { border: none; border-radius: 16px; transition: all 0.3s ease; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.08) !important; }
        .icon-square { width: 64px; height: 64px; border-radius: 14px; display: flex; align-items: center; justify-content: center; background: rgba(255, 255, 255, 0.2); }
        .quick-action-btn { transition: all 0.2s ease; border-radius: 12px; }
        .quick-action-btn:hover { transform: translateY(-3px); }
    </style>
</head>
<body>
<div class="d-flex">
    <div id="sidebar" class="d-flex flex-column p-2 shadow">
        <div class="text-center py-4">
            <c:choose>
                <c:when test="${not empty sessionScope.account.avatar}">
                    <img src="${pageContext.request.contextPath}/uploads/${sessionScope.account.avatar}" class="avatar-lg mb-3 shadow" alt="Avatar">
                </c:when>
                <c:otherwise>
                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="avatar-lg mb-3 shadow" alt="Default Avatar">
                </c:otherwise>
            </c:choose>
            <h6 class="mb-1 fw-bold text-white fs-5">${sessionScope.account.fullname}</h6>
            <span class="badge bg-danger px-3 py-1 fs-7">Quản Trị Viên</span>
        </div>
        <hr class="border-secondary mx-3">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="fa fa-gauge me-2"></i>Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/category"><i class="fa fa-list me-2"></i>Quản lý Danh mục</a>
        <a href="${pageContext.request.contextPath}/admin/product"><i class="fa fa-layer-group me-2"></i>Quản lý Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/user"><i class="fa fa-users me-2"></i>Quản lý Tài khoản</a>
    </div>

    <div class="flex-grow-1">
        <div class="top-navbar d-flex justify-content-between align-items-center p-3 shadow-sm">
            <div class="d-flex align-items-center">
                <button id="toggleBtn" class="btn btn-light me-3 border"><i class="fa fa-bars fs-5"></i></button>
                <h4 class="m-0 fw-bold text-dark">Bảng Điều Khiển</h4>
            </div>
            <div class="d-flex align-items-center">
                <span class="me-3 text-secondary fs-6">Xin chào, <strong class="text-dark">${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm px-3 rounded-pill"><i class="fa fa-right-from-bracket me-1"></i>Đăng xuất</a>
            </div>
        </div>

        <div class="p-4">
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm bg-primary text-white p-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-uppercase mb-1 opacity-75 fw-bold fs-7">Tổng Danh Mục</p>
                                <h1 class="fw-bold mb-0 display-5">${countCategories}</h1>
                            </div>
                            <div class="icon-square">
                                <i class="fa fa-list fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm bg-success text-white p-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-uppercase mb-1 opacity-75 fw-bold fs-7">Tổng Sản Phẩm</p>
                                <h1 class="fw-bold mb-0 display-5">${countProducts}</h1>
                            </div>
                            <div class="icon-square">
                                <i class="fa fa-layer-group fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm bg-warning text-dark p-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="text-uppercase mb-1 opacity-75 fw-bold fs-7">Tài Khoản Hệ Thống</p>
                                <h1 class="fw-bold mb-0 display-5">${countUsers}</h1>
                            </div>
                            <div class="icon-square bg-dark bg-opacity-10">
                                <i class="fa fa-users fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-12">
                    <h5 class="fw-bold text-dark mb-2"><i class="fa fa-bolt text-warning me-2"></i>Thao Tác Nhanh</h5>
                </div>
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/admin/category" class="card border-0 shadow-sm p-4 text-decoration-none text-dark quick-action-btn bg-white">
                        <div class="d-flex align-items-center">
                            <div class="bg-primary bg-opacity-10 text-primary p-3 rounded-3 me-3">
                                <i class="fa fa-folder-plus fs-3"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Quản Lý Danh Mục</h6>
                                <small class="text-muted">Xem và cập nhật các danh mục</small>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/admin/product" class="card border-0 shadow-sm p-4 text-decoration-none text-dark quick-action-btn bg-white">
                        <div class="d-flex align-items-center">
                            <div class="bg-success bg-opacity-10 text-success p-3 rounded-3 me-3">
                                <i class="fa fa-cart-plus fs-3"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Quản Lý Sản Phẩm</h6>
                                <small class="text-muted">Xem và đăng sản phẩm mới</small>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/admin/user" class="card border-0 shadow-sm p-4 text-decoration-none text-dark quick-action-btn bg-white">
                        <div class="d-flex align-items-center">
                            <div class="bg-warning bg-opacity-10 text-warning p-3 rounded-3 me-3">
                                <i class="fa fa-user-plus fs-3"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Quản Lý Tài Khoản</h6>
                                <small class="text-muted">Xem và phân quyền người dùng</small>
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-7">
                    <div class="card border-0 shadow-sm rounded-4 h-100">
                        <div class="card-header bg-white border-0 py-3">
                            <h6 class="fw-bold mb-0 text-dark"><i class="fa fa-circle-info me-2 text-primary"></i>Hướng Dẫn Quản Trị</h6>
                        </div>
                        <div class="card-body">
                            <p class="text-muted mb-3">Sử dụng các menu chức năng bên trái hoặc bộ thao tác nhanh ở trên để quản lý toàn bộ dữ liệu của hệ thống:</p>
                            <ul class="list-unstyled mb-0">
                                <li class="mb-2"><i class="fa fa-check text-success me-2"></i><strong>Danh mục:</strong> Thêm, sửa, xóa danh mục phân loại.</li>
                                <li class="mb-2"><i class="fa fa-check text-success me-2"></i><strong>Sản phẩm:</strong> Quản lý thông tin, giá bán và hình ảnh sản phẩm.</li>
                                <li><i class="fa fa-check text-success me-2"></i><strong>Tài khoản:</strong> Quản lý danh sách người dùng và phân quyền hệ thống.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="card border-0 shadow-sm rounded-4 h-100">
                        <div class="card-header bg-white border-0 py-3">
                            <h6 class="fw-bold mb-0 text-dark"><i class="fa fa-user-shield me-2 text-info"></i>Thông Tin Phiên Làm Việc</h6>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush border-0">
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-2 border-0">
                                    <span class="text-muted">Tài khoản:</span>
                                    <span class="fw-bold">${sessionScope.account.username}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-2 border-0">
                                    <span class="text-muted">Email:</span>
                                    <span class="fw-semibold text-truncate" style="max-width: 180px;">${sessionScope.account.email}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-2 border-0">
                                    <span class="text-muted">Vai trò:</span>
                                    <span class="badge bg-danger">Quản trị viên</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-2 border-0">
                                    <span class="text-muted">Trạng thái CSDL:</span>
                                    <span class="badge bg-success">MySQL Connected</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
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