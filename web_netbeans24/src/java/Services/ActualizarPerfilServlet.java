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

@WebServlet("/ActualizarPerfilServlet")
public class ActualizarPerfilServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UsuariosBE usuario = (UsuariosBE) session.getAttribute("usuario");
        
        String nombres = request.getParameter("nombres");
        String nickname = request.getParameter("nickname");
        String email = request.getParameter("email");
        
        // Validaciones básicas
        if (nombres == null || nombres.trim().isEmpty()) {
            response.sendRedirect("perfil.jsp?error=Nombres no pueden estar vacíos");
            return;
        }
        
        try {
            UsuariosDAO usuarioDAO = new UsuariosDAO();
            
            // Actualizar solo los campos permitidos
            usuario.setNombres(nombres);
            usuario.setNickname(nickname);
            usuario.setEmail(email); // Solo si permites cambiar email
            
            if (usuarioDAO.actualizarDatosBasicos(usuario)) {
                // Actualizar el usuario en sesión
                session.setAttribute("usuario", usuario);
                response.sendRedirect("perfil.jsp?success=true");
            } else {
                response.sendRedirect("perfil.jsp?error=Error al actualizar perfil");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("perfil.jsp?error=Error en el servidor: " + e.getMessage());
        }
    }
}