package Services;

import BusinessEntify.ClientesBE;
import BusinessLogic.ClientesBL;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListaClientesPDFServlet")
public class ListaClientesPDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=ListaClientes.pdf");

        try {
            Document documento = new Document();
            PdfWriter.getInstance(documento, response.getOutputStream());
            documento.open();

            // Título
            Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLUE);
            Paragraph titulo = new Paragraph("Lista de Clientes", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            titulo.setSpacingAfter(20);
            documento.add(titulo);

            // Tabla: ID, Teléfono, Dirección, Empresa, Tipo
            PdfPTable tabla = new PdfPTable(5);
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{1.5f, 2.5f, 3, 2.5f, 2f});

            Font fontCabecera = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            tabla.addCell(crearCeldaCabecera("ID Cliente", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Teléfono", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Dirección", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Empresa", fontCabecera));
            tabla.addCell(crearCeldaCabecera("Tipo Cliente", fontCabecera));

            ClientesBL clientesBL = new ClientesBL();
            List<ClientesBE> clientes = clientesBL.ReadAll();

            Font fontCelda = new Font(Font.FontFamily.HELVETICA, 11);
            for (ClientesBE cliente : clientes) {
                tabla.addCell(crearCelda(String.valueOf(cliente.getId_cliente()), fontCelda));
                tabla.addCell(crearCelda(cliente.getTelefono(), fontCelda));
                tabla.addCell(crearCelda(cliente.getDireccion(), fontCelda));
                tabla.addCell(crearCelda(cliente.getEmpresa(), fontCelda));
                tabla.addCell(crearCelda(cliente.getTipo_cliente(), fontCelda));
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
        PdfPCell celda = new PdfPCell(new Phrase(texto != null ? texto : "", font));
        celda.setHorizontalAlignment(Element.ALIGN_LEFT);
        return celda;
    }
}
