package hcmute.vn.controllers.democookiesession.cookie;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = { "/logout-cookie" })
public class CookieLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie c1 = new Cookie("username", "");
        c1.setMaxAge(0);
        c1.setPath("/");
        resp.addCookie(c1);

        if (req.getContextPath() != null && !req.getContextPath().isEmpty()) {
            Cookie c2 = new Cookie("username", "");
            c2.setMaxAge(0);
            c2.setPath(req.getContextPath());
            resp.addCookie(c2);
        }

        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        resp.sendRedirect(req.getContextPath() + "/login-cookie");
    }
}