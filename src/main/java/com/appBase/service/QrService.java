package com.appBase.service;

import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.QRCodeWriter;
import com.appBase.pojo.Appeal;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;

@Service
public class QrService {

    private static final int QR_WIDTH = 300;
    private static final int QR_HEIGHT = 300;

    public String generateQRCode(Appeal appeal){
        try{
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(
                    appeal.toString(),
                    BarcodeFormat.QR_CODE,
                    QR_WIDTH,
                    QR_HEIGHT
            );

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix,"PNG",baos);
            return Base64.getEncoder().encodeToString(baos.toByteArray());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public String generateQRCodeImageBase64(Appeal appeal) {
        String base64Image = generateQRCode(appeal);
        return "data:image/png;base64," + base64Image;
    }
}
