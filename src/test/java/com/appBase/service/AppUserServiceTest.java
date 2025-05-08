package com.appBase.service;

import com.appBase.dao.AppUserDao;
import com.appBase.pojo.AppUser;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AppUserServiceTest {

    @Mock
    private AppUserDao appUserDao;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private AppUserService appUserService;

    private AppUser testUser;

    @BeforeEach
    void setUp() {
        testUser = new AppUser();
        testUser.setId(1L);
        testUser.setEmail("test@example.com");
        testUser.setFullName("Test User");
        testUser.setPassword("hashedPassword");
    }

    @Test
    void testRegisterUser_Success() {
        when(appUserDao.findByEmail("new@example.com")).thenReturn(null);
        when(passwordEncoder.encode("password123")).thenReturn("encodedPassword");

        boolean result = appUserService.registerUser("new@example.com", "password123", "New User");

        assertTrue(result);
        verify(appUserDao).save(any(AppUser.class));
    }

    @Test
    void testRegisterUser_EmailExists() {
        when(appUserDao.findByEmail("test@example.com")).thenReturn(testUser);

        boolean result = appUserService.registerUser("test@example.com", "password123", "Test User");

        assertFalse(result);
        verify(appUserDao, never()).save(any(AppUser.class));
    }

    @Test
    void testLoginUser_Success() {
        when(appUserDao.findByEmail("test@example.com")).thenReturn(testUser);
        when(passwordEncoder.matches("plainPassword", "hashedPassword")).thenReturn(true);

        AppUser loggedInUser = appUserService.loginUser("test@example.com", "plainPassword");

        assertNotNull(loggedInUser);
        assertEquals("test@example.com", loggedInUser.getEmail());
    }

    @Test
    void testLoginUser_UserNotFound() {
        when(appUserDao.findByEmail("unknown@example.com")).thenReturn(null);

        AppUser loggedInUser = appUserService.loginUser("unknown@example.com", "password");

        assertNull(loggedInUser);
    }

    @Test
    void testLoginUser_WrongPassword() {
        when(appUserDao.findByEmail("test@example.com")).thenReturn(testUser);
        when(passwordEncoder.matches("wrongPassword", "hashedPassword")).thenReturn(false);

        AppUser loggedInUser = appUserService.loginUser("test@example.com", "wrongPassword");

        assertNull(loggedInUser);
    }

    @Test
    void testFindUserById_Found() {
        when(appUserDao.findById(1L)).thenReturn(testUser);
        AppUser foundUser = appUserService.findUserById(1L);
        assertNotNull(foundUser);
        assertEquals(1L, foundUser.getId());
    }

    @Test
    void testFindUserById_NotFound() {
        when(appUserDao.findById(2L)).thenReturn(null);
        AppUser foundUser = appUserService.findUserById(2L);
        assertNull(foundUser);
    }

    @Test
    void testFindUserById_NullId() {
        AppUser foundUser = appUserService.findUserById(null);
        assertNull(foundUser);
        verify(appUserDao, never()).findById(any());
    }
}