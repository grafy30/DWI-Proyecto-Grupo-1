<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, BusinessEntify.ServiciosBE, BusinessLogic.ServiciosBL, Util.ImagenUtils" %>
<%
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;

    ServiciosBL serviciosBL = new ServiciosBL();
    List<ServiciosBE> lista = serviciosBL.ReadAll();  // Cambiado de listarServicios() a ReadAll()
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Administrar Servicios</title>
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
                    <a href="${pageContext.request.contextPath}/registrar_servicios.jsp">
                        <button type="button" class="btn btn-success btn-custom btn-sm">
                            <i class="fas fa-plus"></i> Registrar
                        </button>
                    </a>
                    <a href="${pageContext.request.contextPath}/ListaServiciosPDFServlet" target="_blank">
                        <button type="button" class="btn btn-warning btn-custom btn-sm">
                            <i class="fas fa-file-pdf"></i> Exportar a PDF
                        </button>
                    </a>
                </div>

                <h3 class="form-title">Lista de Servicios</h3>

                <div class="table-responsive">
                    <table class="tabla table table-striped table-hover align-middle text-center">
                        <thead>
                            <tr class="bg-success text-white">
                                <th>Categoría</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Precio Base</th>
                                <th>Duración (días)</th>
                                <th>Imagen</th>
                                <th>Editar</th>
                                <th>Eliminar</th>
                            </tr>
                        </thead>
                        <tbody id="tablaServicios">
                            <% for (ServiciosBE s : lista) {
                                    int id = s.getId_servicio();
                            %>
                            <tr<%= id > 0 ? " id=\"fila-" + id + "\"" : ""%>>
                                <td><%= s.getId_categoria()%></td>
                                <td><%= s.getNombre_servicio()%></td>
                                <td><%= s.getDescripcion()%></td>
                                <td>S/. <%= String.format("%.2f", s.getPrecio_base())%></td>
                                <td><%= s.getDuracion_estimada()%></td>
                                <td>
                                    <% if (s.getImagen() != null) {%>  
                                    <img src="data:image/png;base64,<%= ImagenUtils.toBase64(s.getImagen())%>" 
                                         alt="Imagen Servicio" width="60" height="60" style="object-fit: cover; border-radius: 6px;">
                                    <% } else { %>
                                    <span>Sin imagen</span>
                                    <% }%>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/ServicioServlet?id_servicio=<%= id%>">
                                        <button type="button" class="btn btn-success btn-custom btn-sm">
                                            <i class="fas fa-pen"></i> Editar
                                        </button>
                                    </a>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-custom btn-sm"
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
            function confirmarEliminacion(idServicio) {
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
                        fetch('ServicioServlet', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                            body: 'accion=eliminar&idServicio=' + encodeURIComponent(idServicio)
                        })
                                .then(response => response.text())
                                .then(data => {
                                    if (data.trim() === 'ok') {
                                        let fila = document.getElementById('fila-' + idServicio);
                                        if (fila)
                                            fila.remove();
                                        Swal.fire({
                                            icon: 'success',
                                            title: '¡Eliminado!',
                                            text: 'Servicio eliminado exitosamente.',
                                            timer: 1500,
                                            showConfirmButton: false
                                        });
                                    } else {
                                        Swal.fire({icon: 'error', title: 'Error', text: 'No se pudo eliminar el servicio.'});
                                    }
                                })
                                .catch(() => {
                                    Swal.fire({icon: 'error', title: 'Error', text: 'Error de conexión al servidor.'});
                                });
                    }
                });
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>