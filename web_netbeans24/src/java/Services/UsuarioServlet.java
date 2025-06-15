package Services;

import BusinessEntify.UsuariosBE;
import BusinessLogic.UsuariosBL;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UsuariosBL logica = new UsuariosBL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_usuario = request.getParameter("id_usuario");
        UsuariosBE user;
        if (id_usuario != null && !id_usuario.isEmpty()) {
            user = logica.Read(id_usuario);
        } else {
            user = new UsuariosBE();
        }
        request.setAttribute("usuario", user);
        request.getRequestDispatcher("registrar_usuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        // Eliminación (AJAX)
        if ("eliminar".equals(accion)) {
            String idUsuario = request.getParameter("idUsuario");
            boolean eliminado = logica.Delete(idUsuario);
            response.setContentType("text/plain");
            response.getWriter().write(eliminado ? "ok" : "error");
            return;
        }

        // Registro o Edición
        String id_usuario = request.getParameter("id_usuario");
        String nombres = request.getParameter("nombres");
        String nickname = request.getParameter("usuario");
        String email = request.getParameter("email");
        String passwd = request.getParameter("password");
        String rol = request.getParameter("rol");

        UsuariosBE user = new UsuariosBE();
        user.setNombres(nombres);
        user.setNickname(nickname);
        user.setPassword(passwd);
        user.setRol((rol != null && !rol.isEmpty()) ? rol : "Usuario");
        user.setEmail(email); // <--- Nuevo

        boolean resultado = false;
        String mensaje = "";

        if ("editar".equals(accion) && id_usuario != null && !id_usuario.isEmpty()) {
            user.setId_usuario(Integer.parseInt(id_usuario));
            resultado = logica.Update(user);
            mensaje = resultado ? "✅ Usuario actualizado correctamente" : "❌ Hubo un error al actualizar el usuario.";
        } else if ("registrar".equals(accion)) {
            try {
                resultado = logica.Create(user);
                mensaje = resultado ? "✅ Usuario registrado correctamente" : "❌ Hubo un error al registrar el usuario.";
            } catch (Exception e) {
                // Manejo para errores de usuario duplicado
                if (e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate")) {
                    mensaje = "❌ El nombre de usuario o email ya existe. Elige otro.";
                } else {
                    mensaje = "❌ Error inesperado: " + e.getMessage();
                }
                resultado = false;
            }
        } else {
            mensaje = "❌ Acción no reconocida.";
        }

        request.setAttribute("mensaje", mensaje);
        request.setAttribute("usuario", user);
        request.getRequestDispatcher("registrar_usuarios.jsp").forward(request, response);
    }
}
