package services;

import BusinessEntify.ContactosBE;
import BusinessEntify.UsuariosBE;
import BusinessLogic.ContactosBL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/mensajes-respondidos")
public class MensajesRespondidosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuarioCompleto") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UsuariosBE usuario = (UsuariosBE) session.getAttribute("usuarioCompleto");
        String correo = usuario.getCorreo();

        List<ContactosBE> mensajesRespondidos = new ContactosBL().listarRespondidosPorCorreo(correo);

        request.setAttribute("mensajesRespondidos", mensajesRespondidos);
        request.getRequestDispatcher("mensajes_respuesta.jsp").forward(request, response);
    }
}
