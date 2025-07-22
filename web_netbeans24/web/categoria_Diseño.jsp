<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="BusinessLogic.ServiciosBL, BusinessEntify.ServiciosBE, java.util.List"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Categoría Diseño</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
        <style>
            .card-img-top {
                height: 200px;
                object-fit: cover;
            }
            .product-card {
                transition: transform 0.3s;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
        </style>
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>          

        <section class="py-5 bg-light">
            <div class="container">
                <h1 class="text-center mb-5">Servicios de Diseño</h1>

                <!-- Filtros (opcional) -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Buscar servicios...">
                            <button class="btn btn-primary" type="button">Buscar</button>
                        </div>
                    </div>
                    <div class="col-md-6 text-end">
                        <select class="form-select w-auto d-inline-block">
                            <option>Ordenar por: Destacados</option>
                            <option>Precio: Menor a Mayor</option>
                            <option>Precio: Mayor a Menor</option>
                        </select>
                    </div>
                </div>

                <!-- Lista de Servicios -->
                <div class="row">
                    <c:forEach var="servicio" items="${servicios}">
                        <div class="col-md-4 mb-4">
                            <div class="card product-card h-100">
                                <c:choose>
                                    <c:when test="${not empty servicio.imagen}">
                                        <img src="data:image/png;base64,${servicio.imagen}" 
                                             class="card-img-top" alt="${servicio.nombre}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/no-image.jpg" 
                                             class="card-img-top" alt="Sin imagen">
                                    </c:otherwise>
                                </c:choose>

                                <div class="card-body">
                                    <h5 class="card-title">${servicio.nombre}</h5>
                                    <p class="card-text">${servicio.descripcion}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="h5 text-primary">S/. ${servicio.precio_base}</span>
                                        <span class="badge bg-secondary">${servicio.duracion_estimada} días</span>
                                    </div>
                                </div>
                                <div class="card-footer bg-white">
                                    <a href="detalleServicio.jsp?id=${servicio.id_servicio}" 
                                       class="btn btn-primary w-100">Ver Detalles</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Paginación -->
                <c:if test="${totalPaginas > 1}">
                    <nav aria-label="Paginación">
                        <ul class="pagination justify-content-center">
                            <c:if test="${paginaActual > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?pagina=${paginaActual - 1}">Anterior</a>
                                </li>
                            </c:if>

                            <c:forEach begin="1" end="${totalPaginas}" var="i">
                                <li class="page-item ${i == paginaActual ? 'active' : ''}">
                                    <a class="page-link" href="?pagina=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${paginaActual < totalPaginas}">
                                <li class="page-item">
                                    <a class="page-link" href="?pagina=${paginaActual + 1}">Siguiente</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </section>

        <%@ include file="INCLUDE/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>