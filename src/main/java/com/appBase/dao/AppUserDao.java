package com.appBase.dao;

import com.appBase.pojo.AppUser;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AppUserDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public AppUser findByEmail(String email) {
        Query<AppUser> query = getCurrentSession().createQuery("FROM AppUser WHERE email = :email", AppUser.class);
        query.setParameter("email", email);
        try {
            return query.getSingleResult();
        } catch (javax.persistence.NoResultException e) {
            return null;
        }
    }

    public void save(AppUser appUser) {
        getCurrentSession().saveOrUpdate(appUser);
    }

    public AppUser findById(Long id) {
        return getCurrentSession().get(AppUser.class, id);
    }
}