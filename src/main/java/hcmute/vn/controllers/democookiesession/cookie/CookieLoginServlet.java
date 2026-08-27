package hcmute.vn.controllers.democookiesession.cookie;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/login-cookie" })
public class CookieLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("username".equals(c.getName()) && c.getValue() != null && !c.getValue().trim().isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/profile-cookie");
                    return;
                }
            }
        }
        req.getRequestDispatcher("/views/democookiesession/login-cookie.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        if ("admin".equals(user) && "123".equals(pass)) {
            Cookie cookie = new Cookie("username", user);
            cookie.setMaxAge(300);
            cookie.setPath("/");
            resp.addCookie(cookie);

            resp.sendRedirect(req.getContextPath() + "/profile-cookie");
        } else {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không đúng!");
            req.getRequestDispatcher("/views/democookiesession/login-cookie.jsp").forward(req, resp);
        }
    }
}