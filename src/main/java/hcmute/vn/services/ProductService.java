package hcmute.vn.services;

import hcmute.vn.entities.Product;
import hcmute.vn.repositories.ProductRepository;
import java.util.List;

public class ProductService {
    private ProductRepository productRepo = new ProductRepository();

    public List<Product> findAll() {
        return productRepo.findAll();
    }

    public List<Product> search(String keyword, int cateId) {
        return productRepo.search(keyword, cateId);
    }

    public List<Product> searchByName(String keyword) {
        return productRepo.searchByName(keyword);
    }

    public Product findById(int id) {
        return productRepo.findById(id);
    }

    public void insert(Product product) {
        productRepo.insert(product);
    }

    public void update(Product product) {
        productRepo.update(product);
    }

    public void delete(int id) {
        productRepo.delete(id);
    }
}