package Util;

import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import javax.imageio.ImageIO;
import java.util.Base64;

public class ImagenUtils {

    // ✅ Convierte ImageIcon a byte[] (para guardar en BD como LONGBLOB)
    public static byte[] iconToBytes(ImageIcon icon) throws IOException {
        if (icon == null) return null;

        BufferedImage bufferedImage = new BufferedImage(
                icon.getIconWidth(), icon.getIconHeight(), BufferedImage.TYPE_INT_ARGB);
        Graphics g = bufferedImage.createGraphics();
        icon.paintIcon(null, g, 0, 0);
        g.dispose();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(bufferedImage, "png", baos);
        return baos.toByteArray();
    }

    // ✅ Convierte byte[] a ImageIcon (al leer de la BD)
    public static ImageIcon bytesToIcon(byte[] bytes) throws IOException {
        if (bytes == null || bytes.length == 0) return null;

        ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
        BufferedImage img = ImageIO.read(bais);
        return new ImageIcon(img);
    }

    // ✅ Convierte ImageIcon a Base64 para mostrar en HTML
    public static String toBase64(ImageIcon icon) throws IOException {
        if (icon == null) return "";

        BufferedImage bufferedImage = toBufferedImage(icon.getImage());
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(bufferedImage, "png", baos);
        byte[] imageBytes = baos.toByteArray();
        return Base64.getEncoder().encodeToString(imageBytes);
    }

    // 🔁 Convierte cualquier Image a BufferedImage (útil internamente)
    private static BufferedImage toBufferedImage(Image img) {
        if (img instanceof BufferedImage) {
            return (BufferedImage) img;
        }

        BufferedImage bimage = new BufferedImage(
                img.getWidth(null), img.getHeight(null), BufferedImage.TYPE_INT_ARGB);
        Graphics2D bGr = bimage.createGraphics();
        bGr.drawImage(img, 0, 0, null);
        bGr.dispose();
        return bimage;
    }
}
