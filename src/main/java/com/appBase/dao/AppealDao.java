package com.appBase.dao;

import com.appBase.pojo.Appeal;
import com.appBase.util.AppealStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import java.util.List;

@Repository
public class AppealDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public List<Appeal> getAllAppeals(){
        return getCurrentSession().createQuery("from Appeal").list();
    }

    public List<Appeal> getNewAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where status = 'Создано'", Appeal.class);
//        query.setParameter("status", AppealStatus.CREATED);
        System.out.println(query.list());
        return query.list();
    }

    public List<Appeal> getReviewedAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where status = :status1 or status = :status2", Appeal.class);
        query.setParameter("status1", AppealStatus.REVIEWED);
        query.setParameter("status2", AppealStatus.REJECTED);
        return query.list();
    }

    public Appeal getAppealById(Long id){
        return getCurrentSession().get(Appeal.class, id);
    }

    public void saveAppeal(Appeal appeal) {
        getCurrentSession().save(appeal);
    }

    public Appeal getAppealByUuid(String uuid){
        Query query = getCurrentSession().createQuery("from Appeal where uuid = :uuid");
        query.setParameter("uuid", uuid);
        List<Appeal> appeals = query.list();
        return appeals.isEmpty() ? null : appeals.get(0);
    }

    public void deleteAppeal(Long id) {
        Appeal appeal = getCurrentSession().get(Appeal.class, id);
        if (appeal != null) {
            getCurrentSession().delete(appeal);
        }
    }

    public void updateAppeal(Appeal appeal) {
        Appeal temp = getAppealByUuid(appeal.getUuid());
        if (appeal != null) {
            temp.setApplicantName(appeal.getApplicantName());
            temp.setManagerName(appeal.getManagerName());
            temp.setAddress(appeal.getAddress());
            temp.setTopic(appeal.getTopic());
            temp.setContent(appeal.getContent());
            temp.setResolution(appeal.getResolution());
            temp.setStatus(appeal.getStatus());
            temp.setNotes(appeal.getNotes());

            getCurrentSession().update(temp);
        }else{
            getCurrentSession().save(appeal);
        }

    }
}
