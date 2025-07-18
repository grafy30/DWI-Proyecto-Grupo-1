<%@page import="BusinessEntify.UsuariosBE"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // SOLUCIÓN: Obtener el objeto completo UsuariosBE de la sesión
    UsuariosBE usuario = (UsuariosBE) session.getAttribute("usuarioCompleto");

    // Verificar que el usuario esté logueado
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil de Usuario</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .profile-header {
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 2px solid #eee;
            }
            .profile-info {
                margin-bottom: 15px;
            }
            .label {
                font-weight: bold;
                color: #333;
                display: inline-block;
                width: 120px;
            }
            .value {
                color: #666;
            }
            .btn {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 4px;
                display: inline-block;
                margin-top: 20px;
            }
            .btn:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="profile-header">
                <h1>Perfil de Usuario</h1>
                <h2>Bienvenido, <%= usuario.getNickname()%></h2>
            </div>

            <div class="profile-info">
                <span class="label">ID Usuario:</span>
                <span class="value"><%= usuario.getId_usuario()%></span>
            </div>

            <div class="profile-info">
                <span class="label">Email:</span>
                <span class="value"><%= usuario.getEmail() != null ? usuario.getEmail() : "No especificado"%></span>
            </div>

            <div class="profile-info">
                <span class="label">Nickname:</span>
                <span class="value"><%= usuario.getNickname()%></span>
            </div>

            <div class="profile-info">
                <span class="label">Nombres:</span>
                <span class="value"><%= usuario.getNombres() != null ? usuario.getNombres() : "No especificado"%></span>
            </div>

            <div class="profile-info">
                <span class="label">Rol:</span>
                <span class="value"><%= usuario.getRol()%></span>
            </div>

            <div class="profile-info">
                <span class="label">Google ID:</span>
                <span class="value"><%= usuario.getGoogle_id() != null ? usuario.getGoogle_id() : "No vinculado"%></span>
            </div>

            <div style="text-align: center; margin-top: 30px;">
                <a href="welcome_usuario.jsp" class="btn">Volver al Inicio</a>
                <a href="logout.jsp" class="btn" style="background-color: #dc3545; margin-left: 10px;">Cerrar Sesión</a>
            </div>
        </div>
    </body>
</html>

