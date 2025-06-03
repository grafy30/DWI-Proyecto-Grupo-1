<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel_usuario</title>
    </head>
    <body>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">

                <a class="navbar-brand" href="#">ADMIN PANEL</a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar"
                        aria-controls="adminNavbar" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="adminNavbar">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                        <!-- Menú exclusivo para administrador ya logueado -->
                        <li class="nav-item">
                            <a class="nav-link" href="#">Información del Usuario</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Estado de Actividad</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Seguimiento de Reporte</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Perfil (Foto)</a>
                        </li>

                        <!-- Submenú de Bandeja de Mensajes -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="mensajesDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                Bandeja de Mensajes
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="mensajesDropdown">
                                <li><a class="dropdown-item" href="#">Enviados</a></li>
                                <li><a class="dropdown-item" href="#">Recibidos</a></li>
                                <li><a class="dropdown-item" href="#">Todos</a></li>
                            </ul>
                        </li>


                    </ul>
                </div>
            </div>
        </nav>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>

