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

        boolean resultado;

        if ("registrar".equals(accion)) {
            resultado = logica.Create(user);

            if (resultado) {
                response.sendRedirect("login.jsp?mensaje=registrado");
            } else {
                request.setAttribute("mensaje", "❌ Error al registrarse");
                request.setAttribute("usuario", user);
                request.getRequestDispatcher("registrar.jsp").forward(request, response);
            }
            return;
        }
        if (id_usuario != null && !id_usuario.isEmpty()) {
            user.setId_usuario(Integer.parseInt(id_usuario));
            resultado = logica.Update(user);
        } else {
            resultado = logica.Create(user);
        }

        if (resultado) {
            request.setAttribute("mensaje", "✅ Usuario procesado correctamente");
        } else {
            request.setAttribute("mensaje", "❌ Error al procesar usuario");
        }

        request.setAttribute("usuario", user);
        request.getRequestDispatcher("registrar_usuarios.jsp").forward(request, response);

    }
}
