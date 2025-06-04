<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<%@ page import="BusinessEntify.UsuariosBE" %>
<%@ page import="BusinessLogic.UsuariosBL" %>
<%
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista Usuarios</title>                
        <%@ include file="INCLUDE/header_links.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            function confirmarEliminacion(idUsuario) {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: "No podrás revertir esto.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sí, eliminar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Crear y enviar un formulario oculto por POST
                        var form = document.createElement('form');
                        form.method = 'POST';
                        form.action = 'listar_usuarios.jsp';

                        var accion = document.createElement('input');
                        accion.type = 'hidden';
                        accion.name = 'accion';
                        accion.value = 'eliminar';
                        form.appendChild(accion);

                        var idField = document.createElement('input');
                        idField.type = 'hidden';
                        idField.name = 'idUsuario';
                        idField.value = idUsuario;
                        form.appendChild(idField);

                        document.body.appendChild(form);
                        form.submit();
                    }
                });
            }

        </script>
    </head>
    <body>
        <%@ include file="INCLUDE/header_administrador.jsp" %>
        <div class="container mt-4">
            <div class="form-card full-width">
                <div class="mb-4 d-grid gap-2 d-md-flex flex-column align-items-start">
                    <a href="${pageContext.request.contextPath}/registrar_usuarios.jsp" class="w-100 mb-2">
                        <button type="button" class="btn btn-custom w-100">Registrar</button>
                    </a>
                    <a href="${pageContext.request.contextPath}/ListaUsuariosPDFServlet" target="_blank" class="w-100">
                        <button type="button" class="btn btn-outline w-100">Exportar a PDF</button>
                    </a>
                </div>                                          
                <%
                    UsuariosBL usuarioBL = new UsuariosBL();
                    List<UsuariosBE> usuarios = usuarioBL.ReadAll();
                %>

                <h3 class="form-title">Lista de Usuarios</h3>
                <div class="table-responsive">
                    <table class="tabla table table-striped table-hover align-middle text-center">
                        <thead>
                            <tr class="bg-primary text-white">
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
                                    <button type="button" class="btn btn-danger btn-sm" onclick="confirmarEliminacion('<%= usuario.getId_usuario()%>')">Eliminar</button>                                  
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <%
            if ("POST".equals(request.getMethod()) && "eliminar".equals(request.getParameter("accion"))) {
                String idUsuario = request.getParameter("idUsuario");
                UsuariosBL usuarioBLs = new UsuariosBL();
                boolean isDeleted = usuarioBLs.Delete(idUsuario);

                if (isDeleted) {
                    response.sendRedirect(request.getContextPath() + "/listar_usuarios.jsp?eliminado=ok");
                } else {
                    out.println("<script>alert('❌ Error al eliminar el usuario.');</script>");
                }
            }
        %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>    

        <%
            String eliminado = request.getParameter("eliminado");
        %>
        <script>
                window.onload = function () {
                <% if ("ok".equals(eliminado)) { %>
                    Swal.fire({
                        icon: 'success',
                        title: '¡Eliminado!',
                        text: 'Usuario eliminado exitosamente.',
                        timer: 2000,
                        showConfirmButton: false
                    });
                <% }%>
                }
        </script>
    </body>
</html>
