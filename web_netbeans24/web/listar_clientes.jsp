<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="BusinessEntify.ClientesBE" %>
<%@ page import="BusinessLogic.ClientesBL" %>
<%
    // Para seguridad, solo usuarios logueados deberían ver esto
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;
    // Listado de clientes
    ClientesBL clientesBL = new ClientesBL();
    List<ClientesBE> clientes = clientesBL.ReadAll();
    String mensaje = request.getParameter("mensaje");
    String eliminado = request.getParameter("eliminado");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista de Clientes</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            .form-card {
                background: white;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.05);
                max-width: 1000px;
                width: 100%;
                margin: 0 auto;
            }
            .form-title {
                font-weight: 600;
                margin-bottom: 30px;
                color: #2c3e50;
                text-align: center;
            }
            .acciones-btns {
                display: flex;
                gap: 0.4rem;
            }
            .acciones-btns .btn {
                min-width: 95px;
                font-size: 0.96rem;
            }
            @media (max-width: 768px) {
                .form-card { padding: 15px; }
                .acciones-btns .btn { min-width: 75px; font-size: 0.92rem; padding: 6px 8px;}
            }
        </style>
        <script>
            function confirmarEliminacion(id_cliente) {
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
                        form.action = 'ClienteServlet';

                        var accion = document.createElement('input');
                        accion.type = 'hidden';
                        accion.name = 'accion';
                        accion.value = 'eliminar';
                        form.appendChild(accion);

                        var idField = document.createElement('input');
                        idField.type = 'hidden';
                        idField.name = 'id_cliente';
                        idField.value = id_cliente;
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
                    <a href="ClienteServlet" class="w-100 mb-2">
                        <button type="button" class="btn btn-custom w-100">Registrar</button>
                    </a>
                    <a href="ListaClientesPDFServlet" target="_blank" class="w-100">
                        <button type="button" class="btn btn-outline w-100">Exportar a PDF</button>
                    </a>
                </div>
                <h3 class="form-title">Lista de Clientes</h3>
                <div class="table-responsive">
                    <table class="tabla table table-striped table-hover align-middle text-center">
                        <thead>
                            <tr class="bg-primary text-white">
                                <th>ID</th>
                                <th>Teléfono</th>
                                <th>Dirección</th>
                                <th>Empresa</th>
                                <th>Tipo</th>
                                <th>Editar</th>
                                <th>Eliminar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (clientes != null && !clientes.isEmpty()) {
                                for (ClientesBE c : clientes) { %>
                            <tr>
                                <td><%= c.getId_cliente() %></td>
                                <td><%= c.getTelefono() %></td>
                                <td><%= c.getDireccion() %></td>
                                <td><%= c.getEmpresa() %></td>
                                <td><%= c.getTipo() %></td>
                                <td>
                                    <a href="ClienteServlet?id_cliente=<%= c.getId_cliente() %>" class="btn btn-primary btn-sm w-100">
                                        <i class="fa fa-pencil fa-fw"></i> Editar
                                    </a>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-sm w-100" onclick="confirmarEliminacion('<%= c.getId_cliente() %>')">
                                        <i class="fa fa-trash fa-fw"></i> Eliminar
                                    </button>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="7" class="text-center text-muted">No hay clientes registrados.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            window.onload = function () {
                <% if ("ok".equals(eliminado)) { %>
                    Swal.fire({
                        icon: 'success',
                        title: '¡Eliminado!',
                        text: 'Cliente eliminado exitosamente.',
                        timer: 2000,
                        showConfirmButton: false
                    });
                <% } else if ("error".equals(eliminado)) { %>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No se pudo eliminar el cliente.',
                        timer: 2500,
                        showConfirmButton: false
                    });
                <% } else if ("registrado".equals(mensaje)) { %>
                    Swal.fire({
                        icon: 'success',
                        title: '¡Registrado!',
                        text: 'Cliente registrado exitosamente.',
                        timer: 2000,
                        showConfirmButton: false
                    });
                <% } else if ("editado".equals(mensaje)) { %>
                    Swal.fire({
                        icon: 'info',
                        title: 'Actualizado',
                        text: 'Cliente actualizado correctamente.',
                        timer: 2000,
                        showConfirmButton: false
                    });
                <% } %>
            }
        </script>
    </body>
</html>
