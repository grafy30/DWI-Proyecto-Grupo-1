<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios - Portal de Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-concierge-bell me-2"></i>
                Portal de Servicios
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/servicios">Servicios</a>
                    </li>
                </ul>
                
                <!-- Barra de búsqueda -->
                <form class="d-flex me-3" method="GET" action="${pageContext.request.contextPath}/servicios">
                    <div class="input-group">
                        <input class="form-control" type="search" name="search" 
                               placeholder="Buscar servicios..." value="${currentSearch}">
                        <button class="btn btn-outline-light" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
                
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.authenticated}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <c:if test="${not empty sessionScope.user.pictureUrl}">
                                        <img src="${sessionScope.user.pictureUrl}" alt="Avatar" class="rounded-circle me-1" width="24" height="24">
                                    </c:if>
                                    ${sessionScope.user.name}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                        <i class="fas fa-user me-2"></i>Mi Perfil
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mis-servicios">
                                        <i class="fas fa-clipboard-list me-2"></i>Mis Servicios
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                                    </a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">
                                    <i class="fas fa-sign-in-alt me-1"></i>Iniciar Sesión
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                    
                    <li class="nav-item">
                        <a class="nav-link position-relative" href="${pageContext.request.contextPath}/solicitudes">
                            <i class="fas fa-bell"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notifications-count">
                                0
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Breadcrumb -->
    <div class="container mt-3">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Inicio</a></li>
                <li class="breadcrumb-item active">Servicios</li>
            </ol>
        </nav>
    </div>

    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar de Filtros -->
            <div class="col-lg-3 mb-4">
                <div class="filter-sidebar">
                    <h5 class="filter-title">Filtros</h5>
                    
                    <form method="GET" action="${pageContext.request.contextPath}/servicios" id="filter-form">
                        <!-- Mantener búsqueda actual -->
                        <c:if test="${not empty currentSearch}">
                            <input type="hidden" name="search" value="${currentSearch}">
                        </c:if>
                        
                        <!-- Filtro por Categoría -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Categoría</label>
                            <select class="form-select" name="category" onchange="document.getElementById('filter-form').submit();">
                                <option value="">Todas las categorías</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id_categoria}" 
                                            <c:if test="${currentCategory == category.id_categoria}">selected</c:if>>
                                        ${category.nombre}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Filtro por Precio Base -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Rango de Precio Base</label>
                            <div class="row">
                                <div class="col-6">
                                    <input type="text" class="form-control" name="minPrice" 
                                           placeholder="Mín" value="${currentMinPrice}">
                                </div>
                                <div class="col-6">
                                    <input type="text" class="form-control" name="maxPrice" 
                                           placeholder="Máx" value="${currentMaxPrice}">
                                </div>
                            </div>
                        </div>
                        
                        <!-- Filtro por Duración -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Duración Estimada (días)</label>
                            <div class="row">
                                <div class="col-6">
                                    <input type="text" class="form-control" name="minDuration" 
                                           placeholder="Mín" value="${currentMinDuration}">
                                </div>
                                <div class="col-6">
                                    <input type="text" class="form-control" name="maxDuration" 
                                           placeholder="Máx" value="${currentMaxDuration}">
                                </div>
                            </div>
                        </div>
                        
                        <!-- Filtro por Estado -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Estado del Servicio</label>
                            <select class="form-select" name="estado" onchange="document.getElementById('filter-form').submit();">
                                <option value="">Todos los estados</option>
                                <option value="activo" <c:if test="${currentEstado == 'activo'}">selected</c:if>>Activo</option>
                                <option value="inactivo" <c:if test="${currentEstado == 'inactivo'}">selected</c:if>>Inactivo</option>
                                <option value="mantenimiento" <c:if test="${currentEstado == 'mantenimiento'}">selected</c:if>>En Mantenimiento</option>
                            </select>
                        </div>
                        
                        <!-- Ordenamiento -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Ordenar por</label>
                            <select class="form-select" name="sort" onchange="document.getElementById('filter-form').submit();">
                                <option value="">Más recientes</option>
                                <option value="nombre_servicio" <c:if test="${currentSort == 'nombre_servicio'}">selected</c:if>>Nombre A-Z</option>
                                <option value="precio_base" <c:if test="${currentSort == 'precio_base'}">selected</c:if>>Precio: Menor a Mayor</option>
                                <option value="precio_base_desc" <c:if test="${currentSort == 'precio_base' && currentOrder == 'DESC'}">selected</c:if>>Precio: Mayor a Menor</option>
                                <option value="duracion_estimada" <c:if test="${currentSort == 'duracion_estimada'}">selected</c:if>>Duración: Menor a Mayor</option>
                                <option value="duracion_estimada_desc" <c:if test="${currentSort == 'duracion_estimada' && currentOrder == 'DESC'}">selected</c:if>>Duración: Mayor a Menor</option>
                            </select>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Aplicar Filtros</button>
                            <a href="${pageContext.request.contextPath}/servicios" class="btn btn-outline-secondary">Limpiar</a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Lista de Servicios -->
            <div class="col-lg-9">
                <!-- Header con información de resultados -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2>Catálogo de Servicios</h2>
                        <p class="text-muted mb-0">
                            Mostrando ${servicios.size()} de ${totalServicios} servicios
                            <c:if test="${not empty currentSearch}">
                                para "<strong>${currentSearch}</strong>"
                            </c:if>
                        </p>
                    </div>
                    <div class="d-flex align-items-center">
                        <span class="me-2">Ver:</span>
                        <div class="btn-group" role="group">
                            <input type="radio" class="btn-check" name="view" id="grid-view" checked>
                            <label class="btn btn-outline-secondary" for="grid-view">
                                <i class="fas fa-th"></i>
                            </label>
                            <input type="radio" class="btn-check" name="view" id="list-view">
                            <label class="btn btn-outline-secondary" for="list-view">
                                <i class="fas fa-list"></i>
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- Grid de Servicios -->
                <div class="row" id="servicios-grid">
                    <c:choose>
                        <c:when test="${empty servicios}">
                            <div class="col-12 text-center py-5">
                                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                <h4>No se encontraron servicios</h4>
                                <p class="text-muted">Intenta ajustar los filtros o buscar algo diferente</p>
                                <a href="${pageContext.request.contextPath}/servicios" class="btn btn-primary">Ver todos los servicios</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="servicio" items="${servicios}">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card service-card h-100">
                                        <div class="position-relative">
                                            <c:choose>
                                                <c:when test="${not empty servicio.imagen}">
                                                    <img src="${pageContext.request.contextPath}/images/servicios/${servicio.id_servicio}.jpg" 
                                                         class="card-img-top" alt="${servicio.nombre_servicio}"
                                                         onerror="this.src='${pageContext.request.contextPath}/images/no-service-image.jpg'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/images/no-service-image.jpg" 
                                                         class="card-img-top" alt="Sin imagen">
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <!-- Badge de Estado -->
                                            <div class="position-absolute top-0 end-0 m-2">
                                                <c:choose>
                                                    <c:when test="${servicio.estado == 'activo'}">
                                                        <span class="badge bg-success">Disponible</span>
                                                    </c:when>
                                                    <c:when test="${servicio.estado == 'inactivo'}">
                                                        <span class="badge bg-danger">No Disponible</span>
                                                    </c:when>
                                                    <c:when test="${servicio.estado == 'mantenimiento'}">
                                                        <span class="badge bg-warning">Mantenimiento</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${servicio.estado}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="card-body d-flex flex-column">
                                            <h5 class="card-title">${servicio.nombre_servicio}</h5>
                                            <p class="card-text flex-grow-1">${servicio.descripcion}</p>
                                            <div class="mt-auto">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <span class="service-price fw-bold text-primary">
                                                        <fmt:formatNumber value="${servicio.precio_base}" type="currency" currencySymbol="$"/>
                                                    </span>
                                                    <small class="text-muted">
                                                        <i class="fas fa-clock me-1"></i>
                                                        ${servicio.duracion_estimada} 
                                                        <c:choose>
                                                            <c:when test="${servicio.duracion_estimada == 1}">día</c:when>
                                                            <c:otherwise>días</c:otherwise>
                                                        </c:choose>
                                                    </small>
                                                </div>
                                                <div class="mb-2">
                                                    <small class="text-muted">
                                                        <c:if test="${servicio.categoria != null}">
                                                            <i class="fas fa-tag me-1"></i>
                                                            ${servicio.categoria.nombre}
                                                        </c:if>
                                                    </small>
                                                </div>
                                                <div class="d-grid gap-2">
                                                    <a href="${pageContext.request.contextPath}/servicios/detalles/${servicio.id_servicio}" 
                                                       class="btn btn-outline-primary btn-sm">
                                                        <i class="fas fa-eye me-1"></i>Ver Detalles
                                                    </a>
                                                    <c:choose>
                                                        <c:when test="${servicio.estado == 'activo'}">
                                                            <button class="btn btn-success btn-sm btn-solicitar-servicio" 
                                                                    data-servicio-id="${servicio.id_servicio}"
                                                                    data-servicio-nombre="${servicio.nombre_servicio}"
                                                                    data-servicio-precio="${servicio.precio_base}"
                                                                    data-servicio-duracion="${servicio.duracion_estimada}">
                                                                <i class="fas fa-handshake me-1"></i>Solicitar Servicio
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${servicio.estado == 'mantenimiento'}">
                                                            <button class="btn btn-warning btn-sm" disabled>
                                                                <i class="fas fa-tools me-1"></i>En Mantenimiento
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="btn btn-secondary btn-sm" disabled>
                                                                <i class="fas fa-times me-1"></i>No Disponible
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Paginación -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Paginación de servicios">
                        <ul class="pagination justify-content-center">
                            <!-- Página anterior -->
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage - 1}&category=${currentCategory}&search=${currentSearch}&minPrice=${currentMinPrice}&maxPrice=${currentMaxPrice}&minDuration=${currentMinDuration}&maxDuration=${currentMaxDuration}&estado=${currentEstado}&sort=${currentSort}&order=${currentOrder}">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>
                            
                            <!-- Páginas -->
                            <c:forEach begin="1" end="${totalPages}" var="page">
                                <c:choose>
                                    <c:when test="${page == currentPage}">
                                        <li class="page-item active">
                                            <span class="page-link">${page}</span>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${page}&category=${currentCategory}&search=${currentSearch}&minPrice=${currentMinPrice}&maxPrice=${currentMaxPrice}&minDuration=${currentMinDuration}&maxDuration=${currentMaxDuration}&estado=${currentEstado}&sort=${currentSort}&order=${currentOrder}">
                                                ${page}
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <!-- Página siguiente -->
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage + 1}&category=${currentCategory}&search=${currentSearch}&minPrice=${currentMinPrice}&maxPrice=${currentMaxPrice}&minDuration=${currentMinDuration}&maxDuration=${currentMaxDuration}&estado=${currentEstado}&sort=${currentSort}&order=${currentOrder}">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Portal de Servicios</h5>
                    <p>Tu plataforma de servicios profesionales de confianza</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>&copy; 2024 Portal de Servicios. Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/servicios.js"></script>
</body>
</html>

