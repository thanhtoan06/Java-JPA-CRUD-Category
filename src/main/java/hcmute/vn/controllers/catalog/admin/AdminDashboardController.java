package hcmute.vn.controllers.catalog.admin;

import hcmute.vn.services.CategoryServiceImpl;
import hcmute.vn.services.ICategoryService;
import hcmute.vn.services.IProductService;
import hcmute.vn.services.IUserService;
import hcmute.vn.services.ProductServiceImpl;
import hcmute.vn.services.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/dashboard"})
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ICategoryService cateService = new CategoryServiceImpl();
    private IProductService productService = new ProductServiceImpl();
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int countCategories = cateService.findAll().size();
        int countProducts = productService.findAll().size();
        int countUsers = userService.findAll().size();

        req.setAttribute("countCategories", countCategories);
        req.setAttribute("countProducts", countProducts);
        req.setAttribute("countUsers", countUsers);

        req.getRequestDispatcher("/views/catalog/admin/dashboard.jsp").forward(req, resp);
    }
}