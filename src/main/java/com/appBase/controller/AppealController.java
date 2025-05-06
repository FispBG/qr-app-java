package com.appBase.controller;

import com.appBase.pojo.Appeal;
import com.appBase.service.AppService;
import com.appBase.util.AppealStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Контроллер для работы с заявлениями
 */
@Controller
@RequestMapping(value ="/appeal")
public class AppealController {

    @Autowired
    private AppService appService;

    /**
     * Отображает форму проверки заявления
     */
    @GetMapping("/check")
    public String check(Model model) {
        model.addAttribute("appeal",new Appeal());
        return "check";
    }

    /**
     * Выполняет поиск заявлений по имени заявителя
     */
    @PostMapping("/check")
    public String check(@ModelAttribute("appeal") Appeal appeal,Model model) {
        List<Appeal> temp = appService.getAppealByName(appeal.getApplicantName());
        model.addAttribute("officeId", 0);
        model.addAttribute("appeals", temp);
        return "list";
    }

    /**
     * Сохраняет новое заявление
     */
    @PostMapping("/save")
    public String save(@ModelAttribute("appeal") Appeal appeal, @RequestParam(value = "list", required = false) Boolean list) {
        appeal.setStatus(AppealStatus.CREATED);
        appeal.setPrinter(false);
        appService.saveAppeal(appeal);
        if (list){
            return "redirect:/admin/list";
        }
        return "redirect:/";
    }

    /**
     * Отображает форму создания заявления
     */
    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("appeal",new Appeal());
        model.addAttribute("list",false);
        return "create";
    }

    /**
     * Показывает детали заявления по ID
     */
    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        Appeal appeal = appService.getAppealById(id);
        model.addAttribute("appeal",appeal);
        return "viewForUser";
    }
}