package Services;

import BusinessEntify.ProyectosBE;
import BusinessLogic.ProyectosBL;
import Util.ImagenUtils;

import java.io.IOException;
import java.io.InputStream;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import javax.swing.ImageIcon;
import java.awt.image.BufferedImage;

@WebServlet("/ProyectoServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Máx. 5MB
public class ProyectosServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProyectosBL logica = new ProyectosBL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id_proyecto");
        ProyectosBE proyecto;
        if (id != null && !id.isEmpty()) {
            proyecto = logica.Read(id);
        } else {
            proyecto = new ProyectosBE();
        }
        request.setAttribute("proyecto", proyecto);
        request.getRequestDispatcher("registrar_proyectos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        // Eliminar por AJAX (opcional)
        if ("eliminar".equals(accion)) {
            String id = request.getParameter("idProyecto");
            boolean eliminado = logica.Delete(id);
            response.setContentType("text/plain");
            response.getWriter().write(eliminado ? "ok" : "error");
            return;
        }

        String id_proyecto = request.getParameter("id_proyecto");
        String titulo = request.getParameter("titulo_proyecto");
        String nombre = request.getParameter("nombre_proyecto");
        String descripcion = request.getParameter("descripcion");
        Part imagenPart = request.getPart("imagen");

        ProyectosBE proyecto = new ProyectosBE();
        proyecto.setTitulo_proyecto(titulo);
        proyecto.setNombre_proyecto(nombre);
        proyecto.setDescripcion(descripcion);

        // Procesar imagen si se subió una
        if (imagenPart != null && imagenPart.getSize() > 0) {
            try (InputStream input = imagenPart.getInputStream()) {
                BufferedImage bufferedImage = ImageIO.read(input);
                if (bufferedImage != null) {
                    proyecto.setImagen(new ImageIcon(bufferedImage));
                }
            } catch (Exception e) {
                System.out.println("⚠️ Error al procesar la imagen: " + e.getMessage());
            }
        }

        boolean resultado = false;
        String mensaje;

        if ("editar".equals(accion) && id_proyecto != null && !id_proyecto.isEmpty()) {
            proyecto.setId_proyecto(Integer.parseInt(id_proyecto));
            resultado = logica.Update(proyecto);
            mensaje = resultado ? "✅ Proyecto actualizado correctamente" : "❌ Error al actualizar el proyecto.";
        } else if ("registrar".equals(accion)) {
            resultado = logica.Create(proyecto);
            mensaje = resultado ? "✅ Proyecto registrado correctamente" : "❌ Error al registrar el proyecto.";
        } else {
            mensaje = "❌ Acción no válida.";
        }

        request.setAttribute("mensaje", mensaje);
        request.setAttribute("proyecto", proyecto);
        request.getRequestDispatcher("registrar_proyectos.jsp").forward(request, response);
    }
}
