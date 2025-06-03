<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<%@ page import="BusinessEntify.UsuariosBE" %>
<%@ page import="BusinessLogic.UsuariosBL" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista Usuarios</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vista_listar_roles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <%@ include file="INCLUDE/header_links.jsp" %>
    </head>
    <body>
        <div class="header">
            <%@ include file="INCLUDE/header_administrador.jsp" %>
        </div>

        <div class="contenedor">

            <div class="container w-100 pb-5">

                <div class="mb-3 d-grid gap-2 d-md-flex flex-column align-items-start">
                    <a href="${pageContext.request.contextPath}/registrar_usuarios.jsp">
                        <button type="button" class="btn btn-danger w-100">Registrar</button>
                    </a>
                    <a href="${pageContext.request.contextPath}/ListaUsuariosPDFServlet" target="_blank">
                        <button type="button" class="btn btn-primary w-100">Exportar a PDF</button>
                    </a>
                </div>


                <h2 class="text-center mb-4 text-light">Lista de Usuarios</h2>

                <%
                    UsuariosBL usuarioBL = new UsuariosBL();
                    List<UsuariosBE> usuarios = usuarioBL.obtenerTodosLosUsuarios();
                %>

                <table class="tabla table-striped table-hover">
                    <thead>
                        <tr class="bg-dark text-light">
                            <th>Usuario</th>
                            <th>Nombres</th>
                            <th>Rol</th>
                            <th>Editar</th>                            
                            <th>Eliminar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (UsuariosBE usuario : usuarios) {%>
                        <tr>
                            <td><%= usuario.getUsuario()%></td>
                            <td><%= usuario.getNombres()%></td>
                            <td><%= usuario.getRol()%></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/registrar_usuarios.jsp?id_usuario=<%= usuario.getId_usuario()%>" class="btn btn-primary btn-sm">Editar</a>
                            </td>
                            <td>
                                <form action="listar_roles.jsp" method="post">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idUsuario" value="<%= usuario.getId_usuario()%>">
                                    <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <%
            if ("POST".equals(request.getMethod()) && "eliminar".equals(request.getParameter("accion"))) {
                String idUsuario = request.getParameter("idUsuario");
                UsuariosBL usuarioBLs = new UsuariosBL();
                boolean isDeleted = usuarioBLs.eliminarUsuarioPorId(idUsuario);

                if (isDeleted) {
                    response.sendRedirect(request.getContextPath() + "/listar_roles.jsp");
                } else {
                    out.println("<script>alert('❌ Error al eliminar el usuario.');</script>");
                }
            }
        %>
    </body>
</html>
