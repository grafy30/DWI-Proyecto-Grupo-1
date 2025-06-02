<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Arqui Peru - Nosotros</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
        <style>
            .hero-section {
                background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('${pageContext.request.contextPath}/imagenes/Nosotros.jpg');
                background-size: cover;
                background-position: center;
                color: white;
                padding: 120px 0;
                margin-bottom: 50px;
            }

            .feature-icon {
                font-size: 2rem;
                color: #0d6efd;
                margin-bottom: 1rem;
            }

            .card-hover:hover {
                transform: translateY(-10px);
                transition: all 0.3s ease;
            }

            .value-item {
                border-left: 3px solid #0d6efd;
                padding-left: 15px;
                margin-bottom: 15px;
            }

            .team-img {
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
        </style>
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>        

        <!-- Hero Section -->
        <section class="nosotros">
            <div class="container">
                <h1 class="display-4 fw-bold mb-4">Sobre Nosotros</h1>
                <p class="lead text-white">25 años transformando espacios, creando hogares y diseñando el futuro</p>
            </div>
        </section>

        <!-- Quienes Somos -->
        <section class="container mb-5">
            <div class="row justify-content-center mt-5">
                <div class="col-lg-10 text-center mb-5">
                    <h2 class="display-5 fw-bold mb-4">¿Quiénes Somos?</h2>
                    <p class="lead text-muted">
                        Somos una compañía dedicada a brindar servicios de arquitectura con amplia experiencia y compromiso en el desarrollo de diseños y proyectos exclusivos, funcionales y de alta calidad.
                    </p>
                </div>
            </div>

            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <img src="${pageContext.request.contextPath}/imagenes/panel_nosotros.jpg" alt="Equipo Arqui Peru" class="img-fluid rounded-3 team-img">
                </div>
                <div class="col-lg-6">
                    <div class="ps-lg-5">
                        <h3 class="fw-bold mb-4">Arqui <span class="text-primary">Perú</span></h3>
                        <p class="mb-4">
                            Empresa peruana con más de <span class="fw-bold text-primary">25 años de experiencia</span> en el sector de arquitectura, diseño y construcción. Nos apasiona crear espacios funcionales, estéticos y sostenibles, transformando ideas en proyectos que mejoran la calidad de vida.
                        </p>

                        <div class="d-flex align-items-start mb-4">
                            <div class="flex-shrink-0">
                                <div class="feature-icon">
                                    <i class="fas fa-bullseye"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-4">
                                <h4 class="fw-bold">Nuestro Propósito</h4>
                                <p>Inspirar y construir un Perú más moderno, humano y sostenible a través del diseño arquitectónico responsable y de calidad.</p>
                            </div>
                        </div>

                        <div class="d-flex align-items-start">
                            <div class="flex-shrink-0">
                                <div class="feature-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-4">
                                <h4 class="fw-bold">¿Qué nos diferencia?</h4>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Atención personalizada y cercana</li>
                                    <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Creatividad y cumplimiento en cada proyecto</li>
                                    <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Tecnologías modernas y procesos sostenibles</li>
                                    <li><i class="fas fa-check-circle text-primary me-2"></i> Experiencia en diversos tipos de proyectos</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Misión, Visión y Valores -->
        <section class="py-5 bg-light">
            <div class="container">
                <div class="text-center mb-5">
                    <h2 class="display-5 fw-bold">Nuestros Pilares</h2>
                    <p class="lead text-muted">Los fundamentos que guían nuestro trabajo</p>
                </div>

                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm card-hover">
                            <div class="card-body text-center p-4">
                                <div class="feature-icon">
                                    <i class="fas fa-bullseye"></i>
                                </div>
                                <h4 class="fw-bold mb-3">Misión</h4>
                                <p class="text-muted">
                                    Transformar ideas en espacios innovadores, funcionales y sostenibles, superando expectativas y contribuyendo al desarrollo urbano responsable en el Perú.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm card-hover">
                            <div class="card-body text-center p-4">
                                <div class="feature-icon">
                                    <i class="fas fa-eye"></i>
                                </div>
                                <h4 class="fw-bold mb-3">Visión</h4>
                                <p class="text-muted">
                                    Ser la empresa de referencia en arquitectura y construcción a nivel nacional, reconocida por creatividad, calidad y capacidad de crear ambientes que inspiran.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm card-hover">
                            <div class="card-body p-4">
                                <div class="text-center mb-3">
                                    <div class="feature-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <h4 class="fw-bold">Valores</h4>
                                </div>
                                <div class="value-item">
                                    <h6 class="fw-bold">Innovación</h6>
                                    <p class="small text-muted mb-0">Creamos soluciones únicas y modernas</p>
                                </div>
                                <div class="value-item">
                                    <h6 class="fw-bold">Compromiso</h6>
                                    <p class="small text-muted mb-0">Cumplimos nuestras promesas</p>
                                </div>
                                <div class="value-item">
                                    <h6 class="fw-bold">Sostenibilidad</h6>
                                    <p class="small text-muted mb-0">Respetamos el entorno y los recursos</p>
                                </div>
                                <div class="value-item">
                                    <h6 class="fw-bold">Ética</h6>
                                    <p class="small text-muted mb-0">Trabajamos con honestidad y responsabilidad</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Equipo (opcional) -->
        <section class="py-5 container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Nuestro Equipo</h2>
                <p class="lead text-muted">Profesionales apasionados por la arquitectura</p>
            </div>

            <div class="row g-4 justify-content-center">
                <!-- Miembro 1 -->
                <div class="col-6 col-sm-4 col-md-3 col-lg-2-4"> <!-- Clase personalizada añadida -->
                    <div class="card border-0 shadow-sm text-center card-hover h-100">
                        <img src="${pageContext.request.contextPath}/imagenes/foto.jpg" class="card-img-top" alt="Arquitecto">
                        <div class="card-body">
                            <h5 class="card-title fw-bold mb-1">Wilson G.</h5>
                            <p class="text-muted small mb-2">Software Engineer</p>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="#" class="text-primary"><i class="fab fa-linkedin"></i></a>
                                <a href="#" class="text-primary"><i class="fas fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Miembro 2 -->
                <div class="col-6 col-sm-4 col-md-3 col-lg-2-4">
                    <div class="card border-0 shadow-sm text-center card-hover h-100">
                        <img src="https://via.placeholder.com/300" class="card-img-top" alt="Arquitecto">
                        <div class="card-body">
                            <h5 class="card-title fw-bold mb-1">Juan P.</h5>
                            <p class="text-muted small mb-2">Arquitecto</p>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="#" class="text-primary"><i class="fab fa-linkedin"></i></a>
                                <a href="#" class="text-primary"><i class="fas fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Miembro 3 -->
                <div class="col-6 col-sm-4 col-md-3 col-lg-2-4">
                    <div class="card border-0 shadow-sm text-center card-hover h-100">
                        <img src="https://via.placeholder.com/300" class="card-img-top" alt="Arquitecto">
                        <div class="card-body">
                            <h5 class="card-title fw-bold mb-1">Ana M.</h5>
                            <p class="text-muted small mb-2">Diseñadora</p>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="#" class="text-primary"><i class="fab fa-linkedin"></i></a>
                                <a href="#" class="text-primary"><i class="fas fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Miembro 4 -->
                <div class="col-6 col-sm-4 col-md-3 col-lg-2-4">
                    <div class="card border-0 shadow-sm text-center card-hover h-100">
                        <img src="https://via.placeholder.com/300" class="card-img-top" alt="Arquitecto">
                        <div class="card-body">
                            <h5 class="card-title fw-bold mb-1">Diego R.</h5>
                            <p class="text-muted small mb-2">Ingeniero</p>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="#" class="text-primary"><i class="fab fa-linkedin"></i></a>
                                <a href="#" class="text-primary"><i class="fas fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Miembro 5 -->
                <div class="col-6 col-sm-4 col-md-3 col-lg-2-4">
                    <div class="card border-0 shadow-sm text-center card-hover h-100">
                        <img src="https://via.placeholder.com/300" class="card-img-top" alt="Arquitecto">
                        <div class="card-body">
                            <h5 class="card-title fw-bold mb-1">Favian T.</h5>
                            <p class="text-muted small mb-2">Ingeniero</p>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="#" class="text-primary"><i class="fab fa-linkedin"></i></a>
                                <a href="#" class="text-primary"><i class="fas fa-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <style>
            /* Clase personalizada para 5 columnas en pantallas grandes */
            @media (min-width: 992px) {
                .col-lg-2-4 {
                    flex: 0 0 auto;
                    width: 20%; /* 100% / 5 = 20% */
                }
            }

            /* Ajustes para tarjetas más compactas */
            .card {
                min-width: 120px; /* Ancho mínimo para mantener legibilidad */
            }

            .card-img-top {
                height: 120px;
                object-fit: cover;
            }

            .card-body {
                padding: 0.75rem;
            }

            .card-title {
                font-size: 0.9rem;
            }

            .small {
                font-size: 0.75rem;
            }
        </style>

        <section class="py-5 bg-light text-white">
            <div class="container text-center py-4">
                <h2 class="display-6 fw-bold mb-4">¿Listo para comenzar tu proyecto?</h2>
                <p class="lead mb-4">Contáctanos y hagamos realidad tus ideas</p>
                <a href="#" class="btn btn-success btn-lg px-4">Contactar Ahora</a>
            </div>
        </section>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="INCLUDE/footer.jsp" %>
    </body>
</html>