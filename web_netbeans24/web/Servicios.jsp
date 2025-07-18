<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Arqui Peru-Contacto</title>
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
                <h2 class="text-center mb-5">Categorías Destacadas</h2>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body text-center">
                                <i class="fas fa-drafting-compass fa-3x text-primary mb-3"></i>
                                <h5 class="card-title">Diseño</h5>
                                <p class="card-text">Planificación y modelación Arquitectónica conceptual</p>
                                <a href="${pageContext.request.contextPath}/products?category=1" class="btn btn-outline-primary">
                                    Ver Servicios
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body text-center">
                                <i class="fas fa-building fa-3x text-success mb-3"></i>
                                <h5 class="card-title">Construcción</h5>
                                <p class="card-text">Edificación de viviendas unifamiliares y multifamiliares</p>
                                <a href="${pageContext.request.contextPath}/products?category=2" class="btn btn-outline-success">
                                    Ver Servicios
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body text-center">
                                <i class="fas fa-handshake fa-3x text-warning mb-3"></i>
                                <h5 class="card-title">Servicios Integrados</h5>
                                <p class="card-text">Identificación y desarrollo de oportunidades de inversión</p>
                                <a href="${pageContext.request.contextPath}/products?category=3" class="btn btn-outline-warning">
                                    Ver Servicios
                                </a>
                            </div>
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
