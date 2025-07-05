<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="BusinessEntify.ContactosBE" %>
<%@ page import="BusinessLogic.ContactosBL" %>
<%
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;

    ContactosBL contactoBL = new ContactosBL();
    List<ContactosBE> contactos = contactoBL.ReadAll();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Solicitudes de Contacto</title>
    <%@ include file="INCLUDE/header_links.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <%@ include file="INCLUDE/header_administrador.jsp" %>

    <div class="container mt-4">
        <div class="form-card full-width">
            <h3 class="form-title mb-4">Solicitudes de Contacto</h3>
            <div class="table-responsive">
                <table class="tabla table table-striped table-hover align-middle text-center">
                    <thead>
                        <tr class="bg-primary text-white">
                            <th>Nombre</th>
                            <th>Correo</th>
                            <th>Mensaje</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Revisar</th>
                            <th>Eliminar</th>
                        </tr>
                    </thead>
                    <tbody id="tablaSolicitudes">
                    <% for (ContactosBE contacto : contactos) { %>
                        <tr id="fila-<%= contacto.getId_contacto() %>">
                            <td><%= contacto.getNombre() %></td>
                            <td><%= contacto.getCorreo() %></td>
                            <td><%= contacto.getMensaje() %></td>
                            <td><%= contacto.getFecha_contacto() %></td>
                            <td>
                                <% if ("Atendido".equalsIgnoreCase(contacto.getEstado())) { %>
                                    <span class="badge bg-success">Atendido</span>
                                <% } else { %>
                                    <span class="badge bg-warning text-dark">Pendiente</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/RevisarContactoServlet?id_contacto=<%= contacto.getId_contacto()%>">
                                    <button class="btn btn-info btn-sm">
                                        <i class="fas fa-envelope-open-text"></i> Revisar
                                    </button>
                                </a>
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="eliminar(<%= contacto.getId_contacto() %>)">
                                    <i class="fas fa-trash-alt"></i> Eliminar
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function eliminar(id) {
            Swal.fire({
                title: '¿Eliminar solicitud?',
                text: 'Esta acción no se puede deshacer.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Sí, eliminar'
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch('ContactoServlet', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: 'accion=eliminar&idContacto=' + encodeURIComponent(id)
                    })
                    .then(res => res.text())
                    .then(data => {
                        if (data.trim() === 'ok') {
                            document.getElementById('fila-' + id).remove();
                            Swal.fire('Eliminado', '', 'success');
                        } else {
                            Swal.fire('Error', 'No se pudo eliminar.', 'error');
                        }
                    });
                }
            });
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
