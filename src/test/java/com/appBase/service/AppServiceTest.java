package com.appBase.service;

import com.appBase.dao.AppealDao;
import com.appBase.pojo.Appeal;
import com.appBase.pojo.AppUser;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AppServiceTest {

    @Mock
    private AppealDao appealDao;

    @InjectMocks
    private AppService appService;

    @Test
    void testSaveAppeal_WithAppUser() {
        AppUser user = new AppUser();
        user.setId(1L);
        user.setEmail("user@example.com");

        Appeal appeal = new Appeal();
        appeal.setId(10L);
        appeal.setApplicantName("Test Applicant");
        appeal.setAppUser(user);

        appService.saveAppeal(appeal);
        verify(appealDao).saveAppeal(appeal);
    }

    @Test
    void testSaveAppeal_WithoutAppUser() {
        Appeal appeal = new Appeal();
        appeal.setId(11L);
        appeal.setApplicantName("Anonymous Applicant");
        // appeal.setAppUser(null);

        appService.saveAppeal(appeal);

        verify(appealDao).saveAppeal(appeal);
        assertNull(appeal.getAppUser());
    }

    @Test
    void testGetAppealById() {
        Appeal appeal = new Appeal();
        appeal.setId(1L);
        when(appealDao.getAppealById(1L)).thenReturn(appeal);

        Appeal found = appService.getAppealById(1L);

        assertNotNull(found);
        assertEquals(1L, found.getId());
    }

    @Test
    void testGetAppealsByAppUserId() {
        Long userId = 1L;
        Appeal appeal = new Appeal();
        appeal.setId(100L);

        List<Appeal> expectedAppeals = Collections.singletonList(appeal);
        when(appealDao.getAppealsByAppUserId(userId)).thenReturn(expectedAppeals);

        List<Appeal> actualAppeals = appService.getAppealsByAppUserId(userId);

        assertNotNull(actualAppeals);
        assertEquals(1, actualAppeals.size());
        assertEquals(100L, actualAppeals.get(0).getId());
        verify(appealDao).getAppealsByAppUserId(userId);
    }

    @Test
    void testDeleteAppeal_ValidAppeal() {
        Appeal appeal = new Appeal();
        appeal.setId(1L);
        appService.deleteAppeal(appeal);
        verify(appealDao).deleteAppeal(1L);
    }

    @Test
    void testDeleteAppeal_NullAppeal() {
        appService.deleteAppeal(null);
        verify(appealDao, never()).deleteAppeal(anyLong());
    }

    @Test
    void testDeleteAppeal_AppealWithNullId() {
        Appeal appeal = new Appeal();
        appService.deleteAppeal(appeal);
        verify(appealDao, never()).deleteAppeal(anyLong());
    }
}