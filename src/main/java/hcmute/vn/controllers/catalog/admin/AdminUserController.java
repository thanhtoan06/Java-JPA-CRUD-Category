package hcmute.vn.controllers.catalog.admin;

import hcmute.vn.entities.User;
import hcmute.vn.services.IUserService;
import hcmute.vn.services.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(urlPatterns = {"/admin/user", "/admin/user/add", "/admin/user/edit", "/admin/user/delete"})
public class AdminUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.equals("/admin/user/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            userService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/user");
        } else if (path.equals("/admin/user/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            User user = userService.findById(id);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/catalog/admin/user-edit.jsp").forward(req, resp);
        } else {
            List<User> list = userService.findAll();
            req.setAttribute("userList", list);
            req.getRequestDispatcher("/views/catalog/admin/user-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if (path.equals("/admin/user/add")) {
            String username = req.getParameter("username");
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            int roleId = Integer.parseInt(req.getParameter("roleId"));
            Part filePart = req.getPart("avatar");

            String avatarName = saveUploadedFile(filePart, req);
            if (avatarName == null) avatarName = "default-avatar.png";

            User user = new User();
            user.setUsername(username);
            user.setFullname(fullname);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(password);
            user.setAvatar(avatarName);
            user.setRoleid(roleId);

            userService.insert(user);
            resp.sendRedirect(req.getContextPath() + "/admin/user");

        } else if (path.equals("/admin/user/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            String username = req.getParameter("username");
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            int roleId = Integer.parseInt(req.getParameter("roleId"));

            User oldUser = userService.findById(id);
            Part filePart = req.getPart("avatar");

            String avatarName = saveUploadedFile(filePart, req);
            if (avatarName == null) avatarName = oldUser.getAvatar();

            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setFullname(fullname);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword((password != null && !password.trim().isEmpty()) ? password : oldUser.getPassword());
            user.setAvatar(avatarName);
            user.setRoleid(roleId);

            userService.update(user);

            HttpSession session = req.getSession();
            User currentAcc = (User) session.getAttribute("account");
            if (currentAcc != null && currentAcc.getId() == user.getId()) {
                session.setAttribute("account", user);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/user");
        }
    }

    private String saveUploadedFile(Part filePart, HttpServletRequest req) throws IOException {
        if (filePart == null || filePart.getSize() <= 0) return null;

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
        return fileName;
    }
}