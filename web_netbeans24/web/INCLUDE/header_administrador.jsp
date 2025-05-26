<!DOCTYPE html>
<html>
    <head>
        
        <title>Arqui-Peru</title>
        <!-- Bootstrap 5 CSS CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">        
        <link rel="stylesheet" href="css/templatemo.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="apple-touch-icon" sizes="180x180" href="imagenes/favicon_io/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="imagenes/favicon_io/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="imagenes/favicon_io/favicon-16x16.png">
        <link rel="manifest" href="/site.webmanifest"> 
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <!-- Botón hamburguesa -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar"
                        aria-controls="adminNavbar" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Logo / Inicio -->
                <a class="navbar-brand" href="${pageContext.request.contextPath}/admin.jsp">ADMIN</a>

                <div class="collapse navbar-collapse" id="adminNavbar">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <!-- Clientes -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin_clientes.jsp">CLIENTES</a>
                        </li>

                        <!-- Servicios -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin_servicios.jsp">SERVICIOS</a>
                        </li>

                        <!-- Proyectos -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin_proyectos.jsp">PROYECTOS</a>
                        </li>

                        <!-- Solicitudes -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin_solicitudes.jsp">SOLICITUDES</a>
                        </li>
                    </ul>

                    <!-- Cierre de sesión o Perfil -->
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                ADMINISTRADOR
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                                <li><a class="dropdown-item" href="#">Mi Perfil</a></li>
                                <li><a class="dropdown-item" href="#">Configuración</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout.jsp">Cerrar Sesión</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

