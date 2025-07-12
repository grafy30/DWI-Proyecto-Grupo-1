<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="INCLUDE/header_links.jsp" %>
<%
    BusinessEntify.PersonalBE personal = (BusinessEntify.PersonalBE) request.getAttribute("personal");
    if (personal == null) {
        personal = new BusinessEntify.PersonalBE();
    }
    boolean esEdicion = personal.getId_personal()> 0;
    String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title><%= esEdicion ? "Editar Personal" : "Registrar Personal" %></title>
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

        <h3 class="form-title"><%= esEdicion ? "Editar Personal" : "Registrar Nuevo Personal" %></h3>

        <form method="post" action="PersonalServlet" id="formularioPersonal" enctype="multipart/form-data">
            <input type="hidden" name="id_personal" value="<%= esEdicion ? personal.getId_personal(): "" %>">
            <input type="hidden" name="accion" value="<%= esEdicion ? "editar" : "registrar" %>">

            <div class="mb-3">
                <label for="nombres" class="form-label">Nombres del Personal</label>
                <input type="text" name="nombres" id="nombres" class="form-control"
                       value="<%= personal.getNombre_personal()!= null ? personal.getNombre_personal(): "" %>" required>
            </div>

            <div class="mb-3">
                <label for="nombre" class="form-label">Cargo</label>
                <input type="text" name="cargo" id="cargo" class="form-control"
                       value="<%= personal.getCargo_personal()!= null ? personal.getCargo_personal(): "" %>" required>
            </div>
            
            <div class="mb-3">
                <label for="nombre" class="form-label">Correo</label>
                <input type="text" name="correo" id="correo" class="form-control"
                       value="<%= personal.getCorreo_personal()!= null ? personal.getCorreo_personal(): "" %>" required>
            </div>
            
            <div class="mb-3">
                <label for="nombre" class="form-label">Telefono</label>
                <input type="text" name="telefono" id="telefono" class="form-control"
                       value="<%= personal.getTelefono_personal()!= null ? personal.getTelefono_personal(): "" %>" required>
            </div>

            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea name="descripcion" id="descripcion" class="form-control" rows="4" required><%= personal.getDescripcion() != null ? personal.getDescripcion() : "" %></textarea>
            </div>

            <div class="mb-3">
                <label for="imagen" class="form-label">Imagen</label>
                <input type="file" name="imagen" id="imagen" class="form-control" accept="image/*" <%= esEdicion ? "" : "required" %>>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-custom">
                    <%= esEdicion ? "Actualizar Personal" : "Registrar Personal" %>
                </button>
                <button type="button" onclick="limpiarFormulario()" class="btn btn-outline">🧹 Limpiar Datos</button>
                <a href="listar_personal.jsp" class="btn btn-outline">📋 Ver Personal</a>
            </div>
        </form>
    </div>
</div>

<script>
    function limpiarFormulario() {
        document.getElementById("formularioPersonal").reset();
        document.querySelector('input[name="id_personal"]').value = "";
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
