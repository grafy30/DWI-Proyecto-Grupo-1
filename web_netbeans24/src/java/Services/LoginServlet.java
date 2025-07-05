package Services;
import BusinessEntify.UsuariosBE;
import DataAccessObject.UsuariosDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String usuario = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("Usuario: " + usuario + ", Password: " + password);

        try {
            UsuariosDAO usuarioDAO = new UsuariosDAO();
            UsuariosBE user = usuarioDAO.login(usuario, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", user.getNickname());
                session.setAttribute("rol", user.getRol());
                session.setAttribute("id_usuario", user.getId_usuario());

                if ("Administrador".equalsIgnoreCase(user.getRol())) {
                    response.sendRedirect("welcome_administrador.jsp");
                } else {
                    response.sendRedirect("welcome_usuario.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2");
        }
    }
}
