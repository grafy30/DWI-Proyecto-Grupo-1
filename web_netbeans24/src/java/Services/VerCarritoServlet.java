package Services;

import BusinessEntify.ServiciosBE;
import BusinessLogic.ServiciosBL;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class VerCarritoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Map<Integer, Integer> carrito = (Map<Integer, Integer>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new HashMap<>();
        }

        ServiciosBL serviciosBL = new ServiciosBL();
        List<ServiciosBE> serviciosDisponibles = serviciosBL.ReadAll();

        request.setAttribute("carrito", carrito);
        request.setAttribute("serviciosDisponibles", serviciosDisponibles);

        RequestDispatcher dispatcher = request.getRequestDispatcher("verCarrito.jsp");
        dispatcher.forward(request, response);
    }
}