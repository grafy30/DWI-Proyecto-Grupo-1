package Services;

import BusinessEntify.ProyectosBE;
import BusinessLogic.ProyectosBL;
import Util.ImagenUtils;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListaProyectosPDFServlet")
public class ListaProyectosPDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=ListaProyectos.pdf");

        try {
            Document documento = new Document(PageSize.A4.rotate()); // Horizontal
            PdfWriter.getInstance(documento, response.getOutputStream());
            documento.open();

            // Título
            Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLUE);
            Paragraph titulo = new Paragraph("Lista de Proyectos", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            titulo.setSpacingAfter(20);
            documento.add(titulo);

            // Tabla
            PdfPTable tabla = new PdfPTable(4);
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{3, 3, 6, 3}); // proporciones

            Font fontCabecera = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            tabla.addCell(crearCeldaCabecera("Título", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Nombre", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Descripción", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Imagen", fontCabecera));

            // Datos
            ProyectosBL logica = new ProyectosBL();
            List<ProyectosBE> proyectos = logica.ReadAll();

            Font fontCelda = new Font(Font.FontFamily.HELVETICA, 11);
            for (ProyectosBE p : proyectos) {
                tabla.addCell(crearCelda(p.getTitulo_proyecto(), fontCelda));
                tabla.addCell(crearCelda(p.getNombre_proyecto(), fontCelda));
                tabla.addCell(crearCelda(p.getDescripcion(), fontCelda));

                // Imagen
                if (p.getImagen() != null) {
                    try {
                        byte[] imgBytes = ImagenUtils.iconToBytes(p.getImagen());
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
            throw new ServletException("❌ Error al generar PDF de proyectos: " + e.getMessage(), e);
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