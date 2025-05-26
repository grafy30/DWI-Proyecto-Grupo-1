<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://kit.fontawesome.com/738f0ba9e9.js" ></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">        
        <link rel="stylesheet" href="css/templatemo.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="apple-touch-icon" sizes="180x180" href="imagenes/favicon_io/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="imagenes/favicon_io/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="imagenes/favicon_io/favicon-16x16.png">
        <link rel="manifest" href="/site.webmanifest">
    </head>
    <body>
            <!-- Start Top Nav -->
 
        <nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top">
            <div class="container text-light">
                <div class="w-100 d-flex justify-content-between">
                    <div>
                        <i class="fa fa-envelope mx-2"></i>
                        <a class="navbar-sm-brand text-light text-decoration-none" href="mailto:info@company.com">info@company.com</a>
                        <i class="fa fa-phone mx-2"></i>
                        <a class="navbar-sm-brand text-light text-decoration-none" href="tel:+51 914088112">+51 914088112</a>
                    </div>
                    <div>
                        <a class="text-light" href="https://fb.com/templatemo" target="_blank" rel="sponsored"><i class="fab fa-facebook-f fa-sm fa-fw me-2"></i></a>
                        <a class="text-light" href="https://www.instagram.com/" target="_blank"><i class="fab fa-instagram fa-sm fa-fw me-2"></i></a>
                        <a class="text-light" href="https://twitter.com/" target="_blank"><i class="fab fa-twitter fa-sm fa-fw me-2"></i></a>
                        <a class="text-light" href="https://www.linkedin.com/" target="_blank"><i class="fab fa-linkedin fa-sm fa-fw"></i></a>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Close Top Nav -->


        <!-- Header -->
        <nav class="navbar navbar-expand-lg navbar-light shadow">
            <div class="container d-flex justify-content-between align-items-center">

                <a class="navbar-brand text-success logo h1 align-self-center" href="index.html">
                    Arqui-Peru
                </a>

                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                    <div class="flex-fill">
                        <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/Paginas_sin_crud/Nosotros.jsp">Nosotros</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/Paginas_sin_crud/Servicios.jsp" id="serviciosDropdown" role="button"
                                    accesskey=""data-bs-toggle="dropdown" aria-expanded="false">Servicios</a>
                                <ul class="dropdown-menu" aria-labelledby="serviciosDropdown">
                                    <li><a class="dropdown-item" href="../htmls/Construcción_de_Obras_Civiles.html">Asesoría en Diseño de Pequeños Espacios</a></li>
                                    <li><a class="dropdown-item" href="../htmls/Diseño_y_Construccion_3D_BIM.html">Tramitación de Licencias Municipales</a></li>
                                    <li><a class="dropdown-item" href="../htmls/Proyectos_Inmobiliarios.html">Consultoría en Eficiencia Energética</a></li>
                                    <li><a class="dropdown-item" href="../htmls/Saneamiento_Fisico_Legal_de_Predios.html"> Diseño de Fachadas y Home Staging</a></li>
                                    <li><a class="dropdown-item" href="../htmls/Topografía.html">Consultoría para la selección de materiales y acabados</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/Paginas_sin_crud/Proyectos.jsp">Proyectos</a>
                            </li>                            
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/Paginas_sin_crud/Contacto.jsp">Contacto</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                            </li>
                        </ul>
                    </div>                    
                </div>
            </div>
        </nav>
    </body>
</html>
