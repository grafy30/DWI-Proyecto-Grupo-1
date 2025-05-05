<%-- 
    Document   : header_administrador
    Created on : 1 may. 2025, 03:24:28
    Author     : DIEGO DAMIAN
--%>


<!DOCTYPE html>
<html>
    <head>
        
        <title>Panel de Administrador</title>
        <!-- Bootstrap 5 CSS CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

                        <!-- Carrusel -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin_carrusel.jsp">CARRUSEL</a>
                        </li>

                        <!-- Categorías -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin_categorias.jsp">CATEGORÍA</a>
                        </li>

                        <!-- Roles -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin_roles.jsp">ROLES</a>
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
        <jsp:include page="../INCLUDE/footer.jsp" />
    </body>
</html>

