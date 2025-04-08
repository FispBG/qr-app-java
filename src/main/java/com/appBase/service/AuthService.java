package com.appBase.service;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class AuthService {

    private String username1="", password1="", username2="", password2="";

    private ResourceLoader resourceLoader;

    public AuthService() {
        loadAdmin();
    }

    private void loadAdmin() {
        try {
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
        System.out.printf(username1 + " "+ password1 + "\n" + username2 +password2);
    }

    public Boolean authenticateOffice1(String username, String password) {
        return username1.equals(username) && password1.equals(password);
    }
    public Boolean authenticateOffice2(String username, String password) {
        return username2.equals(username) && password2.equals(password);
    }
}
