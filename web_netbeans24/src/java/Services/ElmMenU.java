package Services;

import BusinessLogic.ContactosBL;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ElmMenU")
public class ElmMenU extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ContactosBL logica = new ContactosBL();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id_contacto");

        if (id != null && logica.Delete(id)) {
            response.sendRedirect("ContactoServlet");
        } else {
            request.setAttribute("mensaje", "❌ No se pudo eliminar el mensaje.");
            request.getRequestDispatcher("mensajes_respuesta.jsp").forward(request, response);
        }
    }
}
