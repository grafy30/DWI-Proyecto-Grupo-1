package Services;

import BusinessEntify.UsuariosBE;
import BusinessEntify.ClientesBE;
import BusinessLogic.UsuariosBL;
import BusinessLogic.ClientesBL;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

@WebServlet("/GoogleLoginServlet")
public class GoogleLoginServlet extends HttpServlet {

    private static final String CLIENT_ID = "292674060389-l85p7dgplijd30uqfn5pkde557k6hnms.apps.googleusercontent.com";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configurar headers CORS
        response.setHeader("Access-Control-Allow-Origin", "*"); // o tu dominio específico
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Max-Age", "3600");
        String idTokenString = request.getParameter("credential");
        response.setContentType("application/json");

        if (idTokenString == null || idTokenString.isEmpty()) {
            response.getWriter().write("{\"success\":false, \"message\":\"Token ausente.\"}");
            return;
        }
        System.out.println("llegada 1");
        try {
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(),
                    JacksonFactory.getDefaultInstance())
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(idTokenString);

            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();

                String email = payload.getEmail();
                String nombre = (String) payload.get("name");
                String googleId = payload.getSubject();

                if (email == null || googleId == null) {
                    response.getWriter().write("{\"success\":false, \"message\":\"Email o ID de Google no encontrado.\"}");
                    return;
                }

                UsuariosBL usuariosBL = new UsuariosBL();
                UsuariosBE usuario = usuariosBL.findByEmail(email);

                if (usuario == null) {
                    // Nuevo usuario: creamos usuario y cliente
                    usuario = new UsuariosBE();
                    usuario.setEmail(email);
                    usuario.setNombres(nombre != null ? nombre : email.split("@")[0]);
                    usuario.setGoogle_id(googleId);
                    usuario.setRol("Usuario");
                    usuario.setPassword(""); // Vacío, login solo con Google
                    boolean creado = usuariosBL.Create(usuario);

                    if (creado) {
                        usuario = usuariosBL.findByEmail(email); // para obtener id_usuario
                        // Crear cliente relacionado
                        ClientesBE cliente = new ClientesBE();
                        cliente.setId_usuario(usuario.getId_usuario());
                        cliente.setEmpresa("");
                        cliente.setDireccion("");
                        cliente.setTelefono("");
                        cliente.setTipo_cliente("Nuevo");
                        new ClientesBL().Create(cliente);
                        System.out.println("llegada 2");
                    } else {
                        response.getWriter().write("{\"success\":false, \"message\":\"No se pudo crear el usuario.\"}");
                        return;
                    }
                }

                // Iniciar sesión: guarda info en session
                HttpSession session = request.getSession();
                session.setAttribute("id_usuario", usuario.getId_usuario());
                session.setAttribute("email", usuario.getEmail());
                session.setAttribute("rol", usuario.getRol());
                session.setAttribute("nombres", usuario.getNombres());

                response.getWriter().write("{\"success\":true, \"redirect\":\"" + request.getContextPath() + "/welcome_usuario.jsp\"}");
            } else {
                response.getWriter().write("{\"success\":false, \"message\":\"Token inválido.\"}");
            }
        } catch (GeneralSecurityException e) {
            response.getWriter().write("{\"success\":false, \"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
