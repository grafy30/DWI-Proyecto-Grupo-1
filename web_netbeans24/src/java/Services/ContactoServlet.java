package Services;

import BusinessEntify.ContactosBE;
import BusinessEntify.UsuariosBE;
import BusinessLogic.ContactosBL;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ContactoServlet")
public class ContactoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ContactosBL logica = new ContactosBL();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        // ✅ RESPONDER MENSAJE desde revisar_contacto.jsp
        if ("responder".equals(accion)) {
            try {
                int idContacto = Integer.parseInt(request.getParameter("idContacto"));
                String correoDestino = request.getParameter("correoDestino");
                String respuesta = request.getParameter("respuesta");

                boolean actualizado = logica.responderMensaje(idContacto, respuesta);

                if (actualizado) {
                    // 🔄 Actualizar estado a "Atendido"
                    ContactosBE contacto = logica.Read(String.valueOf(idContacto));
                    if (contacto != null) {
                        contacto.setEstado("Atendido");
                        logica.Update(contacto);
                    }

                    // 📧 Enviar correo simulado
                    String asunto = "Respuesta a tu solicitud";
                    String cuerpo = "Hola,\n\nGracias por contactarnos. Te respondemos:\n\n"
                            + respuesta + "\n\nSaludos,\nEquipo de Atención";
                    enviarCorreo(correoDestino, asunto, cuerpo);
                }

                response.sendRedirect("solicitudes_contacto.jsp");
                return;

            } catch (NumberFormatException e) {
                System.out.println("❌ Error al parsear ID del contacto: " + e.getMessage());
                response.sendRedirect("solicitudes_contacto.jsp");
                return;
            }
        }

        // ✅ REGISTRO desde Contacto.jsp o nuevo_mensaje.jsp
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String mensaje = request.getParameter("mensaje");

        if (nombre != null && correo != null && mensaje != null) {
            ContactosBE contacto = new ContactosBE();
            contacto.setNombre(nombre);
            contacto.setCorreo(correo);
            contacto.setMensaje(mensaje);
            contacto.setEstado("Pendiente");

            // ⏬ Verifica si hay un usuario logueado (registrado) para guardar su ID
            HttpSession session = request.getSession();
            UsuariosBE usuario = (UsuariosBE) session.getAttribute("usuarioCompleto");

            if (usuario != null) {
                contacto.setId_usuario(usuario.getId_usuario());
            }

            boolean resultado = logica.Create(contacto);

            if (resultado) {
                response.sendRedirect("welcome_usuario.jsp");
            } else {
                request.setAttribute("mensaje", "❌ No se pudo registrar el mensaje.");
                request.getRequestDispatcher("welcome_usuario.jsp").forward(request, response);
            }
        }
    }

    // ✅ Simulación de envío de correo (puedes reemplazarlo luego con JavaMail API real)
    private void enviarCorreo(String destino, String asunto, String cuerpo) {
        System.out.println("📧 Simulación de envío de correo:");
        System.out.println("Para: " + destino);
        System.out.println("Asunto: " + asunto);
        System.out.println("Cuerpo:\n" + cuerpo);
    }
}
