<%-- 
    Document   : header_cliente
    Created on : 1 may. 2025, 03:23:48
    Author     : DIEGO DAMIAN
--%>



<!DOCTYPE html>
<html>
<head>
    <title>Barra de Navegación</title>
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Botón hamburguesa -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar"
                aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Logo / Inicio -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/login.jsp">INICIO</a>

        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <!-- Servicios con submenú -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="serviciosDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        SERVICIOS
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="serviciosDropdown">
                        <li><a class="dropdown-item" href="../htmls/Construcción_de_Obras_Civiles.html">Proyectos Inmobiliarios</a></li>
                        <li><a class="dropdown-item" href="../htmls/Diseño_y_Construccion_3D_BIM.html">Saneamiento Físico Legal de Predios</a></li>
                        <li><a class="dropdown-item" href="../htmls/Proyectos_Inmobiliarios.html">Diseño y Construcción 3D ? BIM</a></li>
                        <li><a class="dropdown-item" href="../htmls/Saneamiento_Fisico_Legal_de_Predios.html">Construcción de Obras Civiles</a></li>
                        <li><a class="dropdown-item" href="../htmls/Topografía.html">Topografía</a></li>
                        
                   
                    </ul>
                </li>
                
                <!-- Otros enlaces principales -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Paginas_sin_crud/Contacto.jsp">CONTACTO</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Paginas_sin_crud/Nosotros.jsp">NOSOTROS</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">PROYECTOS</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">ARTÍCULOS</a>
                </li>

                <!-- Login simple que redirige al login.jsp -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">LOGIN</a>
                </li>

            </ul>
        </div>
    </div>
</nav>

<!-- Bootstrap JS (Popper.js incluido) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- CSS opcional para submenú anidado (Bandeja de mensajes) -->
<style>
    .dropdown-submenu {
        position: relative;
    }

    .dropdown-submenu .dropdown-menu.dropdown-sub {
        top: 0;
        left: 100%;
        margin-left: 0.1rem;
        margin-right: 0.1rem;
    }
</style>
</body>
</html>