package Services;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/eliminarDelCarrito")
public class EliminarDelCarritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int servicioId = Integer.parseInt(request.getParameter("servicioId"));
        HttpSession session = request.getSession();
        Map<Integer, Integer> carrito = (Map<Integer, Integer>) session.getAttribute("carrito");

        if (carrito != null && carrito.containsKey(servicioId)) {
            int cantidad = carrito.get(servicioId);
            if (cantidad > 1) {
                carrito.put(servicioId, cantidad - 1);
            } else {
                carrito.remove(servicioId);
            }
            session.setAttribute("carrito", carrito);
        }

        response.sendRedirect("verCarrito.jsp");
    }
}
