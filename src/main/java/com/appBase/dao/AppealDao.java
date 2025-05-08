package com.appBase.dao;

import com.appBase.pojo.AppUser;
import com.appBase.pojo.Appeal;
import com.appBase.util.AppealStatus;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import javax.persistence.NoResultException;
import java.util.List;

@Repository
public class AppealDao {

    @Autowired
    private SessionFactory sessionFactory;

    public  Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public List<Appeal> getAllAppeals(){
        return getCurrentSession().createQuery("from Appeal", Appeal.class).list();
    }

    public List<Appeal> getNewAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where status = :status", Appeal.class);
        query.setParameter("status", AppealStatus.CREATED);
        return query.list();
    }

    public List<Appeal> getCreatedAndNotPrintedAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where status = :status and printer = false", Appeal.class);
        query.setParameter("status", AppealStatus.CREATED);
        return query.list();
    }

    public List<Appeal> getReviewedAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where status = :status1 or status = :status2", Appeal.class);
        query.setParameter("status1", AppealStatus.REVIEWED);
        query.setParameter("status2", AppealStatus.REJECTED);
        return query.list();
    }

    public Appeal getAppealById(Long id){
        try{
            Query<Appeal> query = getCurrentSession().createQuery(
                    "SELECT a FROM Appeal a LEFT JOIN FETCH a.appUser WHERE a.id = :id", Appeal.class);
            query.setParameter("id", id);
            return query.uniqueResult();
        }catch (Exception e){
            return null;
        }
    }

    public void saveAppeal(Appeal appeal) {
        getCurrentSession().saveOrUpdate(appeal);
    }

    public Appeal getAppealByUuid(String uuid){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where uuid = :uuid", Appeal.class);
        query.setParameter("uuid", uuid);
        List<Appeal> appeals = query.list();
        return appeals.isEmpty() ? null : appeals.get(0);
    }

    public void deleteAppeal(Long id) {
        Session session = getCurrentSession();
        Appeal appeal = session.get(Appeal.class, id);
        if (appeal != null) {
            session.delete(appeal);
        }
    }

    public List<Appeal> getAppealByName(String name) {
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where applicantName = :name", Appeal.class);
        query.setParameter("name", name);
        return query.list();
    }

    public List<Appeal> getAppealsByAppUserId(Long appUserId) {
        Query<Appeal> query = getCurrentSession().createQuery(
                "FROM Appeal a WHERE a.appUser.id = :appUserId ORDER BY a.id DESC", Appeal.class);
        query.setParameter("appUserId", appUserId);
        return query.list();
    }


    public List<Appeal> getReviewedAndNotPrintedAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where (status = :status1 or status = :status2) and printer = false", Appeal.class);
        query.setParameter("status1", AppealStatus.REVIEWED);
        query.setParameter("status2", AppealStatus.REJECTED);
        return query.list();
    }

    public void markAsPrinted(List<Long> ids){
        if(ids != null && !ids.isEmpty()){
            for (Long id : ids){
                Appeal appeal = getAppealById(id);
                if (appeal != null) {
                    appeal.setPrinter(true);
                    getCurrentSession().saveOrUpdate(appeal);
                }
            }
        }
    }

    public void updateAppeal(Appeal appealFromForm) {
        Appeal existingAppeal = getAppealById(appealFromForm.getId());
        if (existingAppeal != null) {
            existingAppeal.setApplicantName(appealFromForm.getApplicantName());
            existingAppeal.setManagerName(appealFromForm.getManagerName());
            existingAppeal.setAddress(appealFromForm.getAddress());
            existingAppeal.setTopic(appealFromForm.getTopic());
            existingAppeal.setContent(appealFromForm.getContent());
            existingAppeal.setResolution(appealFromForm.getResolution());
            existingAppeal.setStatus(appealFromForm.getStatus());
            existingAppeal.setNotes(appealFromForm.getNotes());
            existingAppeal.setPrinter(appealFromForm.getPrinter());
            getCurrentSession().update(existingAppeal);
        } else {
            System.err.println("Attempted to update a non-existent appeal with ID: " + appealFromForm.getId());
        }
    }

    public void updateFromQr(String str) {
        Appeal appealFromQr = Appeal.fromString(str);

        Appeal existingAppeal = null;
        if (appealFromQr.getUuid() != null) {
            existingAppeal = getAppealByUuid(appealFromQr.getUuid());
        } else if (appealFromQr.getId() != null) {
            existingAppeal = getAppealById(appealFromQr.getId());
        }


        if (existingAppeal != null) {
            existingAppeal.setApplicantName(appealFromQr.getApplicantName());
            existingAppeal.setManagerName(appealFromQr.getManagerName());
            existingAppeal.setAddress(appealFromQr.getAddress());
            existingAppeal.setTopic(appealFromQr.getTopic());
            existingAppeal.setContent(appealFromQr.getContent());
            existingAppeal.setResolution(appealFromQr.getResolution());
            existingAppeal.setStatus(appealFromQr.getStatus());
            existingAppeal.setNotes(appealFromQr.getNotes());
            existingAppeal.setPrinter(false);
            if (appealFromQr.getAppUser() != null) {
                existingAppeal.setAppUser(appealFromQr.getAppUser());
            }
            if (appealFromQr.getUuid() != null && !appealFromQr.getUuid().equals(existingAppeal.getUuid())) {
                existingAppeal.setUuid(appealFromQr.getUuid());
            }
            getCurrentSession().update(existingAppeal);
        } else {
            appealFromQr.setPrinter(false);
            if(appealFromQr.getUuid() == null || appealFromQr.getUuid().trim().isEmpty() || "null".equalsIgnoreCase(appealFromQr.getUuid())) {
                appealFromQr.setUuid(java.util.UUID.randomUUID().toString());
            }
            appealFromQr.setId(null);
            getCurrentSession().save(appealFromQr);
        }
    }

    public void deleteAppealById(Long appealId) {
        if (appealId == null) {
            return;
        }

        Session session = getCurrentSession();

        Appeal appealToDelete = null;
        try {
            Query<Appeal> query = session.createQuery(
                    "SELECT a FROM Appeal a LEFT JOIN FETCH a.appUser WHERE a.id = :id", Appeal.class);
            query.setParameter("id", appealId);
            appealToDelete = query.getSingleResult();
        } catch (NoResultException e) {
            return;
        }

        if (appealToDelete != null) {
            AppUser associatedUser = appealToDelete.getAppUser();

            if (associatedUser != null) {
                Hibernate.initialize(associatedUser.getAppeals());
                associatedUser.getAppeals().remove(appealToDelete);
            }
            session.delete(appealToDelete);
        }
    }
}