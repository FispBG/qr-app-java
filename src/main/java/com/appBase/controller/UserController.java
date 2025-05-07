package com.appBase.controller;

import com.appBase.pojo.AppUser;
import com.appBase.service.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private AppUserService appUserService;

    @GetMapping("/login")
    public String showLoginForm(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") != null && "citizen".equals(session.getAttribute("authenticatedUserType"))) {
            return "redirect:/appeal/my-appeals";
        }
        model.addAttribute("appUser", new AppUser());
        return "user/login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email, @RequestParam String password,
                            HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        AppUser user = appUserService.loginUser(email, password);
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            session.setAttribute("authenticatedUserType", "citizen");
            return "redirect:/appeal/my-appeals";
        } else {
            model.addAttribute("error", "Invalid email or password.");
            return "user/login";
        }
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") != null && "citizen".equals(session.getAttribute("authenticatedUserType"))) {
            return "redirect:/appeal/my-appeals";
        }
        model.addAttribute("appUser", new AppUser());
        return "user/register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam String email,
                               @RequestParam String password,
                               @RequestParam String fullName,
                               Model model, RedirectAttributes redirectAttributes) {

        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                fullName == null || fullName.trim().isEmpty()) {
            model.addAttribute("error", "All fields are required.");
            model.addAttribute("fullName", fullName); // Keep entered values
            model.addAttribute("email", email);
            return "user/register";
        }

        boolean success = appUserService.registerUser(email, password, fullName);
        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "Registration successful! Please login.");
            return "redirect:/user/login";
        } else {
            model.addAttribute("error", "Email already exists or registration failed.");
            model.addAttribute("fullName", fullName);
            model.addAttribute("email", email);
            return "user/register";
        }
    }

    @GetMapping("/logout")
    public String logoutUser(HttpSession session) {
        session.removeAttribute("loggedInUser");
        if ("citizen".equals(session.getAttribute("authenticatedUserType"))) {
            session.removeAttribute("authenticatedUserType");
        }
        return "redirect:/";
    }
}