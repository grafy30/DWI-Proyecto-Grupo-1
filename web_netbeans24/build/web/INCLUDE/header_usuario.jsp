
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="inicio_usuario.jsp">
            <i class="fas fa-user-shield me-2"></i>Mi Panel
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="userNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <!-- Servicios disponibles -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/diseño_usuario.jsp">
                        <i class="fas fa-list-alt me-1"></i> Servicios
                    </a>
                </li>

                <!-- Mis servicios contratados -->
                <li class="nav-item dropdown">
                    <a class="nav-link" href="mis_servicios.jsp">
                        <i class="fas fa-clipboard-list me-1"></i> Mis Servicios
                        <span class="badge bg-danger rounded-pill ms-1">3</span>
                    </a>
                </li>

                <!-- Mensajes con indicador de no leídos -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="mensajeDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-envelope me-1"></i> Mensajes
                        <span class="badge bg-danger badge-notification">5</span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="mensajesDropdown">
                        <li><a class="dropdown-item" href="ContactoServlet">
                                <i class="fas fa-inbox me-2"></i>Bandeja de entrada
                                <span class="badge bg-primary float-end">5</span>
                            </a></li>
                        <li><a class="dropdown-item" href="mensajes.jsp?tipo=enviados">
                                <i class="fas fa-paper-plane me-2"></i>Enviados
                            </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="nuevo_mensaje.jsp">
                                <i class="fas fa-edit me-2"></i>Nuevo mensaje
                            </a></li>
                    </ul>
                </li>

                <!-- Soporte/contacto -->
                <li class="nav-item">
                    <a class="nav-link" href="soporte.jsp">
                        <i class="fas fa-headset me-1"></i> Soporte
                    </a>
                </li>
            </ul>       
            <!-- Cierre de sesión o Perfil -->
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Cuenta Usuario
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Perfil.jsp"> <i class="fas fa-user-circle me-2"></i>Mi Perfil</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i>Configuración</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout.jsp"> <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
