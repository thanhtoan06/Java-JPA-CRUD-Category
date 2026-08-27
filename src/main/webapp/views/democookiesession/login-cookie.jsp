<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Cookie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light min-vh-100 d-flex align-items-center justify-content-center py-5">
<div class="container" style="max-width: 450px;">
    <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
        <div class="card-header bg-warning text-dark text-center py-4 border-0">
            <i class="fa fa-cookie-bite fa-3x mb-2"></i>
            <h4 class="fw-bold mb-0">ĐĂNG NHẬP COOKIE</h4>
        </div>
        <div class="card-body p-4 bg-white">
            <c:if test="${not empty alert}">
                <div class="alert alert-danger py-2 fs-6 mb-3">${alert}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/login-cookie" method="post">
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="fa fa-user text-muted"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Nhập: admin" required>
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="fa fa-lock text-muted"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Nhập: 123" required>
                </div>
                <button type="submit" class="btn btn-warning text-dark w-100 py-2 fs-6 fw-bold">Đăng Nhập</button>
            </form>
            <div class="text-center mt-4 border-top pt-3">
                <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none fs-6">
                    <i class="fa fa-arrow-left me-1"></i> Quay về Trang Chủ
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>