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
        String accion = request.getParameter("accion");

        // ---- 1. Eliminación por AJAX ----
        if ("eliminar".equals(accion)) {
            String idCliente = request.getParameter("idCliente");
            boolean eliminado = logica.Delete(idCliente);
            response.setContentType("text/plain");
            response.getWriter().write(eliminado ? "ok" : "error");
            return;
        }

        // ---- 2. Registro y Edición ----
        String id_cliente = request.getParameter("id_cliente");
        String id_usuario = request.getParameter("id_usuario");
        String empresa = request.getParameter("empresa");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String tipo_cliente = request.getParameter("tipo_cliente");

        ClientesBE cliente = new ClientesBE();
        cliente.setEmpresa(empresa);
        cliente.setDireccion(direccion);
        cliente.setTelefono(telefono);
        cliente.setTipo_cliente(tipo_cliente);

        boolean resultado = false;
        String mensaje = "";

        if ("editar".equals(accion) && id_cliente != null && !id_cliente.isEmpty()) {
            cliente.setId_cliente(Integer.parseInt(id_cliente));
            // puedes actualizar los demás campos aquí
            resultado = logica.Update(cliente);
            mensaje = resultado ? "✅ Cliente actualizado correctamente" : "❌ Hubo un error al actualizar el cliente.";
        } else if ("registrar".equals(accion)) {
            // Aquí necesitas asegurar que ya tienes un usuario creado y su id_usuario
            cliente.setId_usuario(Integer.parseInt(id_usuario));
            try {
                resultado = logica.Create(cliente);
                mensaje = resultado ? "✅ Cliente registrado correctamente" : "❌ Hubo un error al registrar el cliente.";
            } catch (Exception e) {
                mensaje = "❌ Error inesperado: " + e.getMessage();
                resultado = false;
            }
        } else {
            mensaje = "❌ Acción no reconocida.";
        }

        request.setAttribute("mensaje", mensaje);
        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("registrar_clientes.jsp").forward(request, response);
    }
}
