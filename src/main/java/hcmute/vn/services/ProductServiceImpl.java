package hcmute.vn.services;

import hcmute.vn.dao.IProductDao;
import hcmute.vn.dao.ProductDao;
import hcmute.vn.entities.Product;
import java.util.List;

public class ProductServiceImpl implements IProductService {

    private IProductDao productDao = new ProductDao();

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> search(String keyword, int cateId) {
        return productDao.search(keyword, cateId);
    }

    @Override
    public List<Product> searchByName(String keyword) {
        return productDao.searchByName(keyword);
    }

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }
}