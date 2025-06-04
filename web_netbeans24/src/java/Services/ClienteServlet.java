package Services;

import BusinessEntify.ClientesBE;
import BusinessLogic.ClientesBL;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ClienteServlet")
public class ClienteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ClientesBL logica = new ClientesBL();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_cliente = request.getParameter("id_cliente");
        ClientesBE cliente;

        if (id_cliente != null && !id_cliente.isEmpty()) {
            cliente = logica.Read(id_cliente);
        } else {
            cliente = new ClientesBE();
        }

        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("registrar_clientes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id_cliente = request.getParameter("id_cliente");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String empresa = request.getParameter("empresa");
        String tipo = request.getParameter("tipo");
        String accion = request.getParameter("accion");

        // id_usuario de sesión (¡requerido para registrar!)
        HttpSession sesion = request.getSession(false);
        Integer id_usuario = (Integer) (sesion != null ? sesion.getAttribute("id_usuario") : null);

        ClientesBE cliente = new ClientesBE();
        cliente.setTelefono(telefono);
        cliente.setDireccion(direccion);
        cliente.setEmpresa(empresa);
        cliente.setTipo(tipo);
        if (id_usuario != null) {
            cliente.setId_usuario(id_usuario);
        }

        boolean resultado = false;

        // --- ELIMINAR ---
        if ("eliminar".equals(accion)) {
            boolean eliminado = logica.Delete(id_cliente);
            if (eliminado) {
                response.sendRedirect("listar_clientes.jsp?eliminado=ok");
            } else {
                response.sendRedirect("listar_clientes.jsp?eliminado=error");
            }
            return;
        }

        // --- REGISTRAR ---
        if ("registrar".equals(accion)) {
            resultado = logica.Create(cliente);
            if (resultado) {
                response.sendRedirect("listar_clientes.jsp?mensaje=registrado");
            } else {
                request.setAttribute("mensaje", "❌ Error al registrar cliente");
                request.setAttribute("cliente", cliente);
                request.getRequestDispatcher("registrar_clientes.jsp").forward(request, response);
            }
            return;
        }

        // --- EDITAR ---
        if (id_cliente != null && !id_cliente.isEmpty()) {
            cliente.setId_cliente(Integer.parseInt(id_cliente));
            resultado = logica.Update(cliente);
            if (resultado) {
                response.sendRedirect("listar_clientes.jsp?mensaje=editado");
            } else {
                request.setAttribute("mensaje", "❌ Error al actualizar cliente");
                request.setAttribute("cliente", cliente);
                request.getRequestDispatcher("registrar_clientes.jsp").forward(request, response);
            }
            return;
        }

        // Si no hay acción válida, recarga el formulario vacío
        request.setAttribute("cliente", cliente);
        request.setAttribute("mensaje", "❌ Acción no válida.");
        request.getRequestDispatcher("registrar_clientes.jsp").forward(request, response);
    }
}
