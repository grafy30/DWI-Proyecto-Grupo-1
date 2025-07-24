<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Top Nav -->
<nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top">
    <div class="container text-light">
        <div class="w-100 d-flex justify-content-between">
            <div>
                <i class="fa fa-envelope mx-2"></i>
                <a class="navbar-sm-brand text-light text-decoration-none" href="mailto:info@company.com">info@company.com</a>
                <i class="fa fa-phone mx-2"></i>
                <a class="navbar-sm-brand text-light text-decoration-none" href="tel:+51 914088112">+51 914088112</a>
            </div>
            <div>
                <a class="text-light" href="https://fb.com/templatemo" target="_blank" rel="sponsored"><i class="fab fa-facebook-f fa-sm fa-fw me-2"></i></a>
                <a class="text-light" href="https://www.instagram.com/" target="_blank"><i class="fab fa-instagram fa-sm fa-fw me-2"></i></a>
                <a class="text-light" href="https://twitter.com/" target="_blank"><i class="fab fa-twitter fa-sm fa-fw me-2"></i></a>
                <a class="text-light" href="https://www.linkedin.com/" target="_blank"><i class="fab fa-linkedin fa-sm fa-fw"></i></a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Header -->
<nav class="navbar navbar-expand-lg navbar-light shadow">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand text-success logo h1 align-self-center" href="index.jsp">
            Arqui-Peru
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
                data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="align-self-center collapse navbar-collapse flex-fill d-lg-flex justify-content-lg-between"
             id="templatemo_main_nav">
            <div class="flex-fill">
                <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Nosotros.jsp">Nosotros</a></li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="serviciosDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">Servicios</a>
                        <ul class="dropdown-menu" aria-labelledby="serviciosDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Servicios.jsp"><strong>Ver todos los servicios</strong></a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="../htmls/Construcción_de_Obras_Civiles.html">Asesoría en Diseño de Pequeños Espacios</a></li>
                            <li><a class="dropdown-item" href="../htmls/Diseño_y_Construccion_3D_BIM.html">Tramitación de Licencias Municipales</a></li>
                            <li><a class="dropdown-item" href="../htmls/Proyectos_Inmobiliarios.html">Consultoría en Eficiencia Energética</a></li>
                            <li><a class="dropdown-item" href="../htmls/Saneamiento_Fisico_Legal_de_Predios.html">Diseño de Fachadas y Home Staging</a></li>
                            <li><a class="dropdown-item" href="../htmls/Topografía.html">Consultoría para materiales y acabados</a></li>
                        </ul>
                    </li>

                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Proyectos.jsp">Proyectos</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Contacto.jsp">Contacto</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a></li>

                    <!-- Carrito -->
                    <li class="nav-item">
                        <a class="nav-link position-relative" href="${pageContext.request.contextPath}/verCarrito.jsp">
                            <i class="fas fa-shopping-cart"></i>
                            <c:if test="${not empty sessionScope.carrito}">
                                <c:set var="totalItems" value="0" />
                                <c:forEach var="cantidad" items="${sessionScope.carrito.values()}">
                                    <c:set var="totalItems" value="${totalItems + cantidad}" />
                                </c:forEach>
                                <span id="contadorCarrito" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${totalItems}
                                    <span class="visually-hidden">productos en el carrito</span>
                                </span>
                            </c:if>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
