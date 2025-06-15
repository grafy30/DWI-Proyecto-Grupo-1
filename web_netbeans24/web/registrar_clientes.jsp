<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="INCLUDE/header_links.jsp" %>
<%
    BusinessEntify.ClientesBE cliente = (BusinessEntify.ClientesBE) request.getAttribute("cliente");
    if (cliente == null) {
        cliente = new BusinessEntify.ClientesBE();
    }
    boolean esEdicion = cliente.getId_cliente() > 0;
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title><%= esEdicion ? "Editar Cliente" : "Registrar Cliente"%></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <%@ include file="INCLUDE/header_administrador.jsp" %>
        <div class="container mt-4">
            <div class="form-card">
                <% String mensaje = (String) request.getAttribute("mensaje"); %>
                <% if (mensaje != null) {%>
                <script>
                    Swal.fire({
                        icon: '<%= mensaje.toLowerCase().contains("error") || mensaje.toLowerCase().contains("hubo") ? "error" : "success"%>',
                        title: '<%= mensaje.replaceAll("✅|❌", "")%>',
                        showConfirmButton: false,
                        timer: 2000
                    });
                </script>
                <% }%>
                <h3 class="form-title"><%= esEdicion ? "Editar Cliente" : "Registrar Nuevo Cliente"%></h3>
                <form method="post" action="ClienteServlet" id="formularioCliente">
                    <input type="hidden" name="id_cliente" value="<%= cliente.getId_cliente() > 0 ? cliente.getId_cliente() : ""%>">
                    <input type="hidden" name="id_usuario" value="<%= cliente.getId_usuario() > 0 ? cliente.getId_usuario() : ""%>">
                    <input type="hidden" name="accion" value="<%= esEdicion ? "editar" : "registrar"%>">

                    <!-- SOLO LECTURA: Info básica -->
                    <div class="mb-3">
                        <label class="form-label">Nombres</label>
                        <input type="text" class="form-control" value="<%= cliente.getNombres() != null ? cliente.getNombres() : ""%>" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" value="<%= cliente.getEmail() != null ? cliente.getEmail() : ""%>" readonly>
                    </div>

                    <!-- EDITABLES -->
                    <div class="mb-3">
                        <label for="empresa" class="form-label">Empresa</label>
                        <input type="text" name="empresa" id="empresa" class="form-control"
                               value="<%= cliente.getEmpresa() != null ? cliente.getEmpresa() : ""%>" required>
                    </div>
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección</label>
                        <input type="text" name="direccion" id="direccion" class="form-control"
                               value="<%= cliente.getDireccion() != null ? cliente.getDireccion() : ""%>" required>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="text" name="telefono" id="telefono" class="form-control"
                               value="<%= cliente.getTelefono() != null ? cliente.getTelefono() : ""%>" required>
                    </div>
                    <div class="mb-3">
                        <label for="tipo_cliente" class="form-label">Tipo de Cliente</label>
                        <select name="tipo_cliente" id="tipo_cliente" class="form-select" required>
                            <option value="Nuevo" <%= "Nuevo".equals(cliente.getTipo_cliente()) ? "selected" : ""%>>Nuevo</option>
                            <option value="Frecuente" <%= "Frecuente".equals(cliente.getTipo_cliente()) ? "selected" : ""%>>Frecuente</option>
                            <option value="Premium" <%= "Premium".equals(cliente.getTipo_cliente()) ? "selected" : ""%>>Premium</option>
                        </select>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-custom">
                            <%= esEdicion ? "Actualizar Cliente" : "Registrar Cliente"%>
                        </button>
                        <button type="button" onclick="limpiarFormulario()" class="btn btn-outline">🧹 Limpiar Datos</button>
                        <a href="listar_clientes.jsp" class="btn btn-outline">👥 Ver Clientes</a>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function limpiarFormulario() {
                document.getElementById("formularioCliente").reset();
                document.querySelector('input[name="id_cliente"]').value = "";
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
