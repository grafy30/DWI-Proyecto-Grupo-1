package Services;

import BusinessEntify.UsuariosBE;
import DataAccessObject.UsuariosDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CambiarPasswordServlet")
public class CambiarPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UsuariosBE usuario = (UsuariosBE) session.getAttribute("usuario");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validaciones
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("perfil.jsp?error=Las contraseñas no coinciden");
            return;
        }

        // Verificar contraseña actual (deberías comparar hashes en producción)
        if (!usuario.getPassword().equals(currentPassword)) {
            response.sendRedirect("perfil.jsp?error=Contraseña actual incorrecta");
            return;
        }

        try {
            UsuariosDAO usuarioDAO = new UsuariosDAO();

            if (usuarioDAO.actualizarPassword(usuario.getId_usuario(), newPassword)) {
                // Actualizar el objeto en sesión
                usuario.setPassword(newPassword);
                session.setAttribute("usuario", usuario);
                response.sendRedirect("perfil.jsp?success=true");
            } else {
                response.sendRedirect("perfil.jsp?error=Error al cambiar contraseña");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("perfil.jsp?error=Error en el servidor");
        }
    }
}
