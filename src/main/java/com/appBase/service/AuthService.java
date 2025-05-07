package com.appBase.service;

import com.appBase.dao.AdminUserDao;
import com.appBase.pojo.AdminUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AuthService {

    @Autowired
    private AdminUserDao adminUserDao;

    public Integer authenticateAdmin(String username, String plainPasswordFromForm) {
        AdminUser adminUser = adminUserDao.findByUsername(username);
        if (adminUser != null) {
            String plainPasswordFromDb = adminUser.getPassword();
            if (plainPasswordFromDb != null && plainPasswordFromDb.equals(plainPasswordFromForm)) {
                return adminUser.getOfficeId();
            }
        } else {
            System.out.println("Пользователь " + username + " не найден в БД.");
        }
        return null;
    }
}