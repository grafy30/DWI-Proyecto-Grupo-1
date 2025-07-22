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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <style>            
            .container-perfil {                                                               
                max-width: 600px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 30px;
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
            .value-perfil {
                color: #666;
            }
            .btn-perfil {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 4px;
                display: inline-block;
                margin-top: 20px;
            }
            .btn-perfil:hover {
                background-color: #0056b3;
            } 
            .profile-header h1{
                font-size: 35px;
            }
            .profile-header h2{
                font-size: 25px;
            }
            
        </style>
        <%@ include file="INCLUDE/header_links.jsp" %>

    </head>
    <body>
        <%@ include file="INCLUDE/header_usuario.jsp" %>
        <section class="administrador text-center align-items-center mt-5">
            <div class="container-perfil">
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
                    <span class="value-perfil"><%= usuario.getEmail() != null ? usuario.getEmail() : "No especificado"%></span>
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
                    <a href="welcome_usuario.jsp" class="btn-perfil">Volver al Inicio</a>
                    <a href="logout.jsp" class="btn-perfil" style="background-color: #dc3545; margin-left: 10px;">Cerrar Sesión</a>
                </div>            
            </div>
        </section>
        <%@ include file="INCLUDE/footer.jsp" %>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>

