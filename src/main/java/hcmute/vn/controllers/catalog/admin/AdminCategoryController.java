package hcmute.vn.controllers.catalog.admin;

import hcmute.vn.entities.Category;
import hcmute.vn.services.CategoryServiceImpl;
import hcmute.vn.services.ICategoryService;
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
@WebServlet(urlPatterns = {"/admin/category", "/admin/category/add", "/admin/category/edit", "/admin/category/delete"})
public class AdminCategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.equals("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            cateService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } else if (path.equals("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category cate = cateService.findById(id);
            req.setAttribute("category", cate);
            req.getRequestDispatcher("/views/catalog/admin/category-edit.jsp").forward(req, resp);
        } else {
            String keyword = req.getParameter("keyword");
            List<Category> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = cateService.searchByName(keyword.trim());
                req.setAttribute("keyword", keyword);
            } else {
                list = cateService.findAll();
            }
            req.setAttribute("cateList", list);
            req.getRequestDispatcher("/views/catalog/admin/category-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if (path.equals("/admin/category/add")) {
            String cateName = req.getParameter("cateName");
            Part filePart = req.getPart("icon");
            
            String iconName = saveUploadedFile(filePart, req);
            if (iconName == null) iconName = "headphone.png";

            Category cate = new Category(0, cateName, iconName);
            cateService.insert(cate);
            resp.sendRedirect(req.getContextPath() + "/admin/category");

        } else if (path.equals("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("cateId"));
            String cateName = req.getParameter("cateName");
            Part filePart = req.getPart("icon");

            Category oldCate = cateService.findById(id);
            String iconName = saveUploadedFile(filePart, req);
            if (iconName == null) iconName = oldCate.getIcons();

            Category cate = new Category(id, cateName, iconName);
            cateService.update(cate);
            resp.sendRedirect(req.getContextPath() + "/admin/category");
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