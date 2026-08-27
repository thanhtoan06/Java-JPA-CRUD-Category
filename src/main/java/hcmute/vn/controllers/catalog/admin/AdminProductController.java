package hcmute.vn.controllers.catalog.admin;

import hcmute.vn.entities.Category;
import hcmute.vn.entities.Product;
import hcmute.vn.services.CategoryService;
import hcmute.vn.services.ProductService;
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
@WebServlet(urlPatterns = {"/admin/product", "/admin/product/add", "/admin/product/edit", "/admin/product/delete"})
public class AdminProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductService();
    private CategoryService cateService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.equals("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            productService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/product");
        } else if (path.equals("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product prod = productService.findById(id);
            List<Category> cateList = cateService.findAll();
            req.setAttribute("product", prod);
            req.setAttribute("cateList", cateList);
            req.getRequestDispatcher("/views/catalog/admin/product-edit.jsp").forward(req, resp);
        } else {
            String keyword = req.getParameter("keyword");
            String cateIdStr = req.getParameter("cateId");
            int cateId = (cateIdStr != null && !cateIdStr.isEmpty()) ? Integer.parseInt(cateIdStr) : 0;
            List<Product> list = productService.search(keyword, cateId);
            List<Category> cateList = cateService.findAll();
            req.setAttribute("productList", list);
            req.setAttribute("cateList", cateList);
            req.setAttribute("keyword", keyword);
            req.setAttribute("selectedCateId", cateId);
            req.getRequestDispatcher("/views/catalog/admin/product-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if (path.equals("/admin/product/add")) {
            String productName = req.getParameter("productName");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int cateId = Integer.parseInt(req.getParameter("cateId"));
            Part filePart = req.getPart("image");

            String imageName = saveUploadedFile(filePart, req);
            if (imageName == null) imageName = "headphone.png";

            Product prod = new Product(0, productName, price, description, imageName, cateId);
            productService.insert(prod);
            resp.sendRedirect(req.getContextPath() + "/admin/product");

        } else if (path.equals("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            String productName = req.getParameter("productName");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int cateId = Integer.parseInt(req.getParameter("cateId"));
            Part filePart = req.getPart("image");

            Product oldProd = productService.findById(id);
            String imageName = saveUploadedFile(filePart, req);
            if (imageName == null) imageName = oldProd.getImage();

            Product prod = new Product(id, productName, price, description, imageName, cateId);
            productService.update(prod);
            resp.sendRedirect(req.getContextPath() + "/admin/product");
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