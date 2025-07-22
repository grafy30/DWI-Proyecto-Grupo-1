package Services;

import BusinessEntify.ServiciosBE;
import BusinessLogic.ServiciosBL;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CategoriaDiseño")
public class CategoriaDiseño extends HttpServlet {

    private final ServiciosBL serviciosBL = new ServiciosBL();
    private static final int SERVICIOS_POR_PAGINA = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obtener parámetros de paginación
            int pagina = 1;
            try {
                pagina = Integer.parseInt(request.getParameter("pagina"));
            } catch (NumberFormatException e) {
                // Usar valor por defecto
            }

            // Obtener servicios para la categoría diseño (asumiendo id_categoria=1)
            ArrayList<ServiciosBE> servicios = serviciosBL.buscarPorCategoria(1);

            // Calcular paginación
            int totalServicios = servicios.size();
            int totalPaginas = (int) Math.ceil((double) totalServicios / SERVICIOS_POR_PAGINA);

            // Obtener sublista para la página actual
            int inicio = (pagina - 1) * SERVICIOS_POR_PAGINA;
            int fin = Math.min(inicio + SERVICIOS_POR_PAGINA, totalServicios);
            List<ServiciosBE> serviciosPagina = servicios.subList(inicio, fin);

            // Configurar atributos para la vista
            request.setAttribute("servicios", serviciosPagina);
            request.setAttribute("paginaActual", pagina);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("totalServicios", totalServicios);

            request.getRequestDispatcher("/categoria_Diseño.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error al cargar servicios", e);
        }
    }
}