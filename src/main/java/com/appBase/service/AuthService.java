package com.appBase.service;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

/**
 * Сервис аутентификации пользователей для двух разных офисов
 */
public class AuthService {

    // Учетные данные для офиса 1 и офиса 2
    private String username1="", password1="", username2="", password2="";

    /**
     * Конструктор, инициализирующий данные администраторов при создании сервиса
     */
    public AuthService() {
        loadAdmin();
    }

    /**
     * Загружает учетные данные администраторов из файлов ресурсов
     */
    private void loadAdmin() {
        try {
            // Загрузка учетных данных для первого офиса
            Resource resource1 = new ClassPathResource("admin_office1.txt");
            if (resource1.exists()) {
                try (InputStream is = resource1.getInputStream()) {
                    byte[] data = is.readAllBytes();
                    String str = new String(data, StandardCharsets.UTF_8);
                    String[] done = str.split("=");
                    username1 = done[0];
                    password1 = done[1];
                }
            } else {
                System.out.println("admin_office1.txt not found in resources");
            }
        } catch (Exception e) {
            System.out.println("Error loading admin_office1.txt: " + e.getMessage());
        }

        try {
            // Загрузка учетных данных для второго офиса
            Resource resource2 = new ClassPathResource("admin_office2.txt");
            if (resource2.exists()) {
                try (InputStream is = resource2.getInputStream()) {
                    byte[] data = is.readAllBytes();
                    String str = new String(data, StandardCharsets.UTF_8);
                    String[] done = str.split("=");
                    username2 = done[0];
                    password2 = done[1];
                }
            } else {
                System.out.println("admin_office2.txt not found in resources");
            }
        } catch (Exception e) {
            System.out.println("Error loading admin_office2.txt: " + e.getMessage());
        }
        // Отладочный вывод загруженных данных
        System.out.printf(username1 + " "+ password1 + "\n" + username2 +password2);
    }

    /**
     * Проверяет учетные данные для офиса 1
     */
    public Boolean authenticateOffice1(String username, String password) {
        return username1.equals(username) && password1.equals(password);
    }

    /**
     * Проверяет учетные данные для офиса 2
     */
    public Boolean authenticateOffice2(String username, String password) {
        return username2.equals(username) && password2.equals(password);
    }
}