<%@ page import="BusinessLogic.UsuariosBL, BusinessEntify.UsuariosBE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userId = request.getParameter("id_usuario");
    String estado = request.getParameter("estado");

    UsuariosBL usuarioBL = new UsuariosBL();
    UsuariosBE usuario = null;

    if ("nuevo".equals(estado)) {
        usuario = new UsuariosBE();
    } else if (userId != null && !userId.isEmpty()) {
        usuario = usuarioBL.Read(userId);  
    } else {
        usuario = new UsuariosBE();
    }

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String usuarioNombre = request.getParameter("usuario");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");
        String nombres = request.getParameter("nombres");

        boolean resultado;

        if (userId != null && !userId.isEmpty()) {
            UsuariosBE usuarioActualizado = new UsuariosBE();
            usuarioActualizado.setId_usuario(Integer.parseInt(userId)); // ✅ sigue usando int aquí
            usuarioActualizado.setNombres(nombres);
            usuarioActualizado.setUsuario(usuarioNombre);
            usuarioActualizado.setPassword(password);
            usuarioActualizado.setRol(rol);
            resultado = usuarioBL.Update(usuarioActualizado);

            response.sendRedirect("registrar_usuarios.jsp?estado=" + (resultado ? "editado" : "error"));
            return;
        } else {
            UsuariosBE nuevoUsuario = new UsuariosBE();
            nuevoUsuario.setNombres(nombres);
            nuevoUsuario.setUsuario(usuarioNombre);
            nuevoUsuario.setPassword(password);
            nuevoUsuario.setRol(rol);
            resultado = usuarioBL.Create(nuevoUsuario);

            response.sendRedirect("registrar_usuarios.jsp?estado=" + (resultado ? "registrado" : "error"));
            return;
        }
    }
%>


<!DOCTYPE html>
<html lang="es">
    <head>
        <title><%= (userId != null && !userId.isEmpty()) ? "Editar Usuario" : "Registrar Usuario"%></title>      
        <%@ include file="INCLUDE/header_links.jsp" %>        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    </head>
    <body>
        <%@ include file="INCLUDE/header_administrador.jsp" %>        
        <div class="container mt-4">
            <div class="form-card">
                <% if ("registrado".equals(estado)) { %>
                <div id="alerta" class="alert alert-success text-center">✅ ¡Usuario registrado exitosamente!</div>
                <% } else if ("editado".equals(estado)) { %>
                <div id="alerta" class="alert alert-info text-center">📝 ¡Usuario actualizado correctamente!</div>
                <% } else if ("error".equals(estado)) { %>
                <div id="alerta" class="alert alert-danger text-center">⚠️ Hubo un error. Intente nuevamente.</div>
                <% }%>

                <h3 class="form-title">
                    <%= (userId != null && !userId.isEmpty()) ? "Editar Usuario" : "Registrar Nuevo Usuario"%>
                </h3>

                <form method="post" action="registrar_usuarios.jsp" id="formularioUsuario">
                    <input type="hidden" name="id_usuario" value="<%= userId != null ? userId : ""%>">                    

                    <div class="mb-3">
                        <label for="usuario" class="form-label">Usuario</label>
                        <input type="text" name="usuario" id="usuario" class="form-control"
                               value="<%= usuario.getUsuario() != null ? usuario.getUsuario() : ""%>" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" name="password" id="password" class="form-control"
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
                        <input type="text" name="nombres" id="nombres" class="form-control"
                               value="<%= usuario.getNombres() != null ? usuario.getNombres() : ""%>" required>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-custom">
                            <%= (userId != null && !userId.isEmpty()) ? "Actualizar Usuario" : "Registrar Usuario"%>
                        </button>

                        <button type="button" onclick="limpiarFormulario()" class="btn btn-outline">
                            🧹 Limpiar Datos
                        </button>

                        <a href="listar_usuarios.jsp" class="btn btn-outline">
                            👥 Ver Usuarios
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Script para ocultar la alerta automáticamente y limpiar formulario -->
        <script>
            window.onload = function () {
                const alerta = document.getElementById("alerta");
                if (alerta) {
                    setTimeout(() => {
                        alerta.classList.add("fade-out");
                    }, 2000);
                }
            };

            function limpiarFormulario() {
                document.getElementById("formularioUsuario").reset();
                // También borramos el id_usuario si estamos limpiando para nuevo registro
                document.querySelector('input[name="id_usuario"]').value = "";
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
