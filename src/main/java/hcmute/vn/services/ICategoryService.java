package hcmute.vn.services;

import hcmute.vn.entities.Category;
import java.util.List;

public interface ICategoryService {
    List<Category> findAll();
    List<Category> searchByName(String keyword);
    Category findById(int id);
    void insert(Category category);
    void update(Category category);
    void delete(int id);
}