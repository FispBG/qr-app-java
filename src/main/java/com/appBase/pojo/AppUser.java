package com.appBase.pojo;

import javax.persistence.*;
import java.util.List;
import java.util.ArrayList; // Added for initialization

@Entity
@Table(name = "app_users")
public class AppUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "email", unique = true, nullable = false, length = 100)
    private String email;

    @Column(name = "password", nullable = false, length = 100) // Increased length for hash
    private String password;

    @Column(name = "full_name", nullable = false, length = 150)
    private String fullName;

    @OneToMany(mappedBy = "appUser", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<Appeal> appeals = new ArrayList<>();

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public List<Appeal> getAppeals() {
        return appeals;
    }

    public void setAppeals(List<Appeal> appeals) {
        this.appeals = appeals;
    }

    public void addAppeal(Appeal appeal) {
        appeals.add(appeal);
        appeal.setAppUser(this);
    }

    public void removeAppeal(Appeal appeal) {
        appeals.remove(appeal);
        appeal.setAppUser(null);
    }
}