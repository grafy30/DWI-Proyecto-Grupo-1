package Services;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/agregarAlCarrito")
public class AgregarAlCarritoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Evita errores con tildes y caracteres especiales
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Obtiene el ID del servicio desde el formulario o AJAX
            String idParam = request.getParameter("servicioId");

            if (idParam == null || idParam.isEmpty()) {
                throw new NumberFormatException("ID no proporcionado");
            }

            int servicioId = Integer.parseInt(idParam);

            HttpSession session = request.getSession();
            Map<Integer, Integer> carrito = (Map<Integer, Integer>) session.getAttribute("carrito");

            if (carrito == null) {
                carrito = new HashMap<>();
            }

            // Suma uno a la cantidad actual del servicio (si ya está en el carrito)
            carrito.put(servicioId, carrito.getOrDefault(servicioId, 0) + 1);

            // Guarda el carrito actualizado en la sesión
            session.setAttribute("carrito", carrito);

            // Calcula el total de ítems sumando las cantidades
            int totalItems = carrito.values().stream().mapToInt(Integer::intValue).sum();

            // Devuelve una respuesta JSON con el total actualizado
            String json = String.format("{\"status\":\"ok\", \"totalItems\":%d}", totalItems);
            response.getWriter().write(json);

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"ID inválido\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Error interno del servidor\"}");
        }
    }
}

