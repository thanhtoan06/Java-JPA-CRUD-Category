<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f1f5f9; }
        .card { border-radius: 12px; }
    </style>
</head>
<body class="p-4">
    <div class="container" style="max-width: 600px;">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-primary text-white fw-bold py-3">
                <i class="fa fa-pen me-2"></i>Chỉnh sửa Danh mục
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="cateId" value="${category.cateId}">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Tên danh mục</label>
                        <input type="text" name="cateName" class="form-control" value="${category.cateName}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Icon/Hình ảnh hiện tại</label>
                        <div class="mb-2">
                            <img src="${pageContext.request.contextPath}/uploads/${category.icons}" style="width: 70px; height: 70px; object-fit: contain;" class="border rounded p-1">
                        </div>
                        <label class="form-label text-muted small">Tải lên icon mới (để trống nếu giữ nguyên)</label>
                        <input type="file" name="icon" class="form-control">
                    </div>

                    <div class="d-flex justify-content-between pt-3">
                        <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-secondary px-4"><i class="fa fa-arrow-left me-1"></i>Quay lại</a>
                        <button type="submit" class="btn btn-success px-4"><i class="fa fa-save me-1"></i>Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>