package Services;

import BusinessEntify.ContactosBE;
import BusinessLogic.ContactosBL;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ContactoSLServlet")
public class ContactoSLServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ContactosBL logica = new ContactosBL();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        // 👉 Caso 1: ADMIN responde mensaje
        if ("responder".equals(accion)) {
            try {
                int idContacto = Integer.parseInt(request.getParameter("idContacto"));
                String correoDestino = request.getParameter("correoDestino");
                String respuesta = request.getParameter("respuesta");

                boolean actualizado = logica.actualizarRespuestaYEstado(idContacto, respuesta);

                if (actualizado) {
                    // Simular envío de correo al visitante
                    String asunto = "Respuesta a tu mensaje";
                    String cuerpo = "Hola,\n\nGracias por contactarnos. Esta es nuestra respuesta:\n\n" +
                                    respuesta + "\n\nSaludos,\nEquipo de Atención";
                    enviarCorreo(correoDestino, asunto, cuerpo);
                }

                response.sendRedirect("solicitudes_contacto.jsp?respuesta=enviada");
                return;

            } catch (Exception e) {
                System.out.println("❌ Error al responder: " + e.getMessage());
                response.sendRedirect("solicitudes_contacto.jsp?error=responder");
                return;
            }
        }

        // 👉 Caso 2: VISITANTE envía nuevo mensaje desde contacto.jsp
        try {
            String nombre = request.getParameter("fullname");
            String correo = request.getParameter("email");
            String mensaje = request.getParameter("message");

            if (nombre != null && correo != null && mensaje != null &&
                !nombre.trim().isEmpty() && !correo.trim().isEmpty() && !mensaje.trim().isEmpty()) {

                ContactosBE contacto = new ContactosBE();
                contacto.setNombre(nombre);
                contacto.setCorreo(correo);
                contacto.setMensaje(mensaje);
                contacto.setEstado("Pendiente");

                boolean resultado = logica.Create(contacto);

                if (resultado) {
                    // ✅ Simular envío de correo de confirmación al visitante
                    String asunto = "Gracias por tu mensaje";
                    String cuerpo = "Hola " + nombre + ",\n\nGracias por contactarnos. Hemos recibido tu mensaje:\n\n\"" +
                                    mensaje + "\"\n\nNos pondremos en contacto contigo pronto.\n\nSaludos,\nEquipo de Atención";
                    enviarCorreo(correo, asunto, cuerpo);

                    response.sendRedirect("Contacto.jsp?enviado=true");
                } else {
                    request.setAttribute("mensaje", "❌ No se pudo registrar el mensaje.");
                    request.getRequestDispatcher("Contacto.jsp").forward(request, response);
                }

            } else {
                request.setAttribute("mensaje", "❌ Por favor completa todos los campos.");
                request.getRequestDispatcher("Contacto.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("❌ Error al registrar mensaje: " + e.getMessage());
            response.sendRedirect("Contacto.jsp?error=registro");
        }
    }

    private void enviarCorreo(String destino, String asunto, String cuerpo) {
        // Simulación de envío
        System.out.println("📧 Simulación de envío de correo:");
        System.out.println("Para: " + destino);
        System.out.println("Asunto: " + asunto);
        System.out.println("Cuerpo:\n" + cuerpo);
    }
}
