package Services;

import BusinessEntify.UsuariosBE;
import BusinessLogic.UsuariosBL;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ListaUsuariosPDFServlet")
public class ListaUsuariosPDFServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UsuariosBL logica = new UsuariosBL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id_usuario = request.getParameter("id_usuario");
        UsuariosBE user;

        if (id_usuario != null && !id_usuario.trim().isEmpty()) {
            user = logica.obtenerUsuarioPorId(id_usuario); // Usa String como parámetro
        } else {
            user = new UsuariosBE(); // Para nuevo usuario
        }

        request.setAttribute("usuario", user);
        request.getRequestDispatcher("registrar_usuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id_usuario = request.getParameter("id_usuario");
        String nombres = request.getParameter("nombres");
        String usuario = request.getParameter("usuario");
        String passwd = request.getParameter("password");
        String rol = request.getParameter("rol");
        String accion = request.getParameter("accion");

        UsuariosBE user = new UsuariosBE();
        user.setNombres(nombres);
        user.setUsuario(usuario);
        user.setPassword(passwd);
        user.setRol((rol != null && !rol.isEmpty()) ? rol : "usuario");

        boolean resultado = false;

        try {
            if ("registrar".equalsIgnoreCase(accion)) {
                resultado = logica.registrarUsuario(user);
                if (resultado) {
                    response.sendRedirect("login.jsp?mensaje=registrado");
                    return;
                } else {
                    request.setAttribute("mensaje", "❌ Error al registrarse");
                }

            } else if ("actualizar".equalsIgnoreCase(accion)) {
                if (id_usuario != null && !id_usuario.trim().isEmpty()) {
                    user.setId_usuario(Integer.parseInt(id_usuario));
                    resultado = logica.actualizarUsuario(user);
                } else {
                    resultado = logica.registrarUsuario(user); // por si acaso
                }

                if (resultado) {
                    request.setAttribute("mensaje", "✅ Usuario actualizado correctamente");
                } else {
                    request.setAttribute("mensaje", "❌ Error al actualizar usuario");
                }

            } else {
                response.sendRedirect("error.jsp?mensaje=Acción no válida");
                return;
            }

        } catch (Exception e) {
            request.setAttribute("mensaje", "❌ Error inesperado: " + e.getMessage());
        }

        // En cualquier caso, vuelve al formulario
        request.setAttribute("usuario", user);
        request.getRequestDispatcher("registrar_usuarios.jsp").forward(request, response);
    }
}