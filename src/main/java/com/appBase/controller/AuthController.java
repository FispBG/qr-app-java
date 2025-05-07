package com.appBase.controller;

import com.appBase.service.AuthService; // Используем новый AuthService
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private AuthService authService;

    @GetMapping("/admin/login")
    public String showAdminLoginForm(Model model, HttpSession session) {
        if (session.getAttribute("adminUsername") != null && "admin".equals(session.getAttribute("authenticatedUserType"))) {
            return "redirect:/admin/list";
        }
        return "admin/login";
    }

    @PostMapping("/admin/login")
    public String loginAdmin(@RequestParam String username, @RequestParam String password,
                             Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        Integer officeId = authService.authenticateAdmin(username, password);

        if (officeId != null) {
            session.setAttribute("officeId", officeId);
            session.setAttribute("adminUsername", username);
            session.setAttribute("authenticatedUserType", "admin");
            // session.setAttribute("authenticated", true);

            return "redirect:/admin/list";
        } else {
            model.addAttribute("error", "Неверный логин или пароль.");
            return "admin/login";
        }
    }

    @GetMapping("/admin/logout")
    public String logoutAdmin(HttpSession session, RedirectAttributes redirectAttributes) {
        session.removeAttribute("officeId");
        session.removeAttribute("adminUsername");
        session.removeAttribute("authenticatedUserType");
        // session.removeAttribute("authenticated");

        // session.invalidate();

        redirectAttributes.addFlashAttribute("successMessage", "Вы успешно вышли из системы.");
        return "redirect:/";
    }
}