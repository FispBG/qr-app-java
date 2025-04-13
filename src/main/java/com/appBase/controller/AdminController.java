package com.appBase.controller;

import com.appBase.pojo.Appeal;
import com.appBase.service.AppService;
import com.appBase.service.QrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model, HttpSession session) {
        Appeal appeal = appService.getAppealById(id);
        model.addAttribute("appeal",appeal);
        model.addAttribute("qrCode",qrService.generateQRCodeImageBase64(appeal));
        model.addAttribute("officeId", session.getAttribute("officeId"));
        return "viewForUser";
    }

    @GetMapping("/viewCreated")
    public String printCreated(Model model) {
        List<Appeal> reviewedAppeals = appService.getCreatedAndNotPrintedAppeals();

        Map<Long, String> qrCodes = new HashMap<>();
        for (Appeal appeal : reviewedAppeals) {
            qrCodes.put(appeal.getId(), qrService.generateQRCodeImageBase64(appeal));
        }

        model.addAttribute("appeals", reviewedAppeals);
        model.addAttribute("qrCodes", qrCodes);
        System.out.println(reviewedAppeals);
        return "printReviewed";
    }

    @GetMapping("/viewReviewed")
    public String printReviewed(Model model) {
        List<Appeal> reviewedAppeals = appService.getReviewedAndNotPrintedAppeals();

        Map<Long, String> qrCodes = new HashMap<>();
        for (Appeal appeal : reviewedAppeals) {
            qrCodes.put(appeal.getId(), qrService.generateQRCodeImageBase64(appeal));
        }

        model.addAttribute("appeals", reviewedAppeals);
        model.addAttribute("qrCodes", qrCodes);
        System.out.println(reviewedAppeals);
        return "printReviewed";
    }

    @PostMapping("/mark-as-printed")
    public String markAsPrinted(@RequestParam List<Long> ids, RedirectAttributes redirectAttributes) {
        appService.markAsPrinted(ids);
        redirectAttributes.addFlashAttribute("message", "Заявления успешно отмечены как распечатанные");
        return "redirect:/admin/viewReviewed";
    }

    @PostMapping("/delete")
    public String delete(@ModelAttribute("appeal") Appeal appeal) {
        appService.deleteAppeal(appService.getAppealById(appeal.getId()));
        return "redirect:/admin/list";
    }
}
