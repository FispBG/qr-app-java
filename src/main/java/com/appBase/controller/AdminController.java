package com.appBase.controller;

import com.appBase.service.AppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AppService appService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        model.addAttribute("appeals", appService.getAppeals());
        model.addAttribute("officeId", session.getAttribute("officeId"));
        return "list";
    }
}
