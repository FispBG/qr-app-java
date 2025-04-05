package com.appBase.controller;


import com.appBase.pojo.Appeal;
import com.appBase.service.AppService;
import com.appBase.util.AppealStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
@RequestMapping("/appeal")
public class AppealController {

    @Autowired
    private AppService appService;

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("appeals",appService.getAppeals());
        return "list";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        Appeal appeal = appService.getAppealById(id);
        model.addAttribute("appeal",appeal);
        return "view";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("appeal") Appeal appeal) {
        appeal.setStatus(AppealStatus.CREATED);
        appService.saveAppeal(appeal);
        return "redirect:/appeal/list";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("appeal",new Appeal());
        return "create";
    }
}
