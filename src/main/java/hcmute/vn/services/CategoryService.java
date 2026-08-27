package hcmute.vn.services;

import hcmute.vn.entities.Category;
import hcmute.vn.repositories.CategoryRepository;
import java.util.List;

public class CategoryService {
    private CategoryRepository cateRepo = new CategoryRepository();

    public List<Category> findAll() {
        return cateRepo.findAll();
    }

    public List<Category> searchByName(String keyword) {
        return cateRepo.searchByName(keyword);
    }

    public Category findById(int id) {
        return cateRepo.findById(id);
    }

    public void insert(Category category) {
        cateRepo.insert(category);
    }

    public void update(Category category) {
        cateRepo.update(category);
    }

    public void delete(int id) {
        cateRepo.delete(id);
    }
}