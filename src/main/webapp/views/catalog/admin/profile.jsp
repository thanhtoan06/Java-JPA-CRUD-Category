<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Cá Nhân Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f1f5f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        #sidebar { min-width: 260px; max-width: 260px; background: #1e293b; color: #fff; transition: all 0.3s; min-height: 100vh; }
        #sidebar.collapsed { margin-left: -260px; }
        #sidebar a { color: #cbd5e1; text-decoration: none; padding: 12px 20px; display: block; border-radius: 8px; margin: 4px 12px; }
        #sidebar a:hover, #sidebar a.active { background: #334155; color: #fff; }
        .top-navbar { background: #ffffff; border-bottom: 1px solid #e2e8f0; }
        .avatar-lg { width: 100px; height: 100px; object-fit: cover; border-radius: 50%; border: 3px solid #ef4444; }
    </style>
</head>
<body>
<div class="d-flex">
    <div id="sidebar" class="d-flex flex-column p-2 shadow">
        <div class="text-center py-4">
            <img src="${pageContext.request.contextPath}/uploads/${sessionScope.account.avatar}" class="avatar-lg mb-2" alt="Avatar">
            <h6 class="mb-1 fw-bold text-white">${sessionScope.account.fullname}</h6>
            <span class="badge bg-danger px-3 py-1">Admin</span>
        </div>
        <hr class="border-secondary mx-3">
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-gauge me-2"></i>Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/category"><i class="fa fa-list me-2"></i>Quản lý Danh mục</a>
        <a href="${pageContext.request.contextPath}/admin/product"><i class="fa fa-layer-group me-2"></i>Quản lý Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/user"><i class="fa fa-users me-2"></i>Quản lý Tài khoản</a>
        <a href="${pageContext.request.contextPath}/account/profile" class="active"><i class="fa fa-user-gear me-2"></i>Thông tin cá nhân</a>
    </div>

    <div class="flex-grow-1">
        <div class="top-navbar d-flex justify-content-between align-items-center p-3 shadow-sm">
            <div class="d-flex align-items-center">
                <button id="toggleBtn" class="btn btn-light me-3 border"><i class="fa fa-bars fs-5"></i></button>
                <h4 class="m-0 fw-bold text-dark">Thông tin cá nhân Admin</h4>
            </div>
            <div>
                <span class="me-3 text-secondary">Xin chào, <strong class="text-dark">${sessionScope.account.fullname} (Admin)</strong></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm px-3"><i class="fa fa-right-from-bracket me-1"></i>Đăng xuất</a>
            </div>
        </div>

        <div class="p-4">
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fa fa-circle-check me-2"></i>${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white fw-bold py-3"><i class="fa fa-pen-to-square me-2"></i>Cập nhật thông tin cá nhân</div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/account/profile" method="post" enctype="multipart/form-data">
                        <div class="text-center mb-4">
                            <img src="${pageContext.request.contextPath}/uploads/${sessionScope.account.avatar}" class="avatar-lg mb-2" alt="Avatar">
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold text-secondary">Tên đăng nhập</label>
                                <input type="text" class="form-control bg-light" value="${sessionScope.account.username}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Họ và tên</label>
                                <input type="text" name="fullname" class="form-control" value="${sessionScope.account.fullname}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Số điện thoại</label>
                                <input type="text" name="phone" class="form-control" value="${sessionScope.account.phone}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Mật khẩu</label>
                                <input type="password" name="password" class="form-control" value="${sessionScope.account.password}" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-bold">Ảnh đại diện mới</label>
                                <input type="file" name="avatar" class="form-control" accept="image/*">
                            </div>
                            <div class="col-12 mt-4 text-end">
                                <button type="submit" class="btn btn-primary px-4 fw-bold"><i class="fa fa-floppy-disk me-1"></i>Lưu thay đổi</button>
                            </div>
                        </div>
                    </form>
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