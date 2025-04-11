package com.appBase.controller;

import com.appBase.pojo.Appeal;
import com.appBase.service.AppService;
import com.appBase.service.QrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AppService appService;
    @Autowired
    private QrService qrService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        model.addAttribute("appeals", appService.getAppeals());
        model.addAttribute("officeId", session.getAttribute("officeId"));
        return "list";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        Appeal appeal = appService.getAppealById(id);
        model.addAttribute("appeal",appeal);
        model.addAttribute("qrCode",qrService.generateQRCodeImageBase64(appeal));
        return "viewForUser";
    }

    @GetMapping("/viewNew")
    public String viewNew(Model model) {
        model.addAttribute("appeals",appService.getNewAppeal());
        model.addAttribute("appeal",new Appeal());
        return "viewNew";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute("appeal") Appeal appeal) {
        appeal.setPrinter(false);
        appService.updateAppeal(appeal);
        return "redirect:/admin/viewNew";
    }

    
}
