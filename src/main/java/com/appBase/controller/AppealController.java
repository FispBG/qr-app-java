package com.appBase.controller;

import com.appBase.pojo.Appeal;
import com.appBase.pojo.AppUser;
import com.appBase.service.AppService;
import com.appBase.service.AppUserService; // Added
import com.appBase.util.AppealStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value ="/appeal")
public class AppealController {

    @Autowired
    private AppService appService;

    @Autowired
    private AppUserService appUserService; // Added

    /**
     * Отображает форму проверки заявления (поиск по имени)
     */
//    @GetMapping("/check")
//    public String check(Model model) {
//        model.addAttribute("appeal", new Appeal()); // For form binding
//        return "check"; // check.jsp
//    }

    /**
     * Выполняет поиск заявлений по имени заявителя (для гостей или админов)
     */
//    @PostMapping("/check")
//    public String checkByName(@ModelAttribute("appeal") Appeal appeal, Model model, HttpSession session) {
//        List<Appeal> temp = appService.getAppealByName(appeal.getApplicantName());
//
//        if (session.getAttribute("adminUsername") != null) {
//            model.addAttribute("officeId", session.getAttribute("officeId"));
//        } else if (session.getAttribute("loggedInUser") != null && "citizen".equals(session.getAttribute("authenticatedUserType"))) {
//            model.addAttribute("isCitizenView", true); // Flag for list.jsp
//        } else {
//            model.addAttribute("officeId", 0); // Guest view
//        }
//        model.addAttribute("appeals", temp);
//        model.addAttribute("pageTitle", "Search Results for: " + appeal.getApplicantName());
//        return "list"; // list.jsp
//    }

    /**
     * Сохраняет новое заявление
     */
    @PostMapping("/save")
    public String save(@ModelAttribute("appeal") Appeal appeal,
                       @RequestParam(value = "list", required = false) Boolean fromAdminList,
                       HttpSession session, RedirectAttributes redirectAttributes) {
        appeal.setStatus(AppealStatus.CREATED);
        appeal.setPrinter(false);

        AppUser loggedInCitizen = (AppUser) session.getAttribute("loggedInUser");
        String userType = (String) session.getAttribute("authenticatedUserType");

        if (loggedInCitizen != null && "citizen".equals(userType)) {
            AppUser persistentUser = appUserService.findUserById(loggedInCitizen.getId());
            if (persistentUser != null) {
                appeal.setAppUser(persistentUser);
                if(appeal.getApplicantName() == null || appeal.getApplicantName().trim().isEmpty()){
                    appeal.setApplicantName(persistentUser.getFullName());
                }
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Error: Logged in user not found.");
                return "redirect:/appeal/create";
            }
        } else if (session.getAttribute("adminUsername") != null && "admin".equals(userType)){
        } else {
        }


        appService.saveAppeal(appeal);
        redirectAttributes.addFlashAttribute("successMessage", "Appeal saved successfully!");

        if (fromAdminList != null && fromAdminList){
            return "redirect:/admin/list";
        }
        if (loggedInCitizen != null && "citizen".equals(userType)) {
            return "redirect:/appeal/my-appeals";
        }
        return "redirect:/";
    }

    /**
     * Отображает форму создания заявления (для гостей и граждан)
     */
    @GetMapping("/create")
    public String create(Model model, HttpSession session) {
        Appeal newAppeal = new Appeal();
        AppUser loggedInCitizen = (AppUser) session.getAttribute("loggedInUser");
        String userType = (String) session.getAttribute("authenticatedUserType");

        if (loggedInCitizen != null && "citizen".equals(userType)) {
            newAppeal.setApplicantName(loggedInCitizen.getFullName());
        }

        model.addAttribute("appeal", newAppeal);
        model.addAttribute("list",false);
        return "create";
    }

    /**
     * Показывает детали заявления по ID (для граждан и гостей)
     */
    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model, HttpSession session) {
        Appeal appeal = appService.getAppealById(id);
        if (appeal == null) {
            return "redirect:/";
        }

        AppUser loggedInCitizen = (AppUser) session.getAttribute("loggedInUser");
        String userType = (String) session.getAttribute("authenticatedUserType");

        boolean isAdmin = (session.getAttribute("adminUsername") != null && "admin".equals(userType));

        if (!isAdmin && loggedInCitizen != null && "citizen".equals(userType)) {
            if (appeal.getAppUser() == null || !appeal.getAppUser().getId().equals(loggedInCitizen.getId())) {
                model.addAttribute("errorMessage", "You do not have permission to view this appeal.");
                return "error_page";
            }
        } else if (!isAdmin && loggedInCitizen == null) {
        }


        model.addAttribute("appeal", appeal);

        if (isAdmin) {
            model.addAttribute("officeId", session.getAttribute("officeId"));
        }
        return "viewForUser";
    }

    /**
     * Отображает список заявлений, принадлежащих залогиненному гражданину
     */
    @GetMapping("/my-appeals")
    public String showMyRequisitions(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        AppUser loggedInUser = (AppUser) session.getAttribute("loggedInUser");
        String userType = (String) session.getAttribute("authenticatedUserType");

        if (loggedInUser != null && "citizen".equals(userType)) {
            List<Appeal> myAppeals = appService.getAppealsByAppUserId(loggedInUser.getId());
            model.addAttribute("appeals", myAppeals);
            model.addAttribute("pageTitle", "My Submitted Appeals");
            model.addAttribute("isCitizenView", true);
            return "list";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "You need to login to view your appeals.");
            return "redirect:/user/login";
        }
    }
}