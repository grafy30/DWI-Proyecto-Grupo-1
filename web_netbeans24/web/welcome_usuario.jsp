<%@page import="BusinessEntify.UsuariosBE"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;

    // Intentar obtener el objeto UsuariosBE completo (si se implementó la solución anterior)
    UsuariosBE usuarioCompleto = (sesion != null) ? (UsuariosBE) sesion.getAttribute("usuarioCompleto") : null;

    String nombreUsuario = null;
    String nombreCompleto = null;

    if (usuarioCompleto != null) {
        // Si tenemos el objeto completo, usar el nombre completo o nickname
        nombreCompleto = usuarioCompleto.getNombres();
        nombreUsuario = (nombreCompleto != null && !nombreCompleto.trim().isEmpty())
                ? nombreCompleto : usuarioCompleto.getNickname();
    } else {
        // Fallback: usar solo el nickname de la sesión
        nombreUsuario = (sesion != null) ? (String) sesion.getAttribute("usuario") : null;
    }

    // Si no hay usuario en sesión, redirigir al login
    if (nombreUsuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio Usuario</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    </head>
    <body>
        <%@ include file="INCLUDE/header_usuario.jsp" %>
        <section class="administrador text-center align-items-center mt-5">
            <h1>¡Hola, <%= nombreUsuario%>!</h1>
            <p>Has iniciado sesión correctamente.</p>
            <% if (usuarioCompleto != null && usuarioCompleto.getRol() != null) {%>
            <p class="text-muted">Rol: <%= usuarioCompleto.getRol()%></p>
            <% }%>
        </section>                        
        <%@ include file="INCLUDE/footer.jsp" %>
    </body>    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>

