package com.appBase.service;


import com.appBase.dao.AppealDao;
import com.appBase.pojo.Appeal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class AppService {

    @Autowired
    private AppealDao appealDao;

    public List<Appeal> getAppeals() {
        return appealDao.getAllAppeals();
    }

    public List<Appeal> getNewAppeal() {
        return appealDao.getNewAppeals();
    }

    public List<Appeal> getReviewedAppeals(){
        return appealDao.getReviewedAppeals();
    }

    public Appeal getAppealById(Long id) {
        return appealDao.getAppealById(id);
    }

    public Appeal getAppealByUuid(String uuid) {
        return appealDao.getAppealByUuid(uuid);
    }

    public List<Appeal> getCreatedAndNotPrintedAppeals(){
        return appealDao.getCreatedAndNotPrintedAppeals();
    }

    public void saveAppeal(Appeal appeal) {
        appealDao.saveAppeal(appeal);
    }

    public void updateAppeal(Appeal appeal) {
        appealDao.updateAppeal(appeal);
    }

    public void deleteAppeal(Appeal appeal) {
        appealDao.deleteAppeal(appeal.getId());
    }

    public void updateAppealFromQrData(String qrData) {
        Appeal appeal = Appeal.fromString(qrData);
        appealDao.updateAppeal(appeal);
    }
    public List<Appeal> getReviewedAndNotPrintedAppeals() {
        return appealDao.getReviewedAndNotPrintedAppeals();
    }

    public void markAsPrinted(List<Long> ids) {
        appealDao.markAsPrinted(ids);
    }

    public List<Appeal> getAppealByName(String name) {
        return appealDao.getAppealByName(name);
    }

    public void updateFromQr(String qrData) {
        appealDao.updateFromQr(qrData);
    }
}
