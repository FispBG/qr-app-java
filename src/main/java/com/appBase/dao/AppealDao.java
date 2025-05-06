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
    private SessionFactory sessionFactory; // Для управления сессиями Hibernate

    // Получение текущей сессии базы данных
    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    // Получение всех заявлений из базы данных
    public List<Appeal> getAllAppeals(){
        return getCurrentSession().createQuery("from Appeal").list();
    }

    // Получение только заявлений со статусом CREATED
    public List<Appeal> getNewAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where status = :status", Appeal.class);
        query.setParameter("status", AppealStatus.CREATED);
        return query.list();
    }

    // Получение заявлений со статусом CREATED, которые не были распечатаны
    public List<Appeal> getCreatedAndNotPrintedAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where status = :status and printer = false", Appeal.class);
        query.setParameter("status", AppealStatus.CREATED);
        return query.list();
    }

    // Получение рассмотренных и отклоненных заявлений
    public List<Appeal> getReviewedAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where status = :status1 or status = :status2", Appeal.class);
        query.setParameter("status1", AppealStatus.REVIEWED);
        query.setParameter("status2", AppealStatus.REJECTED);
        return query.list();
    }

    // Поиск заявления по его ID
    public Appeal getAppealById(Long id){
        return getCurrentSession().get(Appeal.class, id);
    }

    // Сохранение нового заявления в базу данных
    public void saveAppeal(Appeal appeal) {
        getCurrentSession().save(appeal);
    }

    // Поиск заявления по его UUID
    public Appeal getAppealByUuid(String uuid){
        Query query = getCurrentSession().createQuery("from Appeal where uuid = :uuid");
        query.setParameter("uuid", uuid);
        List<Appeal> appeals = query.list();
        return appeals.isEmpty() ? null : appeals.get(0);
    }

    // Удаление заявления по его ID
    public void deleteAppeal(Long id) {
        Appeal appeal = getCurrentSession().get(Appeal.class, id);
        if (appeal != null) {
            getCurrentSession().delete(appeal);
        }
    }

    // Поиск заявлений по имени заявителя
    public List<Appeal> getAppealByName(String name) {
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where applicant_name = :name", Appeal.class);
        query.setParameter("name", name);
        return query.list();
    }

    // Получение рассмотренных или отклоненных заявлений, которые не были распечатаны
    public List<Appeal> getReviewedAndNotPrintedAppeals(){
        Query<Appeal> query = getCurrentSession().createQuery("from Appeal where (status = :status1 or status = :status2) and printer = false", Appeal.class);
        query.setParameter("status1", AppealStatus.REVIEWED);
        query.setParameter("status2", AppealStatus.REJECTED);
        return query.list();
    }

    // Отметка нескольких заявлений как распечатанных по их ID
    public void markAsPrinted(List<Long> ids){
        if(!ids.isEmpty()){
            for (Long id : ids){
                Appeal appeal = getAppealById(id);
                appeal.setPrinter(true);
                getCurrentSession().saveOrUpdate(appeal);
            }
        }
    }

    // Обновление существующего заявления или сохранение нового
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
            temp.setPrinter(appeal.getPrinter());
            getCurrentSession().update(temp);
        }else{
            getCurrentSession().save(appeal);
        }
    }

    // Обновление заявления из данных QR-кода
    public void updateFromQr(String str) {
        Appeal forSave = Appeal.fromString(str);
        forSave.setPrinter(false);

        Appeal existingAppeal = getAppealByUuid(forSave.getUuid());

        if (existingAppeal != null) {
            existingAppeal.setApplicantName(forSave.getApplicantName());
            existingAppeal.setManagerName(forSave.getManagerName());
            existingAppeal.setAddress(forSave.getAddress());
            existingAppeal.setTopic(forSave.getTopic());
            existingAppeal.setContent(forSave.getContent());
            existingAppeal.setResolution(forSave.getResolution());
            existingAppeal.setStatus(forSave.getStatus());
            existingAppeal.setNotes(forSave.getNotes());
            existingAppeal.setPrinter(false);

            getCurrentSession().update(existingAppeal);
        } else {
            getCurrentSession().save(forSave);
        }
    }
}
