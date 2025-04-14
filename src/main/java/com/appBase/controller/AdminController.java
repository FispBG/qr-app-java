package com.appBase.controller;

import com.appBase.pojo.Appeal;
import com.appBase.service.AppService;
import com.appBase.service.QrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

    @GetMapping("/download")
    public ResponseEntity<byte[]> download(@RequestParam(required = false) Long id, Model model) {
        try {
            List<Appeal> appeals = appService.getCreatedAndNotPrintedAppeals();
            if (appeals.isEmpty()) {
                return ResponseEntity.noContent().build();
            }

            ByteArrayOutputStream bas = new ByteArrayOutputStream();
            ZipOutputStream zos = new ZipOutputStream(bas);

            for (Appeal appeal : appeals) {
                String qrCode = qrService.generateQRCodeImageBase64(appeal);

                byte[] bytes = generateAppealImage(appeal, qrCode);

                String filename = String.format("appeal_%d_%s.png", appeal.getId(), cleanFileName(appeal.getApplicantName()));
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

    private byte[] generateAppealImage(Appeal appeal, String qrCode) throws Exception {
        String html = generateAppealHtml(appeal);

        BufferedImage appealImage = convertHtmlToPng(html);
        BufferedImage qrImage = decodeQr(qrCode);
        BufferedImage combine = combineIm(appealImage, qrImage);

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(combine, "png", baos);
        return baos.toByteArray();
    }

    private String generateAppealHtml(Appeal appeal) {
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html><html><head>");
        html.append("<meta charset=\"UTF-8\">");
        html.append("<title>Заявление #").append(appeal.getId()).append("</title>");
        html.append("<style>");
        html.append("body { font-family: Arial, sans-serif; }");
        html.append(".appeal-card { margin: 20px; padding: 15px; border: 1px solid #ccc; }");
        html.append(".appeal-row { margin: 10px 0; }");
        html.append(".label { font-weight: bold; margin-right: 5px; }");
        html.append(".qr-code { margin-top: 20px; text-align: center; border: 1px solid #000; padding: 10px; }");
        html.append(".qr-code-title { font-weight: bold; margin-bottom: 5px; }");
        html.append("</style>");
        html.append("</head><body>");

        html.append("<div class=\"appeal-card\">");
        html.append("<h2>Заявление #").append(appeal.getId()).append("</h2>");

        html.append("<div class=\"appeal-row\"><span class=\"label\">Заявитель:</span>")
                .append(appeal.getApplicantName()).append("</div>");

        html.append("<div class=\"appeal-row\"><span class=\"label\">Руководитель:</span>")
                .append(appeal.getManagerName()).append("</div>");

        html.append("<div class=\"appeal-row\"><span class=\"label\">Адрес:</span>")
                .append(appeal.getAddress()).append("</div>");

        html.append("<div class=\"appeal-row\"><span class=\"label\">Тема:</span>")
                .append(appeal.getTopic()).append("</div>");

        html.append("<div class=\"appeal-row\"><span class=\"label\">Статус:</span>")
                .append(appeal.getStatus()).append("</div>");

        if (appeal.getContent() != null && !appeal.getContent().isEmpty()) {
            html.append("<div class=\"appeal-row\"><span class=\"label\">Содержимое:</span>")
                    .append(appeal.getContent()).append("</div>");
        }

        if (appeal.getResolution() != null && !appeal.getResolution().isEmpty()) {
            html.append("<div class=\"appeal-row\"><span class=\"label\">Резолюция:</span>")
                    .append(appeal.getResolution()).append("</div>");
        }

        if (appeal.getNotes() != null && !appeal.getNotes().isEmpty()) {
            html.append("<div class=\"appeal-row\"><span class=\"label\">Примечания:</span>")
                    .append(appeal.getNotes()).append("</div>");
        }

        // Добавляем пространство для QR-кода, но сам QR-код добавим позже
        html.append("<div class=\"qr-code\">");
        html.append("<div class=\"qr-code-title\">QR-код:</div>");
        html.append("<div style=\"width:150px; height:150px;\"></div>");
        html.append("</div>");

        html.append("</div></body></html>");

        return html.toString();
    }

    private BufferedImage  convertHtmlToPng(String html) throws Exception {
        JEditorPane jep = new JEditorPane("text/html", html);
        jep.setSize(800, 1200);

        HTMLEditorKit kit = (HTMLEditorKit) jep.getEditorKit();
        jep.setEditable(false);

        BufferedImage image = new BufferedImage(jep.getWidth(), jep.getHeight(), BufferedImage.TYPE_INT_ARGB);

        Graphics2D g = image.createGraphics();
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, jep.getWidth(), jep.getHeight());
        jep.paint(g);
        g.dispose();

        return image;
    }

    private String cleanFileName(String input) {
        if (input == null) return "unknown";
        return input.replaceAll("[^a-zA-Zа-яА-Я0-9\\-]", "_");
    }

    private BufferedImage decodeQr(String input) throws Exception {
        String decodedString = input;
        if(decodedString.startsWith("data:image")) {
            decodedString = decodedString.substring(decodedString.indexOf(",") + 1);
        }

        byte[] decodedBytes = Base64.getDecoder().decode(decodedString);
        ByteArrayInputStream bais = new ByteArrayInputStream(decodedBytes);
        return ImageIO.read(bais);
    }

    private BufferedImage combineIm(BufferedImage appealIm, BufferedImage qrIm) throws Exception {
        BufferedImage combined = new BufferedImage(appealIm.getWidth(), appealIm.getHeight(), BufferedImage.TYPE_INT_ARGB);

        Graphics2D g = combined.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g.drawImage(appealIm, 0, 0, null);

        int qrX = 325;
        int qrY = 320;
        int qrSize = 150;

        g.drawImage(qrIm, qrX, qrY + 3* (qrSize/2)/2, qrSize, qrSize, null);
        g.dispose();

        return combined;
    }

}
