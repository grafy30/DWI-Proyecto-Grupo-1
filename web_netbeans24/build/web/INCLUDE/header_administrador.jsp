<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Botón hamburguesa -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar"
                aria-controls="adminNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Logo / Inicio -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/listar_roles.jsp">Admin</a>

        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <!-- Clientes -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin_clientes.jsp">Clientes</a>
                </li>

                <!-- Servicios -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin_servicios.jsp">Servicios</a>
                </li>

                <!-- Proyectos -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin_proyectos.jsp">Proyectos</a>
                </li>

                <!-- Solicitudes -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin_solicitudes.jsp">Solicitudes</a>
                </li>
            </ul>

            <!-- Cierre de sesión o Perfil -->
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Administrador
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                        <li><a class="dropdown-item" href="#">Mi Perfil</a></li>
                        <li><a class="dropdown-item" href="#">Configuración</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li> <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout.jsp">Cerrar Sesión</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

