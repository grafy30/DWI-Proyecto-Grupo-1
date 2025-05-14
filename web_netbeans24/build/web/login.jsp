
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, DataAccessObject.ConexionMySQL" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Arqui Peru-Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="apple-touch-icon" sizes="180x180" href="imagenes/favicon_io/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="imagenes/favicon_io/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="imagenes/favicon_io/favicon-16x16.png">
    <link rel="manifest" href="/site.webmanifest">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="INCLUDE/header.jsp" %>
    <div class="form-container">
        <div class="card-form">
            <h3 class="text-center mb-4">Iniciar Sesión</h3>

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
    </div>    
    <%@ include file="INCLUDE/footer.jsp" %>
</body>
</html>
