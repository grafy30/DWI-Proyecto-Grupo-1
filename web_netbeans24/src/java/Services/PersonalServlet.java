package Services;

import BusinessEntify.PersonalBE;
import BusinessLogic.PersonalBL;

import java.io.IOException;
import java.io.InputStream;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.swing.ImageIcon;
import java.awt.image.BufferedImage;

@WebServlet("/PersonalServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Máx. 5MB
public class PersonalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final PersonalBL logica = new PersonalBL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id_personal");
        PersonalBE personal;
        if (id != null && !id.isEmpty()) {
            personal = logica.Read(id);
        } else {
            personal = new PersonalBE();
        }
        request.setAttribute("personal", personal);
        request.getRequestDispatcher("registrar_personal.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        // Eliminar por AJAX (opcional)
        if ("eliminar".equals(accion)) {
            String id = request.getParameter("id_personal");
            boolean eliminado = logica.Delete(id);
            response.setContentType("text/plain");
            response.getWriter().write(eliminado ? "ok" : "error");
            return;
        }

        String id_personal = request.getParameter("id_personal");
        String nombres = request.getParameter("nombres");
        String cargo = request.getParameter("cargo");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String descripcion = request.getParameter("descripcion");
        Part imagenPart = request.getPart("imagen");

        PersonalBE personal = new PersonalBE();
        personal.setNombre_personal(nombres);
        personal.setCargo_personal(cargo);
        personal.setCorreo_personal(correo);
        personal.setTelefono_personal(telefono);
        personal.setDescripcion(descripcion);

        // Procesar imagen si se subió una
        if (imagenPart != null && imagenPart.getSize() > 0) {
            try (InputStream input = imagenPart.getInputStream()) {
                BufferedImage bufferedImage = ImageIO.read(input);
                if (bufferedImage != null) {
                    personal.setImagen(new ImageIcon(bufferedImage));
                }
            } catch (Exception e) {
                System.out.println("⚠️ Error al procesar la imagen: " + e.getMessage());
            }
        }

        boolean resultado = false;
        String mensaje;

        if ("editar".equals(accion) && id_personal != null && !id_personal.isEmpty()) {
            personal.setId_personal(Integer.parseInt(id_personal));
            resultado = logica.Update(personal);
            mensaje = resultado ? "✅ Personal actualizado correctamente" : "❌ Error al actualizar el personal.";
        } else if ("registrar".equals(accion)) {
            resultado = logica.Create(personal);
            mensaje = resultado ? "✅ Personal registrado correctamente" : "❌ Error al registrar el personal.";
        } else {
            mensaje = "❌ Acción no válida.";
        }

        request.setAttribute("mensaje", mensaje);
        request.setAttribute("personal", personal);
        request.getRequestDispatcher("registrar_personal.jsp").forward(request, response);
    }
}
