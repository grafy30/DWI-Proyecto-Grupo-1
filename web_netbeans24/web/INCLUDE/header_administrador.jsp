<nav class="navbar navbar-expand-lg navbar-dark bg-gradient-admin shadow-sm py-3">
    <div class="container-fluid">
        <!-- Logo / Inicio + Ícono admin -->
        <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/listar_usuarios.jsp">
            <span class="bg-white rounded-circle p-1">
                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="#1976d2" class="bi bi-shield-lock" viewBox="0 0 16 16">
                    <path d="M5.5 9.995v1.505a2.5 2.5 0 1 0 5 0v-1.505"/>
                    <path d="M8 0c-.69 0-1.238.293-1.684.545A6.987 6.987 0 0 0 1.58 3.388a1.72 1.72 0 0 0-.58 1.248c0 7.38 5.073 10.485 6.14 10.922a1.05 1.05 0 0 0 .72 0c1.067-.437 6.14-3.543 6.14-10.922 0-.478-.21-.936-.58-1.248A6.987 6.987 0 0 0 9.684.545C9.238.293 8.69 0 8 0z"/>
                </svg>
            </span>
            <span class="fw-bold fs-5 text-white">Admin</span>
        </a>

        <!-- Botón hamburguesa -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar"
                aria-controls="adminNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <!-- Clientes -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/listar_clientes.jsp">Clientes</a>
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
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout.jsp">Cerrar Sesión</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>