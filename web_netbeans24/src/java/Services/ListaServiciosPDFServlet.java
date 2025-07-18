package Services;

import BusinessEntify.ServiciosBE;
import BusinessLogic.ServiciosBL;
import Util.ImagenUtils;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListaServiciosPDFServlet")
public class ListaServiciosPDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=ListaServicios.pdf");

        try {
            Document documento = new Document(PageSize.A4.rotate()); // Horizontal
            PdfWriter.getInstance(documento, response.getOutputStream());
            documento.open();

            // Título
            Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLUE);
            Paragraph titulo = new Paragraph("Lista de Servicios", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            titulo.setSpacingAfter(20);
            documento.add(titulo);

            // Tabla
            PdfPTable tabla = new PdfPTable(6);
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{2, 3, 5, 2, 2, 3}); // proporciones

            Font fontCabecera = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            tabla.addCell(crearCeldaCabecera("Categoría", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Nombre", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Descripción", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Precio", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Duración", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Imagen", fontCabecera));

            // Datos
            ServiciosBL logica = new ServiciosBL();
            List<ServiciosBE> servicios = logica.ReadAll();

            Font fontCelda = new Font(Font.FontFamily.HELVETICA, 11);
            for (ServiciosBE s : servicios) {
                tabla.addCell(crearCelda(String.valueOf(s.getId_categoria()), fontCelda));
                tabla.addCell(crearCelda(s.getNombre_servicio(), fontCelda));
                tabla.addCell(crearCelda(s.getDescripcion(), fontCelda));
                tabla.addCell(crearCelda("S/ " + String.format("%.2f", s.getPrecio_base()), fontCelda));
                tabla.addCell(crearCelda(s.getDuracion_estimada() + " días", fontCelda));

                // Imagen
                if (s.getImagen() != null) {
                    try {
                        byte[] imgBytes = ImagenUtils.iconToBytes(s.getImagen());
                        Image img = Image.getInstance(imgBytes);
                        img.scaleToFit(60, 60); // ajuste tamaño

                        PdfPCell imgCell = new PdfPCell(img, true); // fondo transparente
                        imgCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        imgCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                        imgCell.setPadding(5);
                        tabla.addCell(imgCell);
                    } catch (Exception ex) {
                        tabla.addCell(crearCelda("⚠️ Imagen no válida", fontCelda));
                    }
                } else {
                    tabla.addCell(crearCelda("Sin imagen", fontCelda));
                }
            }

            documento.add(tabla);
            documento.close();

        } catch (Exception e) {
            throw new ServletException("❌ Error al generar PDF de servicios: " + e.getMessage(), e);
        }
    }

    private PdfPCell crearCeldaCabecera(String texto, Font font) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, font));
        celda.setHorizontalAlignment(Element.ALIGN_CENTER);
        celda.setBackgroundColor(BaseColor.LIGHT_GRAY);
        celda.setVerticalAlignment(Element.ALIGN_MIDDLE);
        celda.setPadding(5);
        return celda;
    }

    private PdfPCell crearCelda(String texto, Font font) {
        PdfPCell celda = new PdfPCell(new Phrase(texto != null ? texto : "—", font));
        celda.setHorizontalAlignment(Element.ALIGN_LEFT);
        celda.setVerticalAlignment(Element.ALIGN_MIDDLE);
        celda.setPadding(5);
        return celda;
    }
}