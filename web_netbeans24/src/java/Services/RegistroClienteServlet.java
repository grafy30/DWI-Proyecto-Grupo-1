package Services;

import BusinessEntify.UsuariosBE;
import BusinessEntify.ClientesBE;
import BusinessLogic.UsuariosBL;
import BusinessLogic.ClientesBL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegistroClienteServlet")
public class RegistroClienteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UsuariosBL usuarioBL = new UsuariosBL();
    private final ClientesBL clienteBL = new ClientesBL();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String nombres = request.getParameter("nombres");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String empresa = request.getParameter("empresa");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");

        String mensaje = "";

        try {
            // 1. Crear Usuario
            UsuariosBE usuario = new UsuariosBE();
            usuario.setNombres(nombres);
            usuario.setEmail(email);
            usuario.setPassword(password);
            usuario.setRol("Usuario"); // Siempre "Usuario" desde el público

            boolean creado = usuarioBL.Create(usuario);
            if (!creado) {
                mensaje = "❌ Error: Este correo ya está registrado.";
            } else {
                // 2. Obtener el id_usuario del nuevo usuario
                UsuariosBE userCreated = usuarioBL.findByEmail(email);
                if (userCreated == null) throw new Exception("No se encontró el usuario creado");

                // 3. Crear Cliente asociado
                ClientesBE cliente = new ClientesBE();
                cliente.setId_usuario(userCreated.getId_usuario());
                cliente.setEmpresa(empresa);
                cliente.setDireccion(direccion);
                cliente.setTelefono(telefono);
                cliente.setTipo_cliente("Nuevo"); // siempre "Nuevo" desde landpage

                boolean cliCreado = clienteBL.Create(cliente);

                if (cliCreado) {
                    mensaje = "✅ Registro exitoso, ahora puedes iniciar sesión.";
                } else {
                    mensaje = "❌ Error: No se pudo crear el cliente.";
                }
            }
        } catch (Exception e) {
            mensaje = "❌ Error inesperado: " + e.getMessage();
        }
        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("registrar_cliente_publico.jsp").forward(request, response);
    }
}
