// CarritoServlet.java
package Services;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/carrito")
public class CarritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetro del ID del servicio
        String servicioIdStr = request.getParameter("servicioId");

        // Validar que el ID no sea nulo o vacío
        if (servicioIdStr == null || servicioIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID de servicio no proporcionado\"}");
            return;
        }

        int servicioId;

        // Validar que el ID sea un número entero
        try {
            servicioId = Integer.parseInt(servicioIdStr);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID de servicio inválido\"}");
            return;
        }

        // Obtener o crear la sesión
        HttpSession session = request.getSession(true);

        // Obtener el carrito desde la sesión o crear uno nuevo
        Map<Integer, Integer> carrito = (Map<Integer, Integer>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new HashMap<>();
        }

        // Agregar o actualizar la cantidad del servicio en el carrito
        carrito.put(servicioId, carrito.getOrDefault(servicioId, 0) + 1);

        // Guardar el carrito actualizado en sesión
        session.setAttribute("carrito", carrito);

        // Calcular el total de ítems (sumando las cantidades)
        int totalItems = carrito.values().stream().mapToInt(Integer::intValue).sum();

        // Enviar respuesta JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\": true, \"totalItems\": " + totalItems + "}");
    }
}