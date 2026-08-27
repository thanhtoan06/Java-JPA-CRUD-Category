<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile Cookie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script>
        var expireTime = localStorage.getItem('cookie_expire_time');
        var now = Date.now();

        if (!expireTime || now >= parseInt(expireTime)) {
            expireTime = now + (300 * 1000);
            localStorage.setItem('cookie_expire_time', expireTime);
        }

        function clearCookieAndStorage() {
            localStorage.removeItem('cookie_expire_time');
            document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=${pageContext.request.contextPath};";
        }

        function updateCountdown() {
            var currentTime = Date.now();
            var timeLeft = Math.ceil((parseInt(expireTime) - currentTime) / 1000);

            if (timeLeft <= 0) {
                clearCookieAndStorage();
                window.location.href = '${pageContext.request.contextPath}/login-cookie';
            } else {
                var el = document.getElementById('countdown');
                if (el) el.innerText = timeLeft;
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            updateCountdown();
            setInterval(updateCountdown, 1000);
        });
    </script>
</head>
<body class="bg-light py-5">
<div class="container" style="max-width: 650px;">
    <div class="card border-0 shadow-lg rounded-4 overflow-hidden mb-4">
        <div class="card-header bg-warning text-dark text-center py-4 border-0">
            <i class="fa fa-user-circle fa-4x mb-2"></i>
            <h3 class="fw-bold mb-1">Xin chào, ${username}!</h3>
            <p class="mb-0 text-dark-50">Đăng nhập thành công qua Cookie</p>
        </div>
        <div class="card-body p-4 bg-white text-center">
            <div class="alert alert-warning border-0 shadow-sm d-inline-block px-4 py-3 mb-3 rounded-3">
                <i class="fa fa-clock me-2"></i>Cookie sẽ hết hạn sau: <span id="countdown" class="badge bg-danger fs-5 mx-1">--</span> giây nữa.
            </div>
            <p class="text-muted small">Hệ thống sẽ tự động chuyển về trang Đăng Nhập khi hết thời gian.</p>
            <a href="${pageContext.request.contextPath}/logout-cookie" onclick="clearCookieAndStorage()" class="btn btn-outline-danger px-4 rounded-pill">
                <i class="fa fa-right-from-bracket me-1"></i> Đăng Xuất
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
        <div class="card-header bg-dark text-white fw-bold py-3">
            <i class="fa fa-cookie me-2"></i> Danh sách Cookie hiện tại
        </div>
        <div class="card-body p-0">
            <ul class="list-group list-group-flush">
            <%
                Cookie[] cookies = (Cookie[]) request.getAttribute("cookiesList");
                if (cookies != null && cookies.length > 0) {
                    for (Cookie c : cookies) {
            %>
                        <li class="list-group-item d-flex justify-content-between align-items-center py-3 px-4">
                            <span class="fw-bold text-primary"><i class="fa fa-key me-2 text-muted"></i><%= c.getName() %></span>
                            <span class="badge bg-secondary rounded-pill fs-6"><%= c.getValue() %></span>
                        </li>
            <%
                    }
                } else {
            %>
                    <li class="list-group-item text-center text-muted py-3">Không tìm thấy Cookie nào</li>
            <%
                }
            %>
            </ul>
        </div>
    </div>
</div>
</body>
</html>