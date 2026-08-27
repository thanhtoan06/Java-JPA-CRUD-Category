<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
    <div class="container" style="max-width: 650px;">
        <div class="card border-0 shadow-sm rounded-3">
            <div class="card-header bg-primary text-white py-3 fw-bold">
                <i class="fa fa-pen me-2"></i>Chỉnh sửa sản phẩm
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${product.id}">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Tên sản phẩm:</label>
                        <input type="text" name="productName" class="form-control" value="${product.productName}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Giá bán (VNĐ):</label>
                        <input type="number" step="0.01" name="price" class="form-control" value="${product.price}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Danh mục:</label>
                        <select name="cateId" class="form-select">
                            <c:forEach items="${cateList}" var="c">
                                <option value="${c.cateId}" ${c.cateId == product.cateId ? 'selected' : ''}>${c.cateName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Mô tả:</label>
                        <textarea name="description" class="form-control" rows="3">${product.description}</textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Ảnh hiện tại:</label><br>
                        <img src="${pageContext.request.contextPath}/uploads/${product.image}" class="img-thumbnail mb-2" style="width: 100px; height: 100px; object-fit: cover;" onerror="this.onerror=null; this.src='https://via.placeholder.com/100?text=No+Img';">
                        <br>
                        <label class="form-label fw-bold text-muted small">Tải ảnh mới (để trống nếu không đổi):</label>
                        <input type="file" name="image" class="form-control">
                    </div>

                    <div class="d-flex justify-content-between pt-3">
                        <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-secondary px-4"><i class="fa fa-arrow-left me-1"></i>Hủy</a>
                        <button type="submit" class="btn btn-success px-4"><i class="fa fa-save me-1"></i>Lưu lại</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>