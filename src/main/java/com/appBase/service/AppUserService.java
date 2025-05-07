package com.appBase.service;

import com.appBase.dao.AppUserDao;
import com.appBase.pojo.AppUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AppUserService {

    @Autowired
    private AppUserDao appUserDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public boolean registerUser(String email, String password, String fullName) {
        if (appUserDao.findByEmail(email) != null) {
            return false;
        }
        AppUser newUser = new AppUser();
        newUser.setEmail(email);
        newUser.setPassword(passwordEncoder.encode(password));
        newUser.setFullName(fullName);
        appUserDao.save(newUser);
        return true;
    }

    public AppUser loginUser(String email, String password) {
        AppUser user = appUserDao.findByEmail(email);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public AppUser findUserById(Long id){
        if (id == null) return null;
        return appUserDao.findById(id);
    }
}