package services;

import BusinessEntify.ServiciosBE;
import BusinessLogic.ServiciosBL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/ServiciosServlet")
public class ServiciosServlet extends HttpServlet {
    private final ServiciosBL serviciosBL = new ServiciosBL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ServiciosBE> listaServicios = serviciosBL.listarServicios();
        request.setAttribute("listaServicios", listaServicios);

        RequestDispatcher dispatcher = request.getRequestDispatcher("registrar_servicio.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServiciosBE nuevoServicio = new ServiciosBE();
        nuevoServicio.setId_categoria(Integer.parseInt(request.getParameter("id_categoria")));
        nuevoServicio.setNombre_servicio(request.getParameter("nombre_servicio"));
        nuevoServicio.setDescripcion(request.getParameter("descripcion"));
        nuevoServicio.setPrecio_base(Double.parseDouble(request.getParameter("precio_base")));
        nuevoServicio.setDuracion_estimada(Integer.parseInt(request.getParameter("duracion_estimada")));
        nuevoServicio.setImagen(request.getParameter("imagen"));
        nuevoServicio.setEstado("Activo");

        boolean registrado = serviciosBL.agregarServicio(nuevoServicio);

        if (registrado) {
            response.sendRedirect("ServiciosServlet");
        } else {
            request.setAttribute("error", "Error al registrar el servicio.");
            doGet(request, response);
        }
    }
}
