<%@page import="DataAccessObject.VentaContratoDAO"%>
<%@page import="DataAccessObject.ServiciosClienteDAO"%>
<%@page import="BusinessEntify.ServiciosBE"%>
<%@page import="BusinessLogic.ServiciosBL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String idVentaStr = request.getParameter("idVenta");
    String idServicioClienteStr = request.getParameter("idServicioCliente");

    if (idVentaStr == null || idServicioClienteStr == null) {
        response.sendRedirect("servicios.jsp");
        return;
    }

    try {
        int idVenta = Integer.parseInt(idVentaStr);
        int idServicioCliente = Integer.parseInt(idServicioClienteStr);

        // Obtener información de la venta y servicio
        VentaContratoDAO ventaDAO = new VentaContratoDAO();
        ServiciosClienteDAO scDAO = new ServiciosClienteDAO();
        ServiciosBL serviciosBL = new ServiciosBL();

        // Aquí deberías implementar métodos para obtener estos objetos
        Object venta = ventaDAO.obtenerVentaPorId(idVenta);
        Object servicioCliente = scDAO.obtenerServicioClientePorId(idServicioCliente);
        ServiciosBE servicio = serviciosBL.Read(String.valueOf(scDAO.obtenerIdServicio(idServicioCliente)));

        request.setAttribute("venta", venta);
        request.setAttribute("servicioCliente", servicioCliente);
        request.setAttribute("servicio", servicio);

    } catch (Exception e) {
        request.setAttribute("error", "Error al cargar datos de pago: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proceso de Pago - Consultoría Arquitectónica</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
        <style>
            .payment-card {
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: all 0.3s;
            }
            .payment-card:hover {
                box-shadow: 0 8px 16px rgba(0,0,0,0.1);
                transform: translateY(-2px);
            }
            .payment-card.selected {
                border: 2px solid #3498db;
                background-color: #f8f9fa;
            }
            .payment-icon {
                font-size: 2rem;
                margin-bottom: 1rem;
            }
            .summary-item {
                border-bottom: 1px solid #eee;
                padding: 0.75rem 0;
            }
        </style>
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>

        <div class="container py-5">
            <div class="row">
                <div class="col-lg-8">
                    <h2 class="mb-4">Método de Pago</h2>

                    <form id="paymentForm" action="ProcesarPago" method="post">
                        <input type="hidden" name="idVenta" value="${param.idVenta}">
                        <input type="hidden" name="idServicioCliente" value="${param.idServicioCliente}">

                        <div class="row">
                            <!-- Tarjeta de crédito -->
                            <div class="col-md-6 mb-4">
                                <div class="card payment-card h-100" onclick="selectPayment('tarjeta')">
                                    <div class="card-body text-center">
                                        <div class="payment-icon text-primary">
                                            <i class="far fa-credit-card"></i>
                                        </div>
                                        <h5>Tarjeta de Crédito/Débito</h5>
                                        <p class="text-muted small">Pago seguro con tarjeta</p>
                                        <div class="form-check d-flex justify-content-center">
                                            <input class="form-check-input" type="radio" name="metodoPago" 
                                                   id="tarjetaRadio" value="Tarjeta" required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Transferencia bancaria -->
                            <div class="col-md-6 mb-4">
                                <div class="card payment-card h-100" onclick="selectPayment('transferencia')">
                                    <div class="card-body text-center">
                                        <div class="payment-icon text-success">
                                            <i class="fas fa-university"></i>
                                        </div>
                                        <h5>Transferencia Bancaria</h5>
                                        <p class="text-muted small">Transferencia directa a nuestra cuenta</p>
                                        <div class="form-check d-flex justify-content-center">
                                            <input class="form-check-input" type="radio" name="metodoPago" 
                                                   id="transferenciaRadio" value="Transferencia">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Detalles de tarjeta (mostrar solo cuando se seleccione) -->
                        <div id="cardDetails" class="mb-4" style="display: none;">
                            <h4 class="mb-3">Información de Tarjeta</h4>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="cardNumber" class="form-label">Número de Tarjeta</label>
                                    <input type="text" class="form-control" id="cardNumber" name="cardNumber" 
                                           placeholder="1234 5678 9012 3456">
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label for="cardExpiry" class="form-label">Expiración</label>
                                    <input type="text" class="form-control" id="cardExpiry" name="cardExpiry" 
                                           placeholder="MM/AA">
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label for="cardCvc" class="form-label">CVC</label>
                                    <input type="text" class="form-control" id="cardCvc" name="cardCvc" 
                                           placeholder="123">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="cardName" class="form-label">Nombre en la Tarjeta</label>
                                <input type="text" class="form-control" id="cardName" name="cardName" 
                                       placeholder="Nombre como aparece en la tarjeta">
                            </div>
                        </div>

                        <!-- Detalles de transferencia (mostrar solo cuando se seleccione) -->
                        <div id="transferDetails" class="mb-4" style="display: none;">
                            <h4 class="mb-3">Información para Transferencia</h4>
                            <div class="alert alert-info">
                                <h5><i class="fas fa-info-circle"></i> Datos Bancarios</h5>
                                <p class="mb-1"><strong>Banco:</strong> Banco de Ejemplo</p>
                                <p class="mb-1"><strong>Cuenta:</strong> 123-456-789</p>
                                <p class="mb-1"><strong>CLABE:</strong> 012345678901234567</p>
                                <p class="mb-1"><strong>Beneficiario:</strong> Consultoría Arquitectónica SA de CV</p>
                                <p class="mb-1"><strong>Referencia:</strong> CONTRATO-${param.idVenta}</p>
                            </div>
                            <div class="mb-3">
                                <label for="comprobante" class="form-label">Subir Comprobante</label>
                                <input type="file" class="form-control" id="comprobante" name="comprobante">
                            </div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-lock me-2"></i> Confirmar Pago
                            </button>
                        </div>
                    </form>
                </div>

                <div class="col-lg-4">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white">
                            <h4 class="mb-0">Resumen del Contrato</h4>
                        </div>
                        <div class="card-body">
                            <div class="summary-item">
                                <h5>${servicio.nombre_servicio}</h5>
                                <p class="text-muted mb-0">${servicio.descripcion}</p>
                            </div>

                            <div class="summary-item">
                                <div class="d-flex justify-content-between">
                                    <span>Subtotal:</span>
                                    <span>S/. <fmt:formatNumber value="${servicio.precio_base}" pattern="#,##0.00"/></span>
                                </div>
                            </div>

                            <div class="summary-item">
                                <div class="d-flex justify-content-between">
                                    <span>IGV (18%):</span>
                                    <span>S/. <fmt:formatNumber value="${servicio.precio_base * 0.18}" pattern="#,##0.00"/></span>
                                </div>
                            </div>

                            <div class="summary-item">
                                <div class="d-flex justify-content-between fw-bold fs-5">
                                    <span>Total a pagar:</span>
                                    <span class="text-success">S/. <fmt:formatNumber value="${servicio.precio_base * 1.18}" pattern="#,##0.00"/></span>
                                </div>
                            </div>

                            <div class="alert alert-success mt-3">
                                <i class="fas fa-info-circle me-2"></i>
                                Este pago corresponde al 50% del valor total como anticipo.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="INCLUDE/footer.jsp" %>

        <script>
            // Selección de método de pago
            function selectPayment(method) {
                // Marcar el radio button correspondiente
                document.getElementById(method + 'Radio').checked = true;

                // Mostrar/ocultar detalles según el método
                if (method === 'tarjeta') {
                    document.getElementById('cardDetails').style.display = 'block';
                    document.getElementById('transferDetails').style.display = 'none';
                } else if (method === 'transferencia') {
                    document.getElementById('cardDetails').style.display = 'none';
                    document.getElementById('transferDetails').style.display = 'block';
                }

                // Resaltar la tarjeta seleccionada
                document.querySelectorAll('.payment-card').forEach(card => {
                    card.classList.remove('selected');
                });
                event.currentTarget.classList.add('selected');
            }

            // Validación del formulario antes de enviar
            document.getElementById('paymentForm').addEventListener('submit', function (e) {
                const metodoPago = document.querySelector('input[name="metodoPago"]:checked');

                if (!metodoPago) {
                    e.preventDefault();
                    alert('Por favor seleccione un método de pago');
                    return false;
                }

                if (metodoPago.value === 'Tarjeta') {
                    const cardNumber = document.getElementById('cardNumber').value;
                    const cardExpiry = document.getElementById('cardExpiry').value;
                    const cardCvc = document.getElementById('cardCvc').value;

                    if (!cardNumber || !cardExpiry || !cardCvc) {
                        e.preventDefault();
                        alert('Por favor complete todos los datos de la tarjeta');
                        return false;
                    }
                }

                return true;
            });
        </script>
    </body>
</html>