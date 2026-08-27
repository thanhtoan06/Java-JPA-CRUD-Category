<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Ký Tài Khoản User</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { background-color: #f8f9fa; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
    .register-card { width: 100%; max-width: 500px; background: #fff; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; }
</style>
</head>
<body>
<div class="register-card shadow-sm">
    <h3 class="text-center text-primary mb-4">Đăng Ký Tài Khoản User</h3>
    <c:if test="${not empty error}">
        <div class="alert alert-danger py-2">${error}</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="mb-3">
            <label class="form-label fw-bold">Tên đăng nhập:</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-bold">Email:</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-bold">Họ và tên:</label>
            <input type="text" name="fullname" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-bold">Số điện thoại:</label>
            <input type="text" name="phone" class="form-control">
        </div>
        <div class="mb-3">
            <label class="form-label fw-bold">Mật khẩu:</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-success w-100 py-2 fs-5">Đăng ký ngay</button>
    </form>
    <div class="text-center mt-3">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-primary text-decoration-none fw-bold">Đăng nhập</a>
    </div>
</div>
</body>
</html>