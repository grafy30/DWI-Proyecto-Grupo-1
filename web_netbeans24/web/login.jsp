<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Arqui Peru - Login</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>        
        <div class="form-container">
            <div class="card-form">
                <h3 class="text-center mb-4">Iniciar Sesión</h3>

                <!-- Mostrar mensaje si viene desde el servlet -->
                <%
                    String mensaje = (String) request.getAttribute("mensaje");
                    if (mensaje != null && !mensaje.isEmpty()) {
                %>
                    <div class="alert alert-danger" role="alert">
                        <%= mensaje %>
                    </div>
                <% } %>

                <!-- Formulario que se envía al LoginServlet -->
                <form method="post" action="LoginServlet">
                    <div class="mb-3">
                        <label for="username" class="form-label">Usuario</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <a href="recuperar_contraseña.jsp" class="register-link">¿Olvidaste tu contraseña?</a>
                    <button type="submit" class="btn btn-submit">Ingresar</button>
                </form>

                <a href="registrar_cliente_publico.jsp" class="register-link">¿No tienes cuenta? Regístrate</a>
                <a href="declaracion_privacidad.jsp" class="register-link">Declaración de Privacidad</a>
            </div>
        </div>                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="INCLUDE/footer.jsp" %>
    </body>
</html>
