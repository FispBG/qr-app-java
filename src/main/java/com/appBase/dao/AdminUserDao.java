package com.appBase.dao;

import com.appBase.pojo.AdminUser;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminUserDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public AdminUser findByUsername(String username) {
        Query<AdminUser> query = getCurrentSession().createQuery("FROM AdminUser WHERE username = :username", AdminUser.class);
        query.setParameter("username", username);
        try {
            return query.getSingleResult();
        } catch (javax.persistence.NoResultException e) {
            return null;
        }
    }

    public void save(AdminUser adminUser) {
        getCurrentSession().saveOrUpdate(adminUser);
    }
}