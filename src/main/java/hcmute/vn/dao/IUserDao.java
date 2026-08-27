package hcmute.vn.dao;

import hcmute.vn.entities.User;
import java.util.List;

public interface IUserDao {
    List<User> findAll();
    User login(String username, String password);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    void insert(User user);
    void update(User user);
    void updateProfile(User user);
    void delete(int id);
    User findById(int id);
}