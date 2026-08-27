package hcmute.vn.controllers.catalog.user;

import hcmute.vn.entities.Category;
import hcmute.vn.entities.Product;
import hcmute.vn.services.CategoryServiceImpl;
import hcmute.vn.services.ICategoryService;
import hcmute.vn.services.IProductService;
import hcmute.vn.services.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/home")
public class UserHomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String keyword = req.getParameter("keyword");
        List<Product> productList;

        if (keyword != null && !keyword.trim().isEmpty()) {
            productList = productService.searchByName(keyword.trim());
            req.setAttribute("keyword", keyword);
        } else {
            productList = productService.findAll();
        }

        List<Category> cateList = cateService.findAll();
        
        req.setAttribute("productList", productList);
        req.setAttribute("cateList", cateList);
        req.getRequestDispatcher("/views/catalog/user/home.jsp").forward(req, resp);
    }
}