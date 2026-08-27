package hcmute.vn.services;

import hcmute.vn.dao.CategoryDao;
import hcmute.vn.dao.ICategoryDao;
import hcmute.vn.entities.Category;
import java.util.List;

public class CategoryServiceImpl implements ICategoryService {

    private ICategoryDao cateDao = new CategoryDao();

    @Override
    public List<Category> findAll() {
        return cateDao.findAll();
    }

    @Override
    public List<Category> searchByName(String keyword) {
        return cateDao.searchByName(keyword);
    }

    @Override
    public Category findById(int id) {
        return cateDao.findById(id);
    }

    @Override
    public void insert(Category category) {
        cateDao.insert(category);
    }

    @Override
    public void update(Category category) {
        cateDao.update(category);
    }

    @Override
    public void delete(int id) {
        cateDao.delete(id);
    }
}