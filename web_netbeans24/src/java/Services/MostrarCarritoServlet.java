package services;
import BusinessEntify.ServiciosBE;
import DataAccessObject.ServiciosDAO;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/verCarrito")
public class MostrarCarritoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener sesión
        HttpSession session = request.getSession(false);
        if (session == null) {
            session = request.getSession(true);
        }

        // Obtener carrito
        Map<Integer, Integer> carrito = (Map<Integer, Integer>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new HashMap<>();
        }

        // Guardar nuevamente en sesión (por si es nueva)
        session.setAttribute("carrito", carrito);

        // Obtener lista de servicios desde DAO
        ServiciosDAO dao = new ServiciosDAO();
        List<ServiciosBE> serviciosDisponibles = dao.obtenerTodosLosServicios();

        // Enviar como atributo a JSP
        request.setAttribute("serviciosDisponibles", serviciosDisponibles);

        // Redirigir a JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("verCarrito.jsp");
        dispatcher.forward(request, response);
    }
}
