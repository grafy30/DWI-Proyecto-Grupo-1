<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="INCLUDE/header_links.jsp" %>
<%
    BusinessEntify.UsuariosBE usuario = (BusinessEntify.UsuariosBE) request.getAttribute("usuario");
    if (usuario == null) {
        usuario = new BusinessEntify.UsuariosBE();
    }
    boolean esEdicion = usuario.getId_usuario() > 0;
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title><%= esEdicion ? "Editar Usuario" : "Registrar Usuario"%></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <%@ include file="INCLUDE/header_administrador.jsp" %>
        <div class="container mt-4">
            <div class="form-card">
                <% String mensaje = (String) request.getAttribute("mensaje"); %>
                <% if (mensaje != null) {%>
                <script>
                    Swal.fire({
                        icon: '<%= mensaje.toLowerCase().contains("error") || mensaje.toLowerCase().contains("hubo") ? "error" : "success"%>',
                        title: '<%= mensaje.replaceAll("✅|❌", "")%>',
                        showConfirmButton: false,
                        timer: 2000
                    });
                </script>
                <% }%>

                <h3 class="form-title"><%= esEdicion ? "Editar Usuario" : "Registrar Nuevo Usuario"%></h3>
                <form method="post" action="UsuarioServlet" id="formularioUsuario">
                    <input type="hidden" name="id_usuario" value="<%= usuario.getId_usuario() > 0 ? usuario.getId_usuario() : ""%>">
                    <input type="hidden" name="accion" value="<%= esEdicion ? "editar" : "registrar"%>">

                    <div class="mb-3">
                        <label for="usuario" class="form-label">Usuario</label>
                        <input type="text" name="usuario" id="usuario" placeholder="Usuario" class="form-control"
                               value="<%= usuario.getNickname()!= null ? usuario.getNickname(): ""%>" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" name="email" id="email" placeholder="Correo electrónico" class="form-control"
                               value="<%= usuario.getEmail() != null ? usuario.getEmail() : ""%>" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" name="password" id="password" placeholder="Contraseña" class="form-control"
                               value="<%= usuario.getPassword() != null ? usuario.getPassword() : ""%>" required>
                    </div>

                    <div class="mb-3">
                        <label for="rol" class="form-label">Rol</label>
                        <select name="rol" id="rol" class="form-select" required>
                            <option value="">Seleccione un rol</option>
                            <option value="Administrador" <%= "Administrador".equals(usuario.getRol()) ? "selected" : ""%>>Administrador</option>
                            <option value="Usuario" <%= "Usuario".equals(usuario.getRol()) ? "selected" : ""%>>Usuario</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label for="nombres" class="form-label">Nombres</label>
                        <input type="text" name="nombres" id="nombres" placeholder="Nombres" class="form-control"
                               value="<%= usuario.getNombres() != null ? usuario.getNombres() : ""%>" required>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-custom">
                            <%= esEdicion ? "Actualizar Usuario" : "Registrar Usuario"%>
                        </button>
                        <button type="button" onclick="limpiarFormulario()" class="btn btn-outline">🧹 Limpiar Datos</button>
                        <a href="listar_usuarios.jsp" class="btn btn-outline">👥 Ver Usuarios</a>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function limpiarFormulario() {
                document.getElementById("formularioUsuario").reset();
                document.querySelector('input[name="id_usuario"]').value = "";
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
