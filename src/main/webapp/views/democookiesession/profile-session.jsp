<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile Session</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light py-5">
<div class="container" style="max-width: 650px;">
<%
    String name = (String) session.getAttribute("name");
    if (name != null) {
%>
    <div class="card border-0 shadow-lg rounded-4 overflow-hidden mb-4">
        <div class="card-header bg-success text-white text-center py-4 border-0">
            <i class="fa fa-user-check fa-4x mb-2"></i>
            <h3 class="fw-bold mb-1">Chào bạn, <%= name %>!</h3>
            <p class="mb-0 text-white-50">Đã đăng nhập Session thành công</p>
        </div>
        <div class="card-body p-4 bg-white text-center">
            <a href="${pageContext.request.contextPath}/logout-session" class="btn btn-outline-danger px-4 rounded-pill">
                <i class="fa fa-right-from-bracket me-1"></i> Đăng Xuất
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
        <div class="card-header bg-dark text-white fw-bold py-3">
            <i class="fa fa-database me-2"></i> Thông tin Session hiện tại
        </div>
        <div class="card-body p-4 bg-white">
            <div class="mb-3 p-3 bg-light rounded-3 border">
                <div class="mb-2"><strong>Session ID:</strong> <span class="badge bg-secondary fs-6"><%= session.getId() %></span></div>
                <div><strong>Thời gian khởi tạo:</strong> <span class="text-muted"><%= new java.util.Date(session.getCreationTime()) %></span></div>
            </div>

            <h6 class="fw-bold text-secondary mb-3"><i class="fa fa-list me-1"></i> Danh sách dữ liệu (Attributes) đang lưu:</h6>
            <ul class="list-group">
            <%
                Enumeration<String> attributeNames = session.getAttributeNames();
                while (attributeNames.hasMoreElements()) {
                    String key = attributeNames.nextElement();
                    Object value = session.getAttribute(key);
            %>
                    <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                        <span class="fw-bold text-success"><%= key %></span>
                        <span class="badge bg-primary rounded-pill fs-6"><%= value %></span>
                    </li>
            <%
                }
            %>
            </ul>
        </div>
    </div>
<%
    } else {
%>
    <div class="card border-0 shadow-lg rounded-4 overflow-hidden text-center p-5">
        <i class="fa fa-triangle-exclamation text-warning fa-4x mb-3"></i>
        <h3 class="fw-bold text-danger mb-3">Chưa đăng nhập!</h3>
        <div>
            <a href="${pageContext.request.contextPath}/login-session" class="btn btn-primary px-4 rounded-pill">
                <i class="fa fa-right-to-bracket me-1"></i> Đến trang Login
            </a>
        </div>
    </div>
<%
    }
%>
</div>
</body>
</html>