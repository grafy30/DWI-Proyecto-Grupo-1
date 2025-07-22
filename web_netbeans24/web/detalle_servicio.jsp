<%@page import="BusinessEntify.ServiciosBE"%>
<%@page import="BusinessLogic.ServiciosBL"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String servicioId = request.getParameter("id");
    ServiciosBE servicio = null;

    if (servicioId != null && !servicioId.isEmpty()) {
        ServiciosBL serviciosBL = new ServiciosBL();
        servicio = serviciosBL.Read(servicioId);

        if (servicio != null && servicio.getImagen() != null) {
            try {
                java.awt.image.BufferedImage bufferedImage = new java.awt.image.BufferedImage(
                        servicio.getImagen().getIconWidth(),
                        servicio.getImagen().getIconHeight(),
                        java.awt.image.BufferedImage.TYPE_INT_RGB);

                bufferedImage.getGraphics().drawImage(servicio.getImagen().getImage(), 0, 0, null);

                java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream();
                javax.imageio.ImageIO.write(bufferedImage, "jpg", baos);
                String base64Image = Base64.getEncoder().encodeToString(baos.toByteArray());
                servicio.setImagenBase64(base64Image);
            } catch (Exception e) {
                System.out.println("Error al convertir imagen: " + e.getMessage());
            }
        }

        request.setAttribute("servicio", servicio);
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${servicio.nombre_servicio} - Consultoría Arquitectónica</title>        
        <%@ include file="INCLUDE/header_links.jsp" %>
        <style>
            .service-img {
                max-height: 500px;
                object-fit: cover;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .service-header {
                border-bottom: 2px solid #3498db;
                padding-bottom: 1rem;
                margin-bottom: 1.5rem;
            }
            .duration-badge {
                background-color: #3498db;
                color: white;
                font-size: 0.9rem;
            }
            .feature-icon {
                font-size: 1.5rem;
                color: #3498db;
                margin-bottom: 0.5rem;
            }
            .contract-form {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 2rem;
            }
            .related-service-card {
                transition: transform 0.3s;
            }
            .related-service-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
        </style>
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>

        <!-- Breadcrumb -->
        <div class="container mt-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Inicio</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/diseño.jsp">Servicios</a></li>
                    <li class="breadcrumb-item active">${servicio.nombre_servicio}</li>
                </ol>
            </nav>
        </div>

        <div class="container mt-4 mb-5">
            <!-- Detalles del Servicio -->
            <div class="row">
                <!-- Columna de imagen -->
                <div class="col-lg-6 mb-4">
                    <div class="text-center">
                        <c:choose>
                            <c:when test="${not empty servicio.imagenBase64}">
                                <img src="data:image/jpeg;base64,${servicio.imagenBase64}" 
                                     class="img-fluid service-img" 
                                     alt="${servicio.nombre_servicio}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/images/no-image.jpg" 
                                     class="img-fluid service-img" 
                                     alt="Imagen no disponible">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Características del servicio -->
                    <div class="mt-4">
                        <h4>Características</h4>
                        <div class="row mt-3">
                            <div class="col-md-6 mb-3">
                                <div class="text-center">
                                    <div class="feature-icon">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                    <h6>Duración</h6>
                                    <p class="text-muted">${servicio.duracion_estimada} días</p>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="text-center">
                                    <div class="feature-icon">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <h6>Precio Base</h6>
                                    <p class="text-muted">S/. <fmt:formatNumber value="${servicio.precio_base}" pattern="#,##0.00"/></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Columna de información -->
                <div class="col-lg-6">
                    <div class="service-header">
                        <h1 class="display-5 fw-bold">${servicio.nombre_servicio}</h1>
                        <div class="d-flex align-items-center mb-2">
                            <span class="badge duration-badge me-2">
                                <i class="fas fa-clock me-1"></i> ${servicio.duracion_estimada} días
                            </span>
                            <span class="text-success fw-bold fs-4">
                                S/. <fmt:formatNumber value="${servicio.precio_base}" pattern="#,##0.00"/>
                            </span>
                        </div>
                    </div>

                    <!-- Descripción -->
                    <div class="mb-4">
                        <h4>Descripción del Servicio</h4>
                        <p class="lead">${servicio.descripcion}</p>
                    </div>

                    <!-- Formulario de contratación -->
                    <div class="contract-form mt-4">
                        <h4 class="mb-3">Solicitar este servicio</h4>
                        <form id="contratarForm" action="${pageContext.request.contextPath}/ContratarServicio" method="post">
                            <input type="hidden" name="idServicio" value="${servicio.id_servicio}">

                            <div class="mb-3">
                                <label for="nombreCompleto" class="form-label">Nombre Completo</label>
                                <input type="text" class="form-control" id="nombreCompleto" placeholder="Nombres y Apellidos" name="nombreCompleto" required>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="email" placeholder="Correo Electrónico" name="email" required>
                            </div>

                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" id="telefono" placeholder="Teléfono" name="telefono" required>
                            </div>

                            <div class="mb-3">
                                <label for="fechaInicio" class="form-label">Fecha deseada de inicio</label>
                                <input type="date" class="form-control" id="fechaInicio" placeholder="Fecha de inicio" name="fechaInicio" required>
                            </div>

                            <div class="mb-3">
                                <label for="detalles" class="form-label">Detalles adicionales</label>
                                <textarea class="form-control" id="detalles"  placeholder="Detalles adicionales" name="detalles" rows="3"></textarea>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-file-signature me-2"></i> Solicitar Cotización
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Proceso de contratación -->
            <div class="row mt-5">
                <div class="col-12">
                    <h3 class="mb-4">¿Cómo contratar este servicio?</h3>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <div class="card h-100 border-0 shadow-sm">
                                <div class="card-body text-center">
                                    <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                        <i class="fas fa-1 text-primary fs-4"></i>
                                    </div>
                                    <h5>Solicitud</h5>
                                    <p class="text-muted">Complete el formulario con sus datos y requerimientos</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card h-100 border-0 shadow-sm">
                                <div class="card-body text-center">
                                    <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                        <i class="fas fa-2 text-primary fs-4"></i>
                                    </div>
                                    <h5>Cotización</h5>
                                    <p class="text-muted">Le enviaremos una propuesta detallada con costos y plazos</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card h-100 border-0 shadow-sm">
                                <div class="card-body text-center">
                                    <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                        <i class="fas fa-3 text-primary fs-4"></i>
                                    </div>
                                    <h5>Contratación</h5>
                                    <p class="text-muted">Firmaremos el contrato y comenzaremos con el servicio</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Servicios relacionados (opcional) -->
            <c:if test="${not empty serviciosRelacionados}">
                <div class="row mt-5">
                    <div class="col-12">
                        <h3 class="mb-4">Otros servicios que podrían interesarte</h3>
                        <div class="row">
                            <c:forEach var="relacionado" items="${serviciosRelacionados}">
                                <div class="col-md-4 mb-4">
                                    <div class="card related-service-card h-100">
                                        <div class="position-relative">
                                            <c:choose>
                                                <c:when test="${not empty relacionado.imagenBase64}">
                                                    <img src="data:image/jpeg;base64,${relacionado.imagenBase64}" 
                                                         class="card-img-top" 
                                                         alt="${relacionado.nombre_servicio}"
                                                         style="height: 180px; object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/assets/images/no-image.jpg" 
                                                         class="card-img-top" 
                                                         alt="Imagen no disponible"
                                                         style="height: 180px; object-fit: cover;">
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="position-absolute top-0 end-0 m-2">
                                                <span class="badge duration-badge">
                                                    <i class="fas fa-clock me-1"></i> ${relacionado.duracion_estimada} días
                                                </span>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h5 class="card-title">${relacionado.nombre_servicio}</h5>
                                            <p class="card-text text-muted small">${relacionado.descripcion}</p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="text-success fw-bold">
                                                    S/. <fmt:formatNumber value="${relacionado.precio_base}" pattern="#,##0.00"/>
                                                </span>
                                                <a href="detalle-servicio.jsp?id=${relacionado.id_servicio}" class="btn btn-sm btn-outline-primary">
                                                    Ver detalles
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <%@ include file="INCLUDE/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Validación del formulario
            document.getElementById('contratarForm').addEventListener('submit', function (e) {
                const fechaInicio = new Date(document.getElementById('fechaInicio').value);
                const hoy = new Date();
                hoy.setHours(0, 0, 0, 0);

                if (fechaInicio < hoy) {
                    e.preventDefault();
                    alert('La fecha de inicio no puede ser anterior al día de hoy');
                    return false;
                }
                return true;
            });

            // Establecer fecha mínima como hoy
            document.getElementById('fechaInicio').min = new Date().toISOString().split('T')[0];
        </script>
    </body>
</html>