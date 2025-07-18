<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="INCLUDE/header_links.jsp" %>
<%@ page import="BusinessEntify.ServiciosBE" %>
<%
    ServiciosBE servicio = (ServiciosBE) request.getAttribute("servicio");
    if (servicio == null) {
        servicio = new ServiciosBE();
    }
    boolean esEdicion = servicio.getId_servicio() > 0;
    String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title><%= esEdicion ? "Editar Servicio" : "Registrar Servicio"%></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>

        <%@ include file="INCLUDE/header_administrador.jsp" %>

        <div class="container mt-4">
            <div class="form-card">

                <% if (mensaje != null) {%>
                <script>
                    Swal.fire({
                        icon: '<%= mensaje.toLowerCase().contains("error") ? "error" : "success"%>',
                        title: '<%= mensaje.replaceAll("✅|❌", "")%>',
                        showConfirmButton: false,
                        timer: 2000
                    });
                </script>
                <% }%>

                <h3 class="form-title"><%= esEdicion ? "Editar Servicio" : "Registrar Nuevo Servicio"%></h3>

                <form method="post" action="ServiciosServlet" id="formularioServicio" enctype="multipart/form-data">
                    <input type="hidden" name="id_servicio" value="<%= esEdicion ? servicio.getId_servicio() : ""%>">
                    <input type="hidden" name="accion" value="<%= esEdicion ? "editar" : "registrar"%>">

                    <div class="mb-3">
                        <label for="categoria" class="form-label">ID de Categoría</label>
                        <input type="number" name="id_categoria" id="categoria" class="form-control" placeholder="Id Categoria"
                               value="<%= servicio.getId_categoria() > 0 ? servicio.getId_categoria() : ""%>" required>
                    </div>

                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre del Servicio</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" placeholder="Nombre del Servicio"
                               value="<%= servicio.getNombre_servicio()!= null ? servicio.getNombre_servicio(): ""%>" required>
                    </div>

                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <textarea name="descripcion" id="descripcion" class="form-control" placeholder="Descripcion" rows="4" required><%= servicio.getDescripcion() != null ? servicio.getDescripcion() : ""%></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="precio" class="form-label">Precio Base</label>
                        <input type="number" step="0.01" name="precio_base" id="precio" class="form-control" placeholder="Precio Base"
                               value="<%= servicio.getPrecio_base()> 0 ? servicio.getPrecio_base() : ""%>" required>
                    </div>

                    <div class="mb-3">
                        <label for="duracion" class="form-label">Duración Estimada (días)</label>
                        <input type="number" name="duracion_estimada" id="duracion" class="form-control" placeholder="Duracion"
                               value="<%= servicio.getDuracion_estimada() > 0 ? servicio.getDuracion_estimada() : ""%>" required>
                    </div>

                    <div class="mb-3">
                        <label for="imagen" class="form-label">Imagen</label>
                        <input type="file" name="imagen" id="imagen" class="form-control" accept="image/*" <%= esEdicion ? "" : "required"%>>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-custom">
                            <%= esEdicion ? "Actualizar Servicio" : "Registrar Servicio"%>
                        </button>
                        <button type="button" onclick="limpiarFormulario()" class="btn btn-outline">🧹 Limpiar Datos</button>
                        <a href="listar_servicios.jsp" class="btn btn-outline">📋 Ver Servicios</a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function limpiarFormulario() {
                document.getElementById("formularioServicio").reset();
                document.querySelector('input[name="id_servicio"]').value = "";
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>