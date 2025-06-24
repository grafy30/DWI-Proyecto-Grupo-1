<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="INCLUDE/header_links.jsp" %>
<%
    BusinessEntify.ProyectosBE proyecto = (BusinessEntify.ProyectosBE) request.getAttribute("proyecto");
    if (proyecto == null) {
        proyecto = new BusinessEntify.ProyectosBE();
    }
    boolean esEdicion = proyecto.getId_proyecto() > 0;
    String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title><%= esEdicion ? "Editar Proyecto" : "Registrar Proyecto" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<%@ include file="INCLUDE/header_administrador.jsp" %>

<div class="container mt-4">
    <div class="form-card">

        <% if (mensaje != null) { %>
        <script>
            Swal.fire({
                icon: '<%= mensaje.toLowerCase().contains("error") ? "error" : "success" %>',
                title: '<%= mensaje.replaceAll("✅|❌", "") %>',
                showConfirmButton: false,
                timer: 2000
            });
        </script>
        <% } %>

        <h3 class="form-title"><%= esEdicion ? "Editar Proyecto" : "Registrar Nuevo Proyecto" %></h3>

        <form method="post" action="ProyectoServlet" id="formularioProyecto" enctype="multipart/form-data">
            <input type="hidden" name="id_proyecto" value="<%= esEdicion ? proyecto.getId_proyecto() : "" %>">
            <input type="hidden" name="accion" value="<%= esEdicion ? "editar" : "registrar" %>">

            <div class="mb-3">
                <label for="titulo" class="form-label">Título del Proyecto</label>
                <input type="text" name="titulo_proyecto" id="titulo" class="form-control"
                       value="<%= proyecto.getTitulo_proyecto() != null ? proyecto.getTitulo_proyecto() : "" %>" required>
            </div>

            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre del Proyecto</label>
                <input type="text" name="nombre_proyecto" id="nombre" class="form-control"
                       value="<%= proyecto.getNombre_proyecto() != null ? proyecto.getNombre_proyecto() : "" %>" required>
            </div>

            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea name="descripcion" id="descripcion" class="form-control" rows="4" required><%= proyecto.getDescripcion() != null ? proyecto.getDescripcion() : "" %></textarea>
            </div>

            <div class="mb-3">
                <label for="imagen" class="form-label">Imagen</label>
                <input type="file" name="imagen" id="imagen" class="form-control" accept="image/*" <%= esEdicion ? "" : "required" %>>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-custom">
                    <%= esEdicion ? "Actualizar Proyecto" : "Registrar Proyecto" %>
                </button>
                <button type="button" onclick="limpiarFormulario()" class="btn btn-outline">🧹 Limpiar Datos</button>
                <a href="listar_proyectos.jsp" class="btn btn-outline">📋 Ver Proyectos</a>
            </div>
        </form>
    </div>
</div>

<script>
    function limpiarFormulario() {
        document.getElementById("formularioProyecto").reset();
        document.querySelector('input[name="id_proyecto"]').value = "";
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
