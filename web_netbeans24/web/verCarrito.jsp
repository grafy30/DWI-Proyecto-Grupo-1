<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, BusinessEntify.ServiciosBE" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Carrito de Servicios</title>
    <%@ include file="INCLUDE/header_links.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%@ include file="INCLUDE/header.jsp" %>
<body class="bg-light">
<div class="container my-5">
    <h2 class="mb-4 text-center">Carrito de Servicios</h2>

    <%
        HttpSession sesion = request.getSession(false);
        Map<Integer, Integer> carrito = (sesion != null) ? (Map<Integer, Integer>) sesion.getAttribute("carrito") : null;
        List<ServiciosBE> serviciosDisponibles = (sesion != null) ? (List<ServiciosBE>) sesion.getAttribute("serviciosDisponibles") : null;

        if (carrito == null || carrito.isEmpty()) {
    %>
        <div class="alert alert-info text-center">
            Tu carrito está vacío. <a href="diseño.jsp" class="alert-link">Ir al catálogo</a>
        </div>
    <%
        } else {
    %>
        <div class="table-responsive">
            <table class="table table-bordered table-striped align-middle">
                <thead class="table-dark text-center">
                    <tr>
                        <th>Servicio</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    double total = 0.0;

                    for (Map.Entry<Integer, Integer> entry : carrito.entrySet()) {
                        int id = entry.getKey();
                        int cantidad = entry.getValue();
                        ServiciosBE servicioEncontrado = null;

                        if (serviciosDisponibles != null) {
                            for (ServiciosBE s : serviciosDisponibles) {
                                if (s.getId_servicio() == id) {
                                    servicioEncontrado = s;
                                    break;
                                }
                            }
                        }

                        if (servicioEncontrado != null) {
                            double precio = servicioEncontrado.getPrecio_base().doubleValue();
                            double subtotal = precio * cantidad;
                            total += subtotal;
                %>
                    <tr>
                        <td><%= servicioEncontrado.getNombre_servicio() %></td>
                        <td><%= servicioEncontrado.getDescripcion() %></td>
                        <td class="text-end">S/. <%= String.format("%.2f", precio) %></td>

                        <!-- Formulario para actualizar cantidad -->
                        <td class="text-center">
                            <form action="actualizarCantidad" method="post" class="d-flex justify-content-center gap-2">
                                <input type="hidden" name="servicioId" value="<%= id %>">
                                <input type="number" name="nuevaCantidad" value="<%= cantidad %>" min="1" class="form-control form-control-sm" style="width: 70px;" required>
                                <button type="submit" class="btn btn-sm btn-primary">Actualizar</button>
                            </form>
                        </td>

                        <td class="text-end">S/. <%= String.format("%.2f", subtotal) %></td>

                        <!-- Formulario para eliminar servicio -->
                        <td class="text-center">
                            <form action="eliminarDelCarrito" method="post">
                                <input type="hidden" name="servicioId" value="<%= id %>">
                                <button type="submit" class="btn btn-sm btn-danger" title="Eliminar una unidad">-1</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>
                <tfoot class="table-secondary">
                    <tr>
                        <th colspan="4" class="text-end">Total:</th>
                        <th class="text-end">S/. <%= String.format("%.2f", total) %></th>
                        <th></th>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="text-end mt-3">
            <a href="diseño.jsp" class="btn btn-outline-primary">Seguir contratando</a>
            <!-- Botón que abre el modal de confirmación -->
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#confirmModal">
                Finalizar contratación
            </button>
        </div>
    <%
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Modal 1: Confirmación -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="confirmModalLabel">Confirmar contratación</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body">
        ¿Estás seguro de que deseas finalizar la contratación de los servicios seleccionados?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-success" id="confirmarContratacionBtn">Sí, contratar</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal 2: Formulario de Pago con estilo y texto negro -->
<div class="modal fade" id="pagoModal" tabindex="-1" aria-labelledby="pagoModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form class="modal-content border border-success shadow-lg" action="FinalizarCompraServlet" method="post">
      
      <!-- Encabezado -->
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="pagoModalLabel">Datos de Pago</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      
      <!-- Cuerpo -->
      <div class="modal-body bg-light text-dark">
        <div class="mb-3">
          <label for="nombreTarjeta" class="form-label text-dark fw-semibold">Nombre completo del titular</label>
          <input type="text" class="form-control border-success" id="nombreTarjeta" name="nombreTarjeta" required>
        </div>
        <div class="mb-3">
          <label for="numeroTarjeta" class="form-label text-dark fw-semibold">Número de tarjeta</label>
          <input type="text" class="form-control border-success" id="numeroTarjeta" name="numeroTarjeta" maxlength="16" required>
        </div>
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="fechaExp" class="form-label text-dark fw-semibold">Fecha de expiración</label>
            <input type="month" class="form-control border-success" id="fechaExp" name="fechaExp" required>
          </div>
          <div class="col-md-6 mb-3">
            <label for="cvv" class="form-label text-dark fw-semibold">CVV</label>
            <input type="password" class="form-control border-success" id="cvv" name="cvv" maxlength="4" required>
          </div>
        </div>
      </div>
      
      <!-- Pie -->
      <div class="modal-footer bg-success-subtle">
        <button type="submit" class="btn btn-primary w-100 fw-bold">💳 Pagar y Finalizar</button>
      </div>
    </form>
  </div>
</div>

<!-- Script para manejar el flujo entre los modales -->
<script>
  document.getElementById('confirmarContratacionBtn').addEventListener('click', function() {
    const confirmModal = bootstrap.Modal.getInstance(document.getElementById('confirmModal'));
    confirmModal.hide(); // Oculta el modal de confirmación

    const pagoModal = new bootstrap.Modal(document.getElementById('pagoModal'));
    pagoModal.show(); // Muestra el modal de pago
  });
</script>

<%@ include file="INCLUDE/footer.jsp" %>
</body>
</html>