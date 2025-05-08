package com.appBase.service;

import com.appBase.dao.AppealDao;
import com.appBase.pojo.Appeal;
import com.appBase.pojo.AppUser; // Добавлено
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Transactional
@Service
public class AppService {

    @Autowired
    private AppealDao appealDao;

    @Autowired
    private AppUserService appUserService;

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
        if (appeal != null && appeal.getId() != null) {
            AppUser user = appeal.getAppUser();
            if (user != null) {
                user.removeAppeal(appeal);
            }
            appealDao.deleteAppeal(appeal.getId());
        }
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
        Appeal appealFromQrObject = Appeal.fromString(qrData);

        Pattern pattern = Pattern.compile("appUserId:(\\d+|null)(?=\\s+\\w+:|$)", Pattern.DOTALL);
        Matcher matcher = pattern.matcher(qrData);
        Long appUserId = null;
        if (matcher.find()) {
            String idStr = matcher.group(1);
            if (!"null".equalsIgnoreCase(idStr)) {
                try {
                    appUserId = Long.parseLong(idStr);
                } catch (NumberFormatException e) {
                    System.err.println("Ошибка парсинга appUserId из QR-строки: " + idStr);
                }
            }
        }

        if (appUserId != null) {
            AppUser user = appUserService.findUserById(appUserId);
            if (user != null) {
                appealFromQrObject.setAppUser(user);

            } else {
                System.err.println("AppUser с ID " + appUserId + " из QR-кода не найден.");
            }
        }
        appealDao.updateFromQr(appealFromQrObject.toString());
    }


    public List<Appeal> getAppealsByAppUserId(Long appUserId) {
        return appealDao.getAppealsByAppUserId(appUserId);
    }
}