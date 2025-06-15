<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Arqui-Peru-Registrarse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <%@ include file="INCLUDE/header_links.jsp" %>

        <!-- Google Sign-In meta -->
        <meta name="google-signin-client_id" content="292674060389-l85p7dgplijd30uqfn5pkde557k6hnms.apps.googleusercontent.com">
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>
        <div class="form-container">
            <div class="card-form" style="max-width: 500px;margin:auto;">
                <h3 class="text-center mb-4">Crear tu Cuenta de Cliente</h3>
                <% String mensaje = (String) request.getAttribute("mensaje"); %>
                <% if (mensaje != null) {%>
                <script>
                    Swal.fire({
                        icon: '<%= mensaje.toLowerCase().contains("error") ? "error" : "success"%>',
                        title: '<%= mensaje.replaceAll("✅|❌", "")%>',
                        showConfirmButton: false,
                        timer: 2200
                    });
                </script>
                <% }%>
                <form action="${pageContext.request.contextPath}/RegistroClienteServlet" method="post">
                    <input type="hidden" name="accion" value="registrar">
                    <div class="mb-3">
                        <label for="nombres" class="form-label">Nombres y Apellidos</label>
                        <input type="text" class="form-control" id="nombres" name="nombres" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="empresa" class="form-label">Empresa (opcional)</label>
                        <input type="text" class="form-control" id="empresa" name="empresa">
                    </div>
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion" required>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="telefono" name="telefono" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100 mb-2">Registrarse</button>
                    <a href="login.jsp" class="btn btn-secondary w-100">Ir a Iniciar Sesión</a>
                </form>
                <div class="text-center mt-3 mb-2">
                    <span>o regístrate con</span>
                </div>
                <!-- Google Sign-In Button (nuevo API) -->
                <div id="g_id_onload"
                     data-client_id="292674060389-l85p7dgplijd30uqfn5pkde557k6hnms.apps.googleusercontent.com"                     
                     data-callback="handleGoogleSignIn"
                     data-auto_prompt="false">
                </div>
                <div class="g_id_signin"
                     data-type="standard"
                     data-size="large"
                     data-theme="outline"
                     data-text="continue_with"
                     data-shape="pill"
                     data-logo_alignment="left">
                </div>
            </div>
        </div>
        <!-- Google API (nuevo) -->
        <script src="https://accounts.google.com/gsi/client" async defer></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="INCLUDE/footer.jsp" %>
        <script>
                    function handleGoogleSignIn(response) {
                        // Aquí recibes el id_token
                        const id_token = response.credential;

                        // Envía el token a tu servlet para procesar login/registro
                        fetch('${pageContext.request.contextPath}/GoogleLoginServlet', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                            body: 'credential=' + encodeURIComponent(id_token)
                        })
                                .then(r => r.json())
                                .then(data => {
                                    if (data.success) {
                                        window.location.href = data.redirect; // A donde quieras mandar tras login exitoso
                                    } else {
                                        Swal.fire({
                                            icon: "error",
                                            title: "No se pudo registrar con Google",
                                            text: data.message || "Error desconocido"
                                        });
                                    }
                                }).catch(() => {
                            Swal.fire({
                                icon: "error",
                                title: "Error de red",
                                text: "No se pudo conectar al servidor."
                            });
                        });
                    }
        </script>
    </body>
</html>
