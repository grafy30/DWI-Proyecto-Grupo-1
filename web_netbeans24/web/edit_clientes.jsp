<%@page import="BusinessEntify.ClientesBE"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BusinessLogic.ClientesBL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;
    
    ClientesBL cli = new ClientesBL();
    String accion = request.getParameter("accion");
    String idParam = request.getParameter("code");
    String mensaje = "";
    ClientesBE row = new ClientesBE();
    boolean esEdicion = false;

    // 1. Tomar el id_usuario de la sesión
    Integer id_usuario = (Integer) session.getAttribute("id_usuario");

    // Si no hay usuario logueado, bloquear operaciones
    if (id_usuario == null) {
        mensaje = "Error: Debe iniciar sesión para gestionar clientes.";
    } else {
        // Lógica para cargar datos en edición
        if ("UPDATE".equals(accion) && idParam != null && !idParam.isEmpty()) {
            row = cli.Read(idParam);
            esEdicion = true;
        }

        // Procesar el guardado de datos (crear o editar)
        if ("SAVE".equals(accion)) {
            ClientesBE cliente = new ClientesBE();
            if ("UPDATE".equals(request.getParameter("original_accion"))) {
                cliente.setId_cliente(Integer.parseInt(request.getParameter("id")));
            }

            // Asignar el id_usuario siempre desde la sesión (clave)
            cliente.setId_usuario(id_usuario);

            cliente.setTelefono(request.getParameter("telefono"));
            cliente.setDireccion(request.getParameter("direccion"));
            cliente.setEmpresa(request.getParameter("empresa"));
            cliente.setTipo(request.getParameter("tipo"));

            if ("NEW".equals(request.getParameter("original_accion"))) {
                if (cli.Create(cliente)) {
                    mensaje = "Cliente creado correctamente.";
                } else {
                    mensaje = "Error al crear cliente.";
                }
            } else if ("UPDATE".equals(request.getParameter("original_accion"))) {
                if (cli.Update(cliente)) {
                    mensaje = "Cliente actualizado correctamente.";
                } else {
                    mensaje = "Error al actualizar cliente.";
                }
            }
            // Limpiar el formulario después de guardar
            row = new ClientesBE();
            esEdicion = false;
        }
    }

    // Lista de todos los clientes para mostrar en tabla
    ArrayList<ClientesBE> listaClientes = cli.ReadAll();

    String titulo = esEdicion ? "Editar Cliente" : "Nuevo Cliente";
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Gestión de Clientes</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
    </head>
    <body>
        <%@ include file="INCLUDE/header_administrador.jsp" %>

        <section class="clientes-form container mt-4 mb-5">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center mt-2"><%= titulo%></h3>
                </div>
                <div class="card-body">
                    <% if (!mensaje.isEmpty()) {%>
                    <div class="alert <%= mensaje.contains("Error") ? "alert-danger" : "alert-success"%>">
                        <%= mensaje%>
                    </div>
                    <% } %>
                    <% if (id_usuario != null) {%>
                    <form method="post" action="edit_clientes.jsp">
                        <input type="hidden" name="original_accion" value="<%= esEdicion ? "UPDATE" : "NEW"%>">
                        <input type="hidden" name="accion" value="SAVE">

                        <% if (esEdicion) {%>
                        <div class="form-group mb-3">
                            <label for="id" class="form-label">ID Cliente</label>
                            <input type="text" class="form-control" id="id" name="id" placeholder="ID Cliente"
                                   value="<%= row.getId_cliente()%>" readonly>
                        </div>
                        <% }%>

                        <div class="form-group mb-3">
                            <label for="telefono" class="form-label">Teléfono</label>
                            <input type="text" class="form-control" id="telefono" name="telefono" placeholder="telefono"
                                   value="<%= row.getTelefono() != null ? row.getTelefono() : ""%>" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="direccion" class="form-label">Dirección</label>
                            <textarea class="form-control" id="direccion" name="direccion" placeholder="direccion" rows="2" required><%= row.getDireccion() != null ? row.getDireccion() : ""%></textarea>
                        </div>
                        <div class="form-group mb-3">
                            <label for="empresa" class="form-label">Empresa</label>
                            <input type="text" class="form-control" id="empresa" name="empresa" placeholder="empresa"
                                   value="<%= row.getEmpresa() != null ? row.getEmpresa() : ""%>" required>
                        </div>
                        <div class="form-group mb-4">
                            <label for="tipo" class="form-label">Tipo de Cliente</label>
                            <select class="form-select" id="tipo" name="tipo" required>
                                <option value="">Seleccione un tipo</option>
                                <option value="Frecuente" <%= "Frecuente".equals(row.getTipo()) ? "selected" : ""%>>Frecuente</option>
                                <option value="Nuevo" <%= "Nuevo".equals(row.getTipo()) ? "selected" : ""%>>Nuevo</option>
                                <option value="Premium" <%= "Premium".equals(row.getTipo()) ? "selected" : ""%>>Premium</option>
                            </select>
                        </div>
                        <div class="d-flex justify-content-between">
                            <a href="edit_clientes.jsp" class="btn btn-secondary">
                                <i class="fa fa-eraser fa-fw"></i> Limpiar
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="fa fa-save fa-fw"></i> Guardar
                            </button>
                        </div>
                    </form>
                    <% } %>
                </div>
            </div>
        </section>

        <!-- Tabla de Clientes -->
        <section class="clientes-lista container mb-5">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center align-middle mt-2">Clientes Registrados</h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead class="thead-dark">
                                <tr class="text-center align-middle">
                                    <th scope="col">ID Cliente</th>
                                    <th scope="col">Teléfono</th>
                                    <th scope="col">Dirección</th>
                                    <th scope="col">Empresa</th>
                                    <th scope="col">Tipo Cliente</th>
                                    <th scope="col">Editar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (listaClientes != null && !listaClientes.isEmpty()) {
                                        for (ClientesBE c : listaClientes) {%>
                                <tr class="text-center align-middle">
                                    <td><%= c.getId_cliente()%></td>
                                    <td><%= c.getTelefono()%></td>
                                    <td><%= c.getDireccion()%></td>
                                    <td><%= c.getEmpresa()%></td>
                                    <td><%= c.getTipo()%></td>
                                    <td>
                                        <a class="btn btn-success btn-sm" href="edit_clientes.jsp?accion=UPDATE&code=<%= c.getId_cliente()%>">
                                            <i class="fa fa-pencil fa-fw"></i>
                                        </a>
                                    </td>
                                </tr>
                                <% }
                                } else { %>
                                <tr>
                                    <td colspan="6" class="text-center text-muted">No hay clientes registrados.</td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
