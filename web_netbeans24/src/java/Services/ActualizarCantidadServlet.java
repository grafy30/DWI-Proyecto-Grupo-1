package Services;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/actualizarCantidad")
public class ActualizarCantidadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Validar parámetros
        String servicioIdStr = request.getParameter("servicioId");
        String cantidadStr = request.getParameter("cantidad");

        if (servicioIdStr == null || cantidadStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Faltan parámetros.");
            return;
        }

        int servicioId, nuevaCantidad;

        try {
            servicioId = Integer.parseInt(servicioIdStr);
            nuevaCantidad = Integer.parseInt(cantidadStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetros inválidos.");
            return;
        }

        // Obtener sesión y carrito
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp"); // o mostrar un error
            return;
        }

        Map<Integer, Integer> carrito = (Map<Integer, Integer>) session.getAttribute("carrito");
        if (carrito == null) {
            response.sendRedirect("verCarrito.jsp");
            return;
        }

        // Actualizar o eliminar según la nueva cantidad
        if (nuevaCantidad > 0) {
            carrito.put(servicioId, nuevaCantidad);
        } else {
            carrito.remove(servicioId);
        }

        session.setAttribute("carrito", carrito);
        response.sendRedirect("verCarrito.jsp");
    }
}
