<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="BusinessEntify.ClientesBE" %>
<%@ page import="BusinessLogic.ClientesBL" %>
<%
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;

    ClientesBL clienteBL = new ClientesBL();
    List<ClientesBE> clientes = clienteBL.ReadAll();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista Clientes</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <%@ include file="INCLUDE/header_administrador.jsp" %>
        <div class="container mt-4">
            <div class="form-card full-width">
                <div class="mb-4 d-flex justify-content-end gap-2">
                    <a href="${pageContext.request.contextPath}/registrar_clientes.jsp">
                        <button type="button" class="btn btn-success btn-custom btn-sm">
                            <i class="fas fa-plus"></i> Registrar
                        </button>
                    </a>
                    <a href="${pageContext.request.contextPath}/ListaClientesPDFServlet" target="_blank">
                        <button type="button" class="btn btn-warning btn-custom btn-sm">
                            <i class="fas fa-file-pdf"></i> Exportar a PDF
                        </button>
                    </a>
                </div>
                <h3 class="form-title">Lista de Clientes</h3>
                <div class="table-responsive">
                    <table class="tabla table table-striped table-hover align-middle text-center">
                        <thead>
                            <tr class="bg-success text-white">
                                <th>Nombres</th>
                                <th>Email</th>
                                <th>Empresa</th>
                                <th>Teléfono</th>
                                <th>Editar</th>
                                <th>Eliminar</th>
                            </tr>
                        </thead>
                        <tbody id="tablaClientes">
                            <% for (ClientesBE cliente : clientes) {
                                    int id = cliente.getId_cliente();
                            %>
                            <tr<%= id > 0 ? " id=\"fila-" + id + "\"" : ""%>>
                                <td><%= cliente.getNombres()%></td>
                                <td><%= cliente.getEmail()%></td>
                                <td><%= cliente.getEmpresa()%></td>
                                <td><%= cliente.getTelefono()%></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/ClienteServlet?id_cliente=<%= id%>">
                                        <button type="button" class="btn btn-success btn-custom btn-sm">
                                            <i class="fas fa-pen"></i> Editar
                                        </button>
                                    </a>
                                </td>
                                <td>
                                    <button type="button"
                                            class="btn btn-danger btn-custom btn-sm"
                                            onclick="confirmarEliminacion('<%= id%>')">
                                        <i class="fas fa-trash"></i> Eliminar
                                    </button>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>

                    </table>
                </div>
            </div>
        </div>
        <script>
            function confirmarEliminacion(idCliente) {
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
                        fetch('ClienteServlet', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            },
                            body: 'accion=eliminar&idCliente=' + encodeURIComponent(idCliente)
                        })
                                .then(response => response.text())
                                .then(data => {
                                    if (data.trim() === 'ok') {
                                        let fila = document.getElementById('fila-' + idCliente);
                                        if (fila)
                                            fila.remove();
                                        Swal.fire({
                                            icon: 'success',
                                            title: '¡Eliminado!',
                                            text: 'Cliente eliminado exitosamente.',
                                            timer: 1500,
                                            showConfirmButton: false
                                        });
                                    } else {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Error',
                                            text: 'No se pudo eliminar el cliente.',
                                        });
                                    }
                                })
                                .catch(err => {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Error',
                                        text: 'No se pudo conectar al servidor.',
                                    });
                                });
                    }
                });
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
