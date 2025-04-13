package com.appBase.controller;


import com.appBase.pojo.Appeal;
import com.appBase.service.AppService;
import com.appBase.service.QrService;
import com.appBase.util.AppealStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value ="/appeal")
public class AppealController {

    @Autowired
    private AppService appService;

    @GetMapping("/check")
    public String check(Model model) {
        model.addAttribute("appeal",new Appeal());
        return "check";
    }

    @PostMapping("/check")
    public String check(@ModelAttribute("appeal") Appeal appeal,Model model) {
        List<Appeal> temp = appService.getAppealByName(appeal.getApplicantName());
        model.addAttribute("officeId", 0);
        model.addAttribute("appeals", temp);
        return "list";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("appeal") Appeal appeal) {
        appeal.setStatus(AppealStatus.CREATED);
        appeal.setPrinter(false);
        appService.saveAppeal(appeal);
        return "redirect:/";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("appeal",new Appeal());
        return "create";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        Appeal appeal = appService.getAppealById(id);
        model.addAttribute("appeal",appeal);
        return "viewForUser";
    }

}
