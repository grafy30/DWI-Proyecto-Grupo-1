package Services;

import BusinessEntify.ContactosBE;
import BusinessLogic.ContactosBL;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RevisarContactoServlet")
public class RevisarContactoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ContactosBL logica = new ContactosBL();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id_contacto");
        String estado = request.getParameter("estado");

        if (id != null && estado != null) {
            ContactosBE contacto = logica.Read(id);
            if (contacto != null) {
                contacto.setEstado(estado); // "Atendido"
                boolean actualizado = logica.Update(contacto);
                if (actualizado) {
                    // Redirige a la tabla de solicitudes
                    response.sendRedirect("solicitudes_contacto.jsp");
                    return;
                }
            }
        }

        // En caso de error
        request.setAttribute("mensaje", "❌ No se pudo actualizar el estado del mensaje.");
        request.getRequestDispatcher("solicitudes_contacto.jsp").forward(request, response);
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id_contacto");

        if (id != null) {
            ContactosBE contacto = logica.Read(id);
            if (contacto != null) {
                request.setAttribute("contacto", contacto);
                request.getRequestDispatcher("revisar_contacto.jsp").forward(request, response);
                return;
            }
        }

        // En caso de error
        response.sendRedirect("solicitudes_contacto.jsp");
    }

}
