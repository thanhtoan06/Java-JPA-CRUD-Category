package hcmute.vn.controllers.democookiesession.cookie;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/profile-cookie" })
public class ProfileCookieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = "";

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("username".equals(c.getName())) {
                    name = c.getValue();
                }
            }
        }

        if (name == null || name.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/login-cookie");
            return;
        }

        req.setAttribute("username", name);
        req.setAttribute("cookiesList", cookies);

        req.getRequestDispatcher("/views/democookiesession/profile-cookie.jsp").forward(req, resp);
    }
}