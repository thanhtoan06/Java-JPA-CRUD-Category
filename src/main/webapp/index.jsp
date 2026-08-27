<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hệ Thống Quản Lý - Trang Chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light min-vh-100 d-flex align-items-center justify-content-center py-5">

<div class="container" style="max-width: 550px;">
    <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
        
        <div class="card-header bg-primary text-white text-center py-4 border-0">
            <i class="fa fa-cubes fa-3x mb-2"></i>
            <h3 class="fw-bold mb-1">HỆ THỐNG QUẢN LÝ</h3>
            <p class="mb-0 text-white-50 fs-6">Chọn chức năng đăng nhập để trải nghiệm</p>
        </div>

        <div class="card-body p-4 p-md-5 bg-white">
            <div class="d-grid gap-3">
                
                <a href="${pageContext.request.contextPath}/login-cookie" 
                   class="btn btn-outline-primary btn-lg p-3 text-start d-flex align-items-center justify-content-between rounded-3 shadow-sm">
                    <div class="d-flex align-items-center">
                        <span class="bg-primary text-white p-3 rounded-circle me-3 d-inline-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                            <i class="fa fa-cookie-bite fs-5"></i>
                        </span>
                        <div>
                            <div class="fw-bold text-dark fs-6">1. Login với Cookie</div>
                            <small class="text-muted">Lưu phiên đăng nhập tự động qua Cookie</small>
                        </div>
                    </div>
                    <i class="fa fa-chevron-right text-muted fs-6"></i>
                </a>

                <a href="${pageContext.request.contextPath}/login-session" 
                   class="btn btn-outline-success btn-lg p-3 text-start d-flex align-items-center justify-content-between rounded-3 shadow-sm">
                    <div class="d-flex align-items-center">
                        <span class="bg-success text-white p-3 rounded-circle me-3 d-inline-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                            <i class="fa fa-key fs-5"></i>
                        </span>
                        <div>
                            <div class="fw-bold text-dark fs-6">2. Login với Session</div>
                            <small class="text-muted">Quản lý phiên làm việc bảo mật qua Session</small>
                        </div>
                    </div>
                    <i class="fa fa-chevron-right text-muted fs-6"></i>
                </a>

                <a href="${pageContext.request.contextPath}/login" 
                   class="btn btn-outline-danger btn-lg p-3 text-start d-flex align-items-center justify-content-between rounded-3 shadow-sm">
                    <div class="d-flex align-items-center">
                        <span class="bg-danger text-white p-3 rounded-circle me-3 d-inline-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                            <i class="fa fa-right-to-bracket fs-5"></i>
                        </span>
                        <div>
                            <div class="fw-bold text-dark fs-6">3. Login Category</div>
                            <small class="text-muted">Đăng nhập trang quản trị Admin / User</small>
                        </div>
                    </div>
                    <i class="fa fa-chevron-right text-muted fs-6"></i>
                </a>

            </div>
        </div>

        <div class="card-footer bg-light text-center py-3 border-0 text-muted fs-7">
        </div>

    </div>
</div>

</body>
</html>