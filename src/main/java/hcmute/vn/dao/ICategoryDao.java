package hcmute.vn.dao;

import hcmute.vn.entities.Category;
import java.util.List;

public interface ICategoryDao {
    List<Category> findAll();
    List<Category> searchByName(String keyword);
    Category findById(int id);
    void insert(Category category);
    void update(Category category);
    void delete(int id);
}