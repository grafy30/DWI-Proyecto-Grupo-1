package Services;

import BusinessEntify.ContactosBE;
import BusinessEntify.UsuariosBE;
import BusinessLogic.ContactosBL;
import java.io.IOException;
import java.util.List;
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

        ContactosBL logica = new ContactosBL(); // ⚠️ Esto lo necesitas para que funcione todo (agrégalo si aún no está)

        // ✅ ELIMINAR MENSAJE
        if ("eliminar".equals(accion)) {
            try {
                String idContacto = request.getParameter("idContacto");
                boolean eliminado = logica.Delete(idContacto);

                if (eliminado) {
                    response.getWriter().write("ok");
                } else {
                    response.getWriter().write("error");
                }
            } catch (Exception e) {
                System.out.println("❌ Error en eliminación desde ContactoServlet: " + e.getMessage());
                response.getWriter().write("error");
            }
            return; // ⛔ Detenemos aquí para que no continúe con el resto
        }

        // ✅ RESPONDER MENSAJE desde revisar_contacto.jsp
        if ("responder".equals(accion)) {
            try {
                int idContacto = Integer.parseInt(request.getParameter("idContacto"));
                String correoDestino = request.getParameter("correoDestino");
                String respuesta = request.getParameter("respuesta");

                boolean actualizado = logica.responderMensaje(idContacto, respuesta);

                if (actualizado) {
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UsuariosBE usuario = (UsuariosBE) session.getAttribute("usuarioCompleto");

        if (usuario != null) {
            String correo = usuario.getCorreo();
            ContactosBL logica = new ContactosBL();
            System.out.println("Correo del usuario logueado: " + correo);

            List<ContactosBE> pendientes = logica.listarPendientesPorCorreo(correo);
            List<ContactosBE> atendidos = logica.listarRespondidosPorCorreo(correo);

            request.setAttribute("pendientes", pendientes);
            request.setAttribute("atendidos", atendidos);

            request.getRequestDispatcher("mensajes_respuesta.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
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
