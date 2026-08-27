<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Tài Khoản</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
    body { background-color: #f1f5f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    #sidebar { min-width: 260px; max-width: 260px; background: #1e293b; color: #fff; transition: all 0.3s; min-height: 100vh; }
    #sidebar.collapsed { margin-left: -260px; }
    #sidebar a { color: #cbd5e1; text-decoration: none; padding: 12px 20px; display: block; border-radius: 8px; margin: 4px 12px; }
    #sidebar a:hover, #sidebar a.active { background: #334155; color: #fff; }
    .top-navbar { background: #ffffff; border-bottom: 1px solid #e2e8f0; }
    .profile-card { max-width: 550px; margin: 0 auto; background: #fff; border-radius: 12px; padding: 30px; border: none; }
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
        <a href="${pageContext.request.contextPath}/user/home"><i class="fa fa-border-all me-2"></i>Xem sản phẩm</a>
        <a href="${pageContext.request.contextPath}/account/profile" class="active"><i class="fa fa-user-gear me-2"></i>Quản lý tài khoản</a>
    </div>

    <div class="flex-grow-1">
        <div class="top-navbar d-flex justify-content-between align-items-center p-3 shadow-sm">
            <div class="d-flex align-items-center">
                <button id="toggleBtn" class="btn btn-light me-3 border"><i class="fa fa-bars fs-5"></i></button>
                <h4 class="m-0 fw-bold text-dark">Thông tin cá nhân</h4>
            </div>
            <div>
                <span class="me-3 text-secondary">Xin chào, <strong class="text-dark">${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm px-3"><i class="fa fa-right-from-bracket me-1"></i>Đăng xuất</a>
            </div>
        </div>

        <div class="p-4">
            <div class="profile-card shadow-sm">
                <c:if test="${not empty message}">
                    <div class="alert alert-success py-2">${message}</div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/account/profile" method="post" enctype="multipart/form-data">
                    <div class="text-center mb-4">
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
                        <div class="mt-3 text-start">
                            <label class="form-label fw-bold text-dark small">Chọn ảnh đại diện mới:</label>
                            <input type="file" name="avatar" class="form-control" accept="image/*">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold text-secondary">Tên đăng nhập</label>
                        <input type="text" class="form-control bg-light" value="${sessionScope.account.username}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Họ và tên</label>
                        <input type="text" name="fullname" class="form-control" value="${sessionScope.account.fullname}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Số điện thoại</label>
                        <input type="text" name="phone" class="form-control" value="${sessionScope.account.phone}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Mật khẩu</label>
                        <input type="password" name="password" class="form-control" value="${sessionScope.account.password}" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold mt-2">Cập nhật thông tin</button>
                </form>
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