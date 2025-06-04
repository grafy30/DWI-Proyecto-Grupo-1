<%@page import="BusinessEntify.ClientesBE"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ClientesBE cliente = (ClientesBE) request.getAttribute("cliente");
    if (cliente == null) cliente = new ClientesBE();
    String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title><%= (cliente.getId_cliente() != 0) ? "Editar Cliente" : "Registrar Cliente" %></title>
    <%@ include file="INCLUDE/header_links.jsp" %>
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
                        icon: '<%= mensaje.contains("Error") ? "error" : "success" %>',
                        title: '<%= mensaje.contains("Error") ? "Error" : "¡Éxito!" %>',
                        text: '<%= mensaje %>',
                        timer: 2200,
                        showConfirmButton: false
                    });
                </script>
            <% } %>
            <h3 class="form-title">
                <%= (cliente.getId_cliente() != 0) ? "Editar Cliente" : "Registrar Nuevo Cliente" %>
            </h3>
            <form method="post" action="ClienteServlet" id="formularioCliente">
                <input type="hidden" name="id_cliente" value="<%= cliente.getId_cliente() != 0 ? cliente.getId_cliente() : "" %>">
                <input type="hidden" name="accion" value="<%= (cliente.getId_cliente() != 0) ? "editar" : "registrar" %>">

                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono</label>
                    <input type="text" name="telefono" id="telefono" class="form-control"
                           value="<%= cliente.getTelefono() != null ? cliente.getTelefono() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección</label>
                    <textarea name="direccion" id="direccion" class="form-control" rows="2" required><%= cliente.getDireccion() != null ? cliente.getDireccion() : "" %></textarea>
                </div>
                <div class="mb-3">
                    <label for="empresa" class="form-label">Empresa</label>
                    <input type="text" name="empresa" id="empresa" class="form-control"
                           value="<%= cliente.getEmpresa() != null ? cliente.getEmpresa() : "" %>" required>
                </div>
                <div class="mb-4">
                    <label for="tipo" class="form-label">Tipo</label>
                    <select name="tipo" id="tipo" class="form-select" required>
                        <option value="">Seleccione un tipo</option>
                        <option value="Frecuente" <%= "Frecuente".equals(cliente.getTipo()) ? "selected" : "" %>>Frecuente</option>
                        <option value="Nuevo" <%= "Nuevo".equals(cliente.getTipo()) ? "selected" : "" %>>Nuevo</option>
                        <option value="Premium" <%= "Premium".equals(cliente.getTipo()) ? "selected" : "" %>>Premium</option>
                    </select>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-custom">
                        <%= (cliente.getId_cliente() != 0) ? "Actualizar Cliente" : "Registrar Cliente" %>
                    </button>
                    <button type="button" onclick="limpiarFormulario()" class="btn btn-outline">
                        🧹 Limpiar Datos
                    </button>
                    <a href="listar_clientes.jsp" class="btn btn-outline">
                        <i class="fa fa-users"></i> Ver Clientes
                    </a>
                </div>
            </form>
        </div>
    </div>
    <script>
        function limpiarFormulario() {
            document.getElementById("formularioCliente").reset();
            // También borramos el id_cliente si estamos limpiando para nuevo registro
            document.querySelector('input[name="id_cliente"]').value = "";
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
