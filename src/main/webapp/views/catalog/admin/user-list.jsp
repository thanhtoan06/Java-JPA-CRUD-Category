<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Tài khoản</title>
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
    
    .user-img-md { 
        width: 70px; 
        height: 70px; 
        border-radius: 50%; 
        object-fit: cover; 
        border: 2px solid #cbd5e1;
        box-shadow: 0 3px 6px rgba(0,0,0,0.08);
    }
    .table-medium td, .table-medium th { 
        padding: 0.9rem 0.75rem !important; 
        vertical-align: middle; 
    }
</style>
</head>
<body>
<div class="d-flex">
    <div id="sidebar" class="d-flex flex-column p-2 shadow">
        <div class="text-center py-4">
            <c:choose>
                <c:when test="${not empty sessionScope.account.avatar}">
                    <img src="${pageContext.request.contextPath}/uploads/${sessionScope.account.avatar}" class="avatar-lg mb-2" alt="Avatar">
                </c:when>
                <c:otherwise>
                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="avatar-lg mb-2" alt="Default Avatar">
                </c:otherwise>
            </c:choose>
            <h6 class="mb-1 fw-bold text-white">${sessionScope.account.fullname}</h6>
            <span class="badge bg-danger px-3 py-1">Admin</span>
        </div>
        <hr class="border-secondary mx-3">
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-gauge me-2"></i>Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/category"><i class="fa fa-list me-2"></i>Quản lý Danh mục</a>
        <a href="${pageContext.request.contextPath}/admin/product"><i class="fa fa-layer-group me-2"></i>Quản lý Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/user" class="active"><i class="fa fa-users me-2"></i>Quản lý Tài khoản</a>
    </div>

    <div class="flex-grow-1">
        <div class="top-navbar d-flex justify-content-between align-items-center p-3 shadow-sm">
            <div class="d-flex align-items-center">
                <button id="toggleBtn" class="btn btn-light me-3 border"><i class="fa fa-bars fs-5"></i></button>
                <h4 class="m-0 fw-bold text-dark me-3">Quản lý Tài khoản</h4>
            </div>
            <div>
                <span class="me-3 text-secondary">Xin chào, <strong class="text-dark">${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm px-3 rounded-pill"><i class="fa fa-right-from-bracket me-1"></i>Đăng xuất</a>
            </div>
        </div>

        <div class="p-4">
            <div class="card border-0 shadow-sm rounded-4 mb-4">
                <div class="card-header bg-white fw-bold py-3 fs-6"><i class="fa fa-user-plus me-1 text-success"></i>Thêm tài khoản mới</div>
                <div class="card-body p-3">
                    <form action="${pageContext.request.contextPath}/admin/user/add" method="post" enctype="multipart/form-data" class="row g-3">
                        <div class="col-md-3">
                            <input type="text" name="username" class="form-control" placeholder="Tên đăng nhập..." required>
                        </div>
                        <div class="col-md-3">
                            <input type="password" name="password" class="form-control" placeholder="Mật khẩu..." required>
                        </div>
                        <div class="col-md-3">
                            <input type="text" name="fullname" class="form-control" placeholder="Họ và tên..." required>
                        </div>
                        <div class="col-md-3">
                            <input type="email" name="email" class="form-control" placeholder="Email...">
                        </div>
                        <div class="col-md-3">
                            <input type="text" name="phone" class="form-control" placeholder="Số điện thoại...">
                        </div>
                        <div class="col-md-3">
                            <select name="roleId" class="form-select" required>
                                <option value="1">Admin</option>
                                <option value="2" selected>User</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <input type="file" name="avatar" class="form-control">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-success w-100 fw-bold"><i class="fa fa-plus me-1"></i>Thêm mới</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="card-header bg-white fw-bold py-3 fs-5">Danh sách tài khoản hệ thống</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0 table-medium">
                            <thead class="table-light">
                                <tr class="fs-6 text-uppercase text-secondary">
                                    <th style="width: 70px;" class="ps-4">STT</th>
                                    <th style="width: 100px;">Avatar</th>
                                    <th>Username</th>
                                    <th>Họ tên</th>
                                    <th>Email</th>
                                    <th>Số điện thoại</th>
                                    <th>Quyền</th>
                                    <th style="width: 180px;" class="text-center">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${userList}" var="u" varStatus="loop">
                                    <tr>
                                        <td class="ps-4 fs-5 fw-bold text-muted">${loop.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty u.avatar}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${u.avatar}" class="user-img-md" alt="Avatar">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="user-img-md" alt="Default Avatar">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="fs-5 fw-bold text-dark">${u.username}</td>
                                        <td class="fs-6 fw-semibold">${u.fullname}</td>
                                        <td class="fs-6 text-muted">${u.email}</td>
                                        <td class="fs-6 text-muted">${u.phone}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.roleid == 1}"><span class="badge bg-danger fs-6 px-3 py-2 rounded-pill">Admin</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary fs-6 px-3 py-2 rounded-pill">User</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/admin/user/edit?id=${u.id}" class="btn btn-outline-primary px-3 py-1.5 fw-semibold fs-6 me-1"><i class="fa fa-pen me-1"></i>Sửa</a>
                                            <a href="${pageContext.request.contextPath}/admin/user/delete?id=${u.id}" class="btn btn-outline-danger px-3 py-1.5 fw-semibold fs-6" onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?')"><i class="fa fa-trash me-1"></i>Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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