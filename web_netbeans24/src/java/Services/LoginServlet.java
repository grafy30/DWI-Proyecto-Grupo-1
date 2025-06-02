package Services;
import BusinessEntify.UsuariosBE;
import DataAccessObject.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Parámetro username recibido: " + request.getParameter("username"));
        System.out.println("Parámetro password recibido: " + request.getParameter("password"));
        
        String usuario = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            UsuariosBE user = usuarioDAO.login(usuario, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", user.getUsuario());
                session.setAttribute("rol", user.getRol());
                session.setAttribute("id_usuario", user.getId_usuario());

                if ("Administrador".equalsIgnoreCase(user.getRol())) {
                    response.sendRedirect("welcome_administrador.jsp");
                } else {
                    response.sendRedirect("INCLUDE/header_cliente.jsp");
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
