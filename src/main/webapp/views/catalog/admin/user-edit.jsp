<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
    <div class="container" style="max-width: 650px;">
        <div class="card border-0 shadow-sm rounded-3">
            <div class="card-header bg-danger text-white fw-bold py-3">
                <i class="fa fa-user-pen me-2"></i>Chỉnh sửa Thông tin Tài khoản
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/user/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${user.id}">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Username</label>
                            <input type="text" name="username" class="form-control" value="${user.username}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control" value="${user.fullname}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Email</label>
                            <input type="email" name="email" class="form-control" value="${user.email}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" value="${user.phone}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Mật khẩu mới</label>
                            <input type="password" name="password" class="form-control" placeholder="Để trống nếu giữ nguyên">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Phân quyền</label>
                            <select name="roleId" class="form-select">
                                <option value="1" ${user.roleid == 1 ? 'selected' : ''}>Admin</option>
                                <option value="2" ${user.roleid != 1 ? 'selected' : ''}>User</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Avatar</label>
                            <div class="d-flex align-items-center gap-3">
                                <img src="${pageContext.request.contextPath}/uploads/${user.avatar}" class="rounded-circle border" style="width: 60px; height: 60px; object-fit: cover;">
                                <input type="file" name="avatar" class="form-control">
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between pt-4">
                        <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-secondary"><i class="fa fa-arrow-left me-1"></i>Hủy</a>
                        <button type="submit" class="btn btn-success px-4"><i class="fa fa-save me-1"></i>Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>