package Services;

import BusinessEntify.UsuariosBE;
import BusinessLogic.UsuariosBL;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListaUsuariosPDFServlet")
public class ListaUsuariosPDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=ListaUsuarios.pdf");

        try {

            Document documento = new Document();
            PdfWriter.getInstance(documento, response.getOutputStream());
            documento.open();

            Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLUE);
            Paragraph titulo = new Paragraph("Lista de Usuarios", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            titulo.setSpacingAfter(20);
            documento.add(titulo);

            PdfPTable tabla = new PdfPTable(3); // Solo usuario, nombres y rol
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{3, 4, 3});

            Font fontCabecera = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            tabla.addCell(crearCeldaCabecera("Usuario", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Nombres", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Rol", fontCabecera));

            UsuariosBL usuarioBL = new UsuariosBL();
            List<UsuariosBE> usuarios = usuarioBL.ReadAll();

            Font fontCelda = new Font(Font.FontFamily.HELVETICA, 11);
            for (UsuariosBE usuario : usuarios) {
                tabla.addCell(crearCelda(usuario.getNickname(), fontCelda));
                tabla.addCell(crearCelda(usuario.getNombres(), fontCelda));
                tabla.addCell(crearCelda(usuario.getRol(), fontCelda));
            }

            documento.add(tabla);
            documento.close();

        } catch (Exception e) {
            throw new ServletException("Error al generar PDF: " + e.getMessage(), e);
        }
    }

    private PdfPCell crearCeldaCabecera(String texto, Font font) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, font));
        celda.setHorizontalAlignment(Element.ALIGN_CENTER);
        celda.setBackgroundColor(BaseColor.LIGHT_GRAY);
        return celda;
    }

    private PdfPCell crearCelda(String texto, Font font) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, font));
        celda.setHorizontalAlignment(Element.ALIGN_LEFT);
        return celda;
    }
}
