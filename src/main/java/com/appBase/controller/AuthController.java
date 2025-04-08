package com.appBase.controller;

import com.appBase.service.AuthService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    private AuthService authService = new AuthService();

    @GetMapping("/admin/login")
    public String showForm(Model model) {
        return "admin/login";
    }

    @PostMapping("/admin/login")
    public String login(@RequestParam String username, @RequestParam String password,
                        @RequestParam(required = false) Integer officeId,
                        Model model, HttpSession session) {

        boolean authenticated = false;
        int office = 0;

        if (authService.authenticateOffice1(username, password)) {
            authenticated = true;
            office = 1;
        } else if (authService.authenticateOffice2(username, password)) {
            authenticated = true;
            office = 2;
        }

        if (authenticated) {
            session.setAttribute("officeId", office);
            session.setAttribute("authenticated", true);
            return "redirect:/admin/list";
        } else {
            return "redirect:/admin/login?error=true&officeId=" + (officeId != null ? officeId : "");
        }
    }

    @GetMapping("admin/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
