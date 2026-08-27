package hcmute.vn.services;

import hcmute.vn.dao.IUserDao;
import hcmute.vn.dao.UserDao;
import hcmute.vn.entities.User;
import java.util.List;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDao();

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public User login(String username, String password) {
        return userDao.login(username, password);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void updateProfile(User user) {
        userDao.updateProfile(user);
    }

    @Override
    public void delete(int id) {
        userDao.delete(id);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }
}