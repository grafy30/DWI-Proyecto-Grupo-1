<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Arqui Peru</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/bootstrap.bundle.min.js"></script>
    </head>
    <body>   
    <%@ include file="INCLUDE/header.jsp" %>
        <div id="hero-carousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="6000" data-bs-pause="hover">
            <!-- Indicadores -->
            <ol class="carousel-indicators">
                <li data-bs-target="#hero-carousel" data-bs-slide-to="0" class="active"></li>
                <li data-bs-target="#hero-carousel" data-bs-slide-to="1"></li>
                <li data-bs-target="#hero-carousel" data-bs-slide-to="2"></li>
            </ol>

            <!-- Slides -->
            <div class="carousel-inner">
                <!-- Slide 1 -->
                <div class="carousel-item active">
                    <img src="imagenes/banner_1.jpg" class="d-block w-100" alt="Banner 1">
                    <div class="carousel-caption d-none d-md-block">
                        <h2 class="display-4">Arqui-Peru Company</h2>
                        <p class="lead">El mejor sitio web para arquitectos y clientes</p>
                        <p>Brindamos servicios profesionales para tu hogar. Somos estudiantes de Sistemas comprometidos con la excelencia.</p>
                        <a href="#" class="btn btn-success btn-lg">Ver servicios</a>
                    </div>
                </div>

                <!-- Slide 2 -->
                <div class="carousel-item">
                    <img src="imagenes/banner_2.jpg" class="d-block w-100" alt="Banner 2">
                    <div class="carousel-caption d-none d-md-block">
                        <h2 class="display-4">Diseños Innovadores</h2>
                        <p class="lead">Soluciones arquitectónicas modernas</p>
                        <p>Nuestro equipo de profesionales crea diseños personalizados para cada necesidad.</p>
                        <a href="#" class="btn btn-primary btn-lg">Ver proyectos</a>
                    </div>
                </div>

                <!-- Slide 3 -->
                <div class="carousel-item">
                    <img src="imagenes/banner_3.jpg" class="d-block w-100" alt="Banner 3">
                    <div class="carousel-caption d-none d-md-block">
                        <h2 class="display-4">Calidad Garantizada</h2>
                        <p class="lead">Materiales de primera y mano de obra calificada</p>
                        <p>Trabajamos con los mejores proveedores para garantizar resultados duraderos.</p>
                        <a href="#" class="btn btn-warning btn-lg">Contactar ahora</a>
                    </div>
                </div>
            </div>

            <!-- Controles -->
            <a class="carousel-control-prev" href="#hero-carousel" role="button" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </a>
            <a class="carousel-control-next" href="#hero-carousel" role="button" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </a>
    </div>
    <%@ include file="INCLUDE/footer.jsp" %>
    <script src="js/script.js"></script>
</body>
</html>
