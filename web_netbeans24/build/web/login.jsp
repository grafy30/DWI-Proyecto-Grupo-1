<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, DataAccessObject.ConexionMySQL" %>
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
                                    mensaje = "No se pudo conectar a la base de datos.";
                                } else {
                                    // Cambia los nombres de columnas y tabla según tu BD
                                    String sql = "SELECT id_usuario, rol FROM usuarios WHERE nickname = ? AND password = ?";
                                    System.out.println("SQL: SELECT * FROM usuarios WHERE nickname=? AND password=?");
                                    System.out.println("Nickname recibido: " + username);
                                    System.out.println("Password recibido: " + password);
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, username);
                                    ps.setString(2, password);
                                    ResultSet rs = ps.executeQuery();

                                    if (rs.next()) {
                                        int id_usuario = rs.getInt("id_usuario");
                                        String rol = rs.getString("rol");

                                        HttpSession sesion = request.getSession();
                                        sesion.setAttribute("id_usuario", id_usuario); // <-- Usa este nombre
                                        sesion.setAttribute("rol", rol);

                                        if ("Administrador".equalsIgnoreCase(rol)) {
                                            response.sendRedirect("welcome_administrador.jsp");
                                            return;
                                        } else if ("Usuario".equalsIgnoreCase(rol) || "Cliente".equalsIgnoreCase(rol)) {
                                            response.sendRedirect("welcome_usuario.jsp"); // Cambia según tu flujo
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
                                mensaje = "Error en la conexión: " + e.getMessage();
                                e.printStackTrace();
                            } finally {
                                if (conn != null) try {
                                    conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                %> 

                <% if (!mensaje.isEmpty()) {%>
                <div class="alert alert-danger" role="alert">
                    <%= mensaje%>
                </div>
                <% }%>

                <form method="post" action="LoginServlet">
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
                <a href="registrar_cliente_publico.jsp" class="register-link">¿No tienes cuenta? Regístrate</a>
            </div>
        </div>                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="INCLUDE/footer.jsp" %>
    </body>
</html>
