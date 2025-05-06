package com.appBase.service;

import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.QRCodeWriter;
import com.appBase.pojo.Appeal;
import org.springframework.stereotype.Service;
import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.text.html.HTMLEditorKit;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.*;

@Service
public class QrService {

    // Стандартные размеры QR-кода
    private static final int QR_WIDTH = 300;
    private static final int QR_HEIGHT = 300;

    // Генерация QR-кода для заявления и возврат в виде строки Base64
    public String generateQRCode(Appeal appeal){
        try{
            Map<EncodeHintType, Object> hints = new HashMap<>();
            hints.put(EncodeHintType.CHARACTER_SET, "Windows-1251"); // Использование кодировки Windows-1251 для кириллицы

            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(
                    appeal.toString(),
                    BarcodeFormat.QR_CODE,
                    QR_WIDTH,
                    QR_HEIGHT,
                    hints
            );

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix,"PNG",baos);
            return Base64.getEncoder().encodeToString(baos.toByteArray());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // Генерация QR-кода как URL-данных для вставки в HTML
    public String generateQRCodeImageBase64(Appeal appeal) {
        String base64Image = generateQRCode(appeal);
        return "data:image/png;base64," + base64Image;
    }

    // Генерация полного изображения заявления со встроенным QR-кодом
    public byte[] generateAppealImage(Appeal appeal, String qrCode) throws Exception {
        String html = generateAppealHtml(appeal);

        BufferedImage appealImage = convertHtmlToPng(html); // Преобразование HTML в изображение
        BufferedImage qrImage = decodeQr(qrCode);           // Декодирование QR-кода в изображение
        BufferedImage combine = combineIm(appealImage, qrImage); // Объединение обоих изображений

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(combine, "png", baos);
        return baos.toByteArray();
    }

    // Генерация HTML-представления заявления
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

        // Добавление места для QR-кода (будет добавлен позже)
        html.append("<div class=\"qr-code\">");
        html.append("<div class=\"qr-code-title\">QR-код:</div>");
        html.append("<div style=\"width:150px; height:150px;\"></div>");
        html.append("</div>");

        html.append("</div></body></html>");

        return html.toString();
    }

    // Преобразование HTML в PNG-изображение с помощью Swing
    private BufferedImage convertHtmlToPng(String html) throws Exception {
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

    // Очистка имени файла для безопасных операций с файловой системой
    public String cleanFileName(String input) {
        if (input == null) return "unknown";
        return input.replaceAll("[^a-zA-Zа-яА-Я0-9\\-]", "_");
    }

    // Декодирование QR-кода из Base64 в изображение
    private BufferedImage decodeQr(String input) throws Exception {
        String decodedString = input;
        if(decodedString.startsWith("data:image")) {
            decodedString = decodedString.substring(decodedString.indexOf(",") + 1);
        }

        byte[] decodedBytes = Base64.getDecoder().decode(decodedString);
        ByteArrayInputStream bais = new ByteArrayInputStream(decodedBytes);
        return ImageIO.read(bais);
    }

    // Объединение изображения заявления с изображением QR-кода
    private BufferedImage combineIm(BufferedImage appealIm, BufferedImage qrIm) throws Exception {
        BufferedImage combined = new BufferedImage(appealIm.getWidth(), appealIm.getHeight(), BufferedImage.TYPE_INT_ARGB);

        Graphics2D g = combined.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g.drawImage(appealIm, 0, 0, null);

        // Позиционирование QR-кода
        int qrX = 325;
        int qrY = 350;
        int qrSize = 150;

        g.drawImage(qrIm, qrX, qrY + 3* (qrSize/2)/2, qrSize, qrSize, null);
        g.dispose();

        return combined;
    }

    // Чтение данных QR-кода из изображения
    public String decodeQrCodeImg(BufferedImage bufferedImage) throws NotFoundException {
        if (bufferedImage == null) {
            System.err.println("Переданное в decodeQrCodeImg изображение равно null.");
            throw new IllegalArgumentException("Входное изображение не должно быть null");
        }

        LuminanceSource source = new BufferedImageLuminanceSource(bufferedImage);
        BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));

        Map<DecodeHintType, Object> hints = new EnumMap<>(DecodeHintType.class);
        hints.put(DecodeHintType.TRY_HARDER, Boolean.TRUE); // Более тщательное распознавание
        hints.put(DecodeHintType.POSSIBLE_FORMATS, EnumSet.of(BarcodeFormat.QR_CODE));

        hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");
        try {
            Result result = new MultiFormatReader().decode(bitmap, hints);
            System.out.println("QR-код найден и декодирован (UTF-8)!");
            return result.getText();
        } catch (Exception e) {
            System.out.println("Не удалось прочитать в UTF-8. Пробуем windows-1251...");
            throw NotFoundException.getNotFoundInstance();
        }
    }
}