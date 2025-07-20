<%@page import="java.util.List"%>
<%@page import="BusinessLogic.ServiciosBL"%>
<%@page import="BusinessEntify.ServiciosBE"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ServiciosBL serviciosBL = new ServiciosBL();
    List<ServiciosBE> lista = serviciosBL.ReadAll();  // Cambiado de listarServicios() a ReadAll()
%>
<!DOCTYPE html>
<html>
    <head>
        <title>cate diseño</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
    </head>

    <body>
        <%@ include file="INCLUDE/header.jsp" %>          
        <section class="servicios">
            <h1>Servicios</h1>
        </section>

        <section class="intro">
            <h2>Nuestros Servicios</h2>
            <p>
                Contamos con una amplia experiencia y compromiso en el desarrollo de diseños y proyectos exclusivos, funcionales y de alta calidad, logrando superar las expectativas de nuestros clientes, causando gran satisfacción.
            </p>
        </section>

        <section class="py-5">
            <div class="container">
                <h2 class="text-center mb-5">Categorías Diseño</h2>

                <div class="container mt-4">
                    <div class="row">
                        <!-- Sidebar de Filtros -->
                        <div class="col-lg-3 mb-4">
                            <div class="filter-sidebar">
                                <h5 class="filter-title">Filtros</h5>

                                <form method="GET" action="${pageContext.request.contextPath}/products" id="filter-form">
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
                                                <option value="${category.id}" 
                                            <c:if test="${currentCategory == category.id}">selected</c:if>>
                                                ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Filtro por Precio -->
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Rango de Precio</label>
                                    <div class="row">
                                        <div class="col-6">
                                            <input type="number" class="form-control" name="minPrice" 
                                                   placeholder="Mín" value="${currentMinPrice}" step="0.01">
                                        </div>
                                        <div class="col-6">
                                            <input type="number" class="form-control" name="maxPrice" 
                                                   placeholder="Máx" value="${currentMaxPrice}" step="0.01">
                                        </div>
                                    </div>
                                </div>

                                <!-- Ordenamiento -->
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Ordenar por</label>
                                    <select class="form-select" name="sort" onchange="document.getElementById('filter-form').submit();">
                                        <option value="">Más recientes</option>
                                        <option value="name" <c:if test="${currentSort == 'name'}">selected</c:if>>Nombre A-Z</option>
                                        <option value="price" <c:if test="${currentSort == 'price'}">selected</c:if>>Precio: Menor a Mayor</option>
                                        <option value="price" <c:if test="${currentSort == 'price' && currentOrder == 'DESC'}">selected</c:if>>Precio: Mayor a Menor</option>
                                    </select>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Aplicar Filtros</button>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">Limpiar</a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Lista de Servicios -->
                    <div class="col-lg-9">
                        <!-- Header con información de resultados -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2>Servicios</h2>
                                <p class="text-muted mb-0">
                                    Mostrando ${servicios.size()} de ${totalServicios} lista
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
                        <div class="row" id="products-grid">

                            <% for (int i = 0; i < lista.size(); i++) { %>

                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card product-card h-100">
                                    <div class="position-relative">
                                        <img src=""<%=lista.get(i).getImagen()%> 
                                             class="card-img-top" alt="${lista.name}"
                                             onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">

                                        <div class="position-absolute top-0 end-0 m-2">
                                            <span class="badge bg-danger">Agotado</span>
                                        </div>

                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title"><%=lista.get(i).getNombre_servicio() %></h5>
                                        <p class="card-text flex-grow-1">${servicios.description}</p>
                                        <div class="mt-auto">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="product-price">

                                                </span>
                                                <small class="text-muted">

                                                    ${servicios.category.name}

                                                </small>
                                            </div>
                                            <div class="d-grid gap-2">
                                                <a href="${pageContext.request.contextPath}/products/details/${servicios.id}" 
                                                   class="btn btn-outline-primary btn-sm">
                                                    <i class="fas fa-eye me-1"></i>Ver Detalles
                                                </a>


                                                <button class="btn btn-success btn-sm btn-add-to-cart" 
                                                        data-product-id="${servicios.id}"
                                                        data-product-name="${servicios.name}"
                                                        data-product-price="${servicios.price}"
                                                        data-product-image="${pageContext.request.contextPath}${servicios.imageUrl}">
                                                    <i class="fas fa-cart-plus me-1"></i>Agregar al Carrito
                                                </button>

                                                <button class="btn btn-secondary btn-sm" disabled>
                                                    <i class="fas fa-times me-1"></i>No Disponible
                                                </button>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% }%>


                        </div>
                        <!-- Paginación -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Paginación de productos">
                                <ul class="pagination justify-content-center">
                                    <!-- Página anterior -->
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}&category=${currentCategory}&search=${currentSearch}&minPrice=${currentMinPrice}&maxPrice=${currentMaxPrice}&sort=${currentSort}&order=${currentOrder}">
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
                                                    <a class="page-link" href="?page=${page}&category=${currentCategory}&search=${currentSearch}&minPrice=${currentMinPrice}&maxPrice=${currentMaxPrice}&sort=${currentSort}&order=${currentOrder}">
                                                        ${page}
                                                    </a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <!-- Página siguiente -->
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&category=${currentCategory}&search=${currentSearch}&minPrice=${currentMinPrice}&maxPrice=${currentMaxPrice}&sort=${currentSort}&order=${currentOrder}">
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
        </div>
    </section>

    <!-- Servicios Destacados -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-5">Servicios Destacados</h2>
            <div class="row" id="featured-products">
                <!-- Los productos se cargarán dinámicamente -->
            </div>
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                    Ver Todos los servicios
                </a>
            </div>
        </div>
    </section>

    <!-- Sección 1 -->
    <section class="content-block">
        <div class="text-block">
            <h3>Servicios Generales y mantenimientos</h3>
            <ul>
                <li>Construcción, ampliaciones y remodelaciones de oficinas, viviendas y comercios.</li>
                <li>Pintura de pared, metales, coberturas metálicas techos.</li>
                <li>Armado de Drywall, Cielos Rasos, baldosas de techo.</li>
                <li>Electricidad, cableado en general, tableros eléctricos certificados.</li>
                <li>Mantenimientos a pozo a tierra y sub estación.</li>
                <li>Gasfitería, red de agua y desagüe.</li>
                <li>Instalaciones electromecánicas AACC.</li>
                <li>Carpintería metálica y en melamina.</li>
                <li>Instalación de pisos cerámicos, vinílicos y de madera.</li>
            </ul>
        </div>
        <div class="image-block">
            <img src="imagenes/Servicios_Generales.jpg" alt="Equipo de obra" />
        </div>
    </section>

    <!-- Sección 2 -->
    <section class="content-block reverse">
        <div class="text-block">
            <h3>Anteproyectos y Obras Civiles</h3>
            <ul>
                <li>Elaboración de Planos de Arquitectura, Eléctricos y Sanitarios.</li>
                <li>Elaboración de cronograma y presupuesto de obra.</li>
                <li>Levantamientos topográficos y estudios de suelo.</li>
                <li>Supervisión de obra.</li>
            </ul>
        </div>
        <div class="image-block">
            <img src="imagenes/obras_civiles.jpg" alt="Planos de arquitectura" />
        </div>
    </section>

    <!-- Sección 3 -->
    <section class="content-block">
        <div class="text-block">
            <h3>Elaboración de Expedientes Técnicos en edificaciones (INDECI ? DEFENSA CIVIL)</h3>
            <ul>
                <li>Inspecciones de Seguridad en edificaciones.</li>
                <li>Planos de ubicación, arquitectura, eléctricos, etc.</li>
                <li>Memorias descriptivas, análisis de riesgo, planes de contingencia.</li>
            </ul>
        </div>
        <div class="image-block">
            <img src="imagenes/Planos.jpg" alt="Certificado Defensa Civil" />
        </div>
    </section>

    <!-- Sección 4 -->
    <section class="content-block reverse">

        <div class="text-block">
            <h3>Tasaciones</h3>
            <ul>
                <li>Inmuebles, maquinarias y equipos.</li>
                <li>Bienes muebles para fines comerciales, judiciales o administrativos.</li>
                <li>Realizadas por peritos certificados bajo el Reglamento Nacional de Tasaciones.</li>
            </ul>
        </div>
        <div class="image-block">
            <img src="imagenes/tasacion.jpg" alt="Tasaciones técnicas" />
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <%@ include file="INCLUDE/footer.jsp" %>    
    <!-- Bootstrap 5 Bundle JS, incluye Popper -->
</body>
</html>