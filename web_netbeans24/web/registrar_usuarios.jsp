<%@ page import="BusinessLogic.UsuariosBL, BusinessEntify.UsuariosBE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userId = request.getParameter("id_usuario");
    String estado = request.getParameter("estado");

    UsuariosBL usuarioBL = new UsuariosBL();
    UsuariosBE usuario = null;

    if ("nuevo".equals(estado)) {
        usuario = new UsuariosBE(); // Limpia los datos
    } else if (userId != null && !userId.isEmpty()) {
        usuario = usuarioBL.obtenerUsuarioPorId(userId);  // ✅ ahora compatible con BL
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
            resultado = usuarioBL.actualizarUsuario(usuarioActualizado);

            response.sendRedirect("registrar_usuarios.jsp?estado=" + (resultado ? "editado" : "error"));
            return;
        } else {
            UsuariosBE nuevoUsuario = new UsuariosBE();
            nuevoUsuario.setNombres(nombres);
            nuevoUsuario.setUsuario(usuarioNombre);
            nuevoUsuario.setPassword(password);
            nuevoUsuario.setRol(rol);
            resultado = usuarioBL.registrarUsuario(nuevoUsuario);

            response.sendRedirect("registrar_usuarios.jsp?estado=" + (resultado ? "registrado" : "error"));
            return;
        }
    }
%>


<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title><%= (userId != null && !userId.isEmpty()) ? "Editar Usuario" : "Registrar Usuario"%></title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                padding-top: 70px; /* espacio para navbar fijo */
                background: linear-gradient(to right, #f0f4ff, #ffffff);
                min-height: 100vh;
            }

            .form-card {
                background: white;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.05);
                max-width: 600px;
                width: 100%;
                margin: 0 auto;
            }

            .form-title {
                font-weight: 600;
                margin-bottom: 30px;
                color: #2c3e50;
                text-align: center;
            }

            .btn-custom {
                background-color: #0d6efd;
                color: white;
                border-radius: 8px;
                padding: 10px 20px;
                transition: all 0.3s ease-in-out;
            }

            .btn-custom:hover {
                background-color: #0a58ca;
            }

            .btn-outline {
                border: 1px solid #0d6efd;
                color: #0d6efd;
                background: transparent;
            }

            .btn-outline:hover {
                background-color: #0d6efd;
                color: white;
            }

            .alert {
                transition: opacity 0.5s ease-in-out;
                border-radius: 10px;
            }

            .fade-out {
                opacity: 0;
                visibility: hidden;
            }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="inicio.jsp">ADMINISTRADOR</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu" 
                        aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarMenu">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">

                        <li class="nav-item">
                            <a class="nav-link" href="listar_roles.jsp">ADMIN</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="admin_clientes.jsp">Clientes</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="admin_servicios.jsp">Servicios</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="admin_proyectos.jsp">Proyectos</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="logout.jsp">Cerrar Sesion</a>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>

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

                <form method="post" action="UsuarioServlet" id="formularioUsuario">
                    <input type="hidden" name="id_usuario" value="<%= userId != null ? userId : ""%>">
                    <input type="hidden" name="accion" value="registrar">

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

                        <a href="listar_roles.jsp" class="btn btn-outline">
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

        <!-- Bootstrap JS Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
