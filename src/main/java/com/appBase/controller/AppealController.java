package com.appBase.controller;


import com.appBase.pojo.Appeal;
import com.appBase.service.AppService;
import com.appBase.service.QrService;
import com.appBase.util.AppealStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping(value ="/appeal")
public class AppealController {

    @Autowired
    private AppService appService;

    @PostMapping("/save")
    public String save(@ModelAttribute("appeal") Appeal appeal) {
        appeal.setStatus(AppealStatus.CREATED);
        appeal.setPrinter(false);
        appService.saveAppeal(appeal);
        return "redirect:/appeal/list";
    }

    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("appeal",new Appeal());
        return "create";
    }


}
