package Services;

import BusinessEntify.ServiciosBE;
import BusinessLogic.ServiciosBL;
import java.io.IOException;
import java.io.InputStream;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.swing.ImageIcon;
import java.awt.image.BufferedImage;
import java.math.BigDecimal;

@WebServlet("/ServiciosServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Máx. 5MB
public class ServiciosServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ServiciosBL logica = new ServiciosBL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id_servicio");
        ServiciosBE servicio;
        if (id != null && !id.isEmpty()) {
            servicio = logica.Read(id);            
        } else {
            servicio = new ServiciosBE();
        }
        request.setAttribute("servicios", servicio);
        request.getRequestDispatcher("registrar_servicios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        // Eliminar por AJAX (opcional)
        if ("eliminar".equals(accion)) {
            String id = request.getParameter("idServicio");
            boolean eliminado = logica.Delete(id);
            response.setContentType("text/plain");
            response.getWriter().write(eliminado ? "ok" : "error");
            return;
        }

        String id_servicio = request.getParameter("id_servicio");
        int id_categoria = Integer.parseInt(request.getParameter("id_categoria"));
        String nombre = request.getParameter("nombre_servicio");
        String descripcion = request.getParameter("descripcion");
        BigDecimal precio_base = new BigDecimal(request.getParameter("precio_base").trim());
        int duracion_estimada = Integer.parseInt(request.getParameter("duracion_estimada"));
        Part imagenPart = request.getPart("imagen");

        ServiciosBE servicio = new ServiciosBE();
        servicio.setId_categoria(id_categoria);
        servicio.setNombre_servicio(nombre);
        servicio.setDescripcion(descripcion);
        servicio.setPrecio_base(precio_base);
        servicio.setDuracion_estimada(duracion_estimada);

        // Procesar imagen si se subió una
        if (imagenPart != null && imagenPart.getSize() > 0) {
            try (InputStream input = imagenPart.getInputStream()) {
                BufferedImage bufferedImage = ImageIO.read(input);
                if (bufferedImage != null) {
                    servicio.setImagen(new ImageIcon(bufferedImage));
                }
            } catch (Exception e) {
                System.out.println("⚠️ Error al procesar la imagen: " + e.getMessage());
            }
        }

        boolean resultado = false;
        String mensaje;

        if ("editar".equals(accion) && id_servicio != null && !id_servicio.isEmpty()) {
            servicio.setId_servicio(Integer.parseInt(id_servicio));
            resultado = logica.Update(servicio);
            mensaje = resultado ? "✅ Servicio actualizado correctamente" : "❌ Error al actualizar el servicio";
        } else if ("registrar".equals(accion)) {
            resultado = logica.Create(servicio);
            mensaje = resultado ? "✅ Servicio registrado correctamente" : "❌ Error al registrar el servicio";
        } else {
            mensaje = "❌ Acción no válida";
        }

        request.setAttribute("mensaje", mensaje);
        request.setAttribute("servicio", servicio);
        request.getRequestDispatcher("registrar_servicios.jsp").forward(request, response);
    }
}
