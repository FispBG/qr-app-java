package com.appBase.service;

import java.io.FileInputStream;
import java.util.Properties;

public class AuthService {

    private String username1, password1, username2, password2;

    public AuthService() {
        loadAdmin();
    }

    private void loadAdmin() {
        try {
            Properties prop1 = new Properties();
            try (FileInputStream fis = new FileInputStream("admin_office1.properties")) {
                prop1.load(fis);
                username1 = prop1.getProperty("username");
                password1 = prop1.getProperty("password");
            }

            Properties prop2 = new Properties();
            try (FileInputStream fis = new FileInputStream("admin_office2.properties")) {
                prop2.load(fis);
                username2 = prop2.getProperty("username");
                password2 = prop2.getProperty("password");
            }
        }catch (Exception e) {

        }
    }

    public Boolean authenticateOffice1(String username, String password) {
        return username1.equals(username) && password1.equals(password);
    }
    public Boolean authenticateOffice2(String username, String password) {
        return username2.equals(username) && password2.equals(password);
    }
}
