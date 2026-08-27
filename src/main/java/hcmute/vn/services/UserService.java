package hcmute.vn.services;

import hcmute.vn.entities.User;
import hcmute.vn.repositories.UserRepository;
import java.util.List;

public class UserService {
    private UserRepository userRepo = new UserRepository();

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public User login(String username, String password) {
        return userRepo.login(username, password);
    }

    public boolean checkExistUsername(String username) {
        return userRepo.checkExistUsername(username);
    }

    public boolean checkExistEmail(String email) {
        return userRepo.checkExistEmail(email);
    }

    public void insert(User user) {
        userRepo.insert(user);
    }

    public void update(User user) {
        userRepo.update(user);
    }

    public void updateProfile(User user) {
        userRepo.updateProfile(user);
    }

    public void delete(int id) {
        userRepo.delete(id);
    }

    public User findById(int id) {
        return userRepo.findById(id);
    }
}