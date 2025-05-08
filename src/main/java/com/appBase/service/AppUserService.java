package com.appBase.service;

import com.appBase.dao.AppUserDao;
import com.appBase.pojo.AppUser;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AppUserService {

    @Autowired
    private AppUserDao appUserDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Transactional
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

    @Transactional(readOnly = true)
    public AppUser loginUser(String email, String password) {
        AppUser user = appUserDao.findByEmail(email);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Transactional(readOnly = true)
    public AppUser findUserById(Long id){
        if (id == null) return null;
        AppUser user = appUserDao.findById(id);
        if (user != null) {
            Hibernate.initialize(user.getAppeals());
        }
        return user;
    }

    @Transactional
    public void saveOrUpdateUser(AppUser user) {
        appUserDao.save(user);
    }
}