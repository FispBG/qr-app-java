package com.appBase.controller;

import com.appBase.pojo.Appeal;
import com.appBase.service.AppService;
import com.appBase.service.QrService;
import com.appBase.util.AppealStatus;
import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import javax.swing.text.html.HTMLEditorKit;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.Buffer;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
    public String printCreated(Model model,HttpSession session) {
        List<Appeal> reviewedAppeals = appService.getCreatedAndNotPrintedAppeals();

        Map<Long, String> qrCodes = new HashMap<>();
        for (Appeal appeal : reviewedAppeals) {
            qrCodes.put(appeal.getId(), qrService.generateQRCodeImageBase64(appeal));
        }

        model.addAttribute("appeals", reviewedAppeals);
        model.addAttribute("qrCodes", qrCodes);
        model.addAttribute("office", session.getAttribute("officeId"));
        System.out.println(reviewedAppeals);
        return "printReviewed";
    }

    @GetMapping("/viewReviewed")
    public String printReviewed(Model model,HttpSession session) {
        List<Appeal> reviewedAppeals = appService.getReviewedAndNotPrintedAppeals();

        Map<Long, String> qrCodes = new HashMap<>();
        for (Appeal appeal : reviewedAppeals) {
            qrCodes.put(appeal.getId(), qrService.generateQRCodeImageBase64(appeal));
        }

        model.addAttribute("appeals", reviewedAppeals);
        model.addAttribute("qrCodes", qrCodes);
        model.addAttribute("office", session.getAttribute("officeId"));
        System.out.println(reviewedAppeals);
        return "printReviewed";
    }

    @PostMapping("/mark-as-printed")
    public String markAsPrinted(@RequestParam List<Long> ids,@RequestParam int idOffice, RedirectAttributes redirectAttributes) {
        appService.markAsPrinted(ids);
        redirectAttributes.addFlashAttribute("message", "Заявления успешно отмечены как распечатанные");
        if (idOffice == 1){
            return "redirect:/admin/viewCreated";
        }
        return "redirect:/admin/viewReviewed";
    }

    @PostMapping("/delete")
    public String delete(@ModelAttribute("appeal") Appeal appeal) {
        appService.deleteAppeal(appService.getAppealById(appeal.getId()));
        return "redirect:/admin/list";
    }

    @GetMapping("/download")
    public ResponseEntity<byte[]> download(@RequestParam Long idOffice,@RequestParam Long id, Model model) {
        try {
            List<Appeal> appeals = new ArrayList<>();
            if (idOffice == 1){
                appeals = appService.getCreatedAndNotPrintedAppeals();
            }else if (idOffice == 2){
                appeals = appService.getReviewedAndNotPrintedAppeals();
            }else if (idOffice == 322){
                appeals.add(appService.getAppealById(id));
            }
            if (appeals.isEmpty()) {
                return ResponseEntity.noContent().build();
            }

            ByteArrayOutputStream bas = new ByteArrayOutputStream();
            ZipOutputStream zos = new ZipOutputStream(bas);

            for (Appeal appeal : appeals) {
                String qrCode = qrService.generateQRCodeImageBase64(appeal);

                byte[] bytes = qrService.generateAppealImage(appeal, qrCode);

                String filename = String.format("appeal_%d_%s.png", appeal.getId(), qrService.cleanFileName(appeal.getApplicantName()));
                ZipEntry ze = new ZipEntry(filename);
                zos.putNextEntry(ze);
                zos.write(bytes);
                zos.closeEntry();
            }
            zos.close();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", "appeals.zip");

            return new ResponseEntity<>(bas.toByteArray(), headers, HttpStatus.OK);
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


    @GetMapping("/scan")
    public String showScanForm(Model model) {
        return "qrScan";
    }

    @PostMapping("/decode")
    public String decode(@RequestParam("image") MultipartFile file, Model model) {
        if (file == null || file.isEmpty()) {
            model.addAttribute("message", "Файл не был загружен или пуст");
            return "qrScan";
        }

        try (InputStream inputStream = file.getInputStream()){

            BufferedImage bufferedImage = ImageIO.read(inputStream);
            if (bufferedImage == null) {
                System.err.println("Не удалось прочитать изображение.");
                model.addAttribute("message", "Не удалось прочитать файл изображения.");
                return "qrScan";
            }

            String decodeText = qrService.decodeQrCodeImg(bufferedImage);

            model.addAttribute("message", "QR-код успешно распознан!");
            model.addAttribute("qrCode", decodeText);

        } catch (IOException e) {
            System.err.println("Ошибка ввода-вывода при обработке файла: " + e.getMessage());
            model.addAttribute("message", "Ошибка при чтении или обработке файла: " + e.getMessage());
        } catch (NotFoundException e) {
            System.err.println("QR-код не найден на изображении.");
            model.addAttribute("message", "QR-код не найден на изображении.");
        } catch (Exception e) {
            System.err.println("Произошла неожиданная ошибка: " + e.getMessage());
            model.addAttribute("message", "Произошла непредвиденная ошибка: " + e.getMessage());
        }
        return "qrScan";
    }

    @PostMapping("/saveAppealQr")
    public String saveAppealQr(@ModelAttribute("appeal") String appeal) {
        appService.updateFromQr(appeal);
        return "redirect:/admin/list";
    }

    @GetMapping("/create")
    public String create(Model model,HttpSession session) {
        model.addAttribute("appeal",new Appeal());
        model.addAttribute("list",true);
        model.addAttribute("officeId", session.getAttribute("officeId"));
        return "create";
    }
}
