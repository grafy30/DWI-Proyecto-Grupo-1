<%-- 
    Document   : login
    Created on : 1 may. 2025, 21:36:09
    Author     : DIEGO DAMIAN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, DataAccessObject.ConexionMySQL" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        
        body {
            background-color: #141414;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card-form {
            background-color: #1f1f1f;
            border-radius: 15px;
            padding: 30px;
            width: 100%;
            max-width: 500px;
            color: white;
            box-shadow: 0px 0px 20px rgba(255, 0, 87, 0.5);
        }
        .form-label { color: #ffffff; }
        .form-control {
            background-color: #333;
            border: none;
            color: white;
        }
        .form-control:focus {
            background-color: #444;
            color: white;
        }
        .btn-submit {
            background-color: #ff0057;
            border: none;
            width: 100%;
        }
        .btn-submit:hover {
            background-color: #e6004c;
        }
        .register-link {
            margin-top: 10px;
            display: block;
            text-align: center;
            color: #ff0057;
            text-decoration: none;
        }
        .alert {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="card-form">
        <h2 class="text-center mb-4">Iniciar Sesión</h2>

        <%
            String mensaje = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                if (username != null && password != null) {
                    Connection conn = null;
                    try {
                        ConexionMySQL conexionMySQL = new ConexionMySQL();
                        conn = conexionMySQL.getConexion();

                        if (conn == null) {
                            mensaje = " No se pudo conectar a la base de datos.";
                        } else {
                            String sql = "SELECT id_usuario, rol FROM usuario WHERE usuario = ? AND password = ?";
                            PreparedStatement ps = conn.prepareStatement(sql);
                            ps.setString(1, username);
                            ps.setString(2, password);
                            ResultSet rs = ps.executeQuery();

                            if (rs.next()) {
                                int idUsuario = rs.getInt("id_usuario");
                                String rol = rs.getString("rol");

                                HttpSession sesion = request.getSession();
                                sesion.setAttribute("idUsuario", idUsuario);
                                sesion.setAttribute("rol", rol);

                                if ("Administrador".equalsIgnoreCase(rol)) {
                                    response.sendRedirect("INCLUDE/header_administrador.jsp");
                                    return;
                                } else if ("Usuario".equalsIgnoreCase(rol)) {
                                    response.sendRedirect("INCLUDE/header_usuario.jsp");
                                    return;
                                } else {
                                    mensaje = "Rol desconocido.";
                                }
                            } else {
                                mensaje = "Usuario o contraseña incorrectos.";
                            }

                            rs.close();
                            ps.close();
                        }
                    } catch (Exception e) {
                        mensaje = " Error en la conexión: " + e.getMessage();
                        e.printStackTrace();
                    } finally {
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            }
        %>

        <% if (!mensaje.isEmpty()) { %>
            <div class="alert alert-danger" role="alert">
                <%= mensaje %>
            </div>
        <% } %>

        <form method="post" action="login.jsp">
            <div class="mb-3">
                <label for="username" class="form-label">Usuario</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-submit">Ingresar</button>
        </form>
        <a href="${pageContext.request.contextPath}/registrar.jsp" class="register-link">¿No tienes cuenta? Regístrate</a>
    </div>
</body>
</html>
