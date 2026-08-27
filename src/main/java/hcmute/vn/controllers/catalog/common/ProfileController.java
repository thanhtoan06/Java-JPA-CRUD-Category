package hcmute.vn.controllers.catalog.common;

import hcmute.vn.entities.User;
import hcmute.vn.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
@WebServlet("/account/profile")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User account = (User) session.getAttribute("account");
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String message = (String) session.getAttribute("message");
        if (message != null) {
            req.setAttribute("message", message);
            session.removeAttribute("message");
        }

        if (account.getRoleid() == 1) {
            req.getRequestDispatcher("/views/catalog/admin/profile.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/catalog/user/profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User account = (User) session.getAttribute("account");

        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        Part filePart = req.getPart("avatar");

        String avatarName = account.getAvatar();

        if (filePart != null && filePart.getSize() > 0) {
            String rawFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileName = System.currentTimeMillis() + "_" + rawFileName;

            String contextRealPath = req.getServletContext().getRealPath("");
            String uploadPath = req.getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File serverFile = new File(uploadDir, fileName);
            filePart.write(serverFile.getAbsolutePath());

            try {
                if (contextRealPath != null && contextRealPath.contains(".metadata")) {
                    File deployedFolder = new File(contextRealPath);
                    String projectName = deployedFolder.getName();
                    String workspacePath = contextRealPath.substring(0, contextRealPath.indexOf(".metadata"));

                    String projectSourcePath = workspacePath + projectName + File.separator 
                                             + "src" + File.separator + "main" + File.separator 
                                             + "webapp" + File.separator + "uploads";

                    File srcDir = new File(projectSourcePath);
                    if (!srcDir.exists()) srcDir.mkdirs();

                    File srcFile = new File(srcDir, fileName);
                    Files.copy(serverFile.toPath(), srcFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            avatarName = fileName;
        }

        account.setFullname(fullname);
        account.setPhone(phone);
        account.setPassword(password);
        account.setAvatar(avatarName);

        userService.updateProfile(account);
        session.setAttribute("account", account);
        session.setAttribute("message", "Cập nhật thông tin thành công!");

        resp.sendRedirect(req.getContextPath() + "/account/profile");
    }
}