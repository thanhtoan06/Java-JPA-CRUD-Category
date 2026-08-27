package hcmute.vn.controllers.catalog.common;

import hcmute.vn.entities.User;
import hcmute.vn.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("username".equals(c.getName())) req.setAttribute("username", c.getValue());
                if ("password".equals(c.getName())) req.setAttribute("password", c.getValue());
            }
        }
        req.getRequestDispatcher("/views/catalog/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String u = req.getParameter("username");
        String p = req.getParameter("password");
        String remember = req.getParameter("remember");

        User user = userService.login(u, p);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            if (remember != null) {
                Cookie cUser = new Cookie("username", u);
                Cookie cPass = new Cookie("password", p);
                cUser.setMaxAge(60 * 60 * 24 * 7);
                cPass.setMaxAge(60 * 60 * 24 * 7);
                resp.addCookie(cUser);
                resp.addCookie(cPass);
            } else {
                Cookie cUser = new Cookie("username", "");
                Cookie cPass = new Cookie("password", "");
                cUser.setMaxAge(0);
                cPass.setMaxAge(0);
                resp.addCookie(cUser);
                resp.addCookie(cPass);
            }

            if (user.getRoleid() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/home");
            }
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            req.getRequestDispatcher("/views/catalog/login.jsp").forward(req, resp);
        }
    }
}