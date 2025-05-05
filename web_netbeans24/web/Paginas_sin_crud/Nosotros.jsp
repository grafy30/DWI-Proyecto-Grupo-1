<%-- 
    Document   : Nosotros
    Created on : 3 may. 2025, 20:30:17
    Author     : DIEGO DAMIAN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barra de Navegación</title>
    
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    

    
    <style>
        
        .contenedor {
            width: 80%;
            margin: 0 auto;
        }

        .contenido-nosotros {
            display: flex;
            justify-content: space-between;
            margin-top: 50px;
        }
        .contenedor h1 {
            text-align: center;
        }
        .texto-nosotros blockquote {
            font-size: 1.5em;
            font-weight: bold;
            color: #0066cc;
            text-align: center;
            
        }

        .imagen {
            width: 50%;
        }

        .imagen img {
            width: 100%;
            height: auto;
            border-radius: 10px;
        }

        .box-nosotros {
            width: 45%;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .texto-nosotros {
            font-family: Arial, sans-serif;
            color: #333;
        }

        .texto-nosotros blockquote {
            font-size: 1.5em;
            font-weight: bold;
            color: #0066cc;
        }

        .texto-nosotros span {
            font-size: 1em;
            color: #444;
        }

        .content-sau {
            background: #f4f4f4;
            padding: 40px 0;
        }

        .titulo-muestra {
            text-align: center;
            font-size: 2em;
            margin-bottom: 40px;
            color: #333;
        }

        .contenedor-anuncios {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .anuncio {
            width: 30%;
            margin: 20px 0;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .anuncio img {
            width: 100%;
            height: auto;
        }

        .contenido-anuncio {
            padding: 20px;
        }

        .contenido-anuncio h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .contenido-anuncio .precio {
            font-size: 1.2em;
            color: #0066cc;
            margin-bottom: 15px;
        }

        .boton {
            display: inline-block;
            background-color: #0066cc;
            color: white;
            padding: 10px 20px;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }

        .boton:hover {
            background-color: #004d99;
        }
    </style>
</head>
<body>
    <!-- navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <!-- Botón hamburguesa -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar"
                    aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Logo / Inicio -->
            <a class="navbar-brand" href="${pageContext.request.contextPath}/welcome.jsp">INICIO</a>

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
                    
                    <!-- Otros enlaces -->
                    <li class="nav-item">
                        <a class="nav-link" href="Contacto.jsp">CONTACTO</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Nosotros.jsp">NOSOTROS</a>
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

    <!-- Nosotros -->
    <main class="contenedor">
        <h1>Conoce mas sobre Nosotros</h1>

        <div class="contenido-nosotros">
            <div class="imagen">
                <img src="${pageContext.request.contextPath}/imagenes/panel_nosotros.jpg" height="810px" alt="Imagen animada">
            </div>
            <div class="box-nosotros">
                <div class="texto-nosotros">
                    <blockquote>25 Años de Experiencia</blockquote>
                    <span>Soy Allen Reich, el creador de la plataforma definitiva para el arte visual inspirado en el anime...</span>
                </div>
            </div>
        </div>
    </main>

  
    <section class="content-sau">
        <h2 class="titulo-muestra">Imágenes de Muestra</h2>
        <div class="contenedor-anuncios">
            <div class="anuncio">
                <img src="${pageContext.request.contextPath}/imagenes/VISION.jpeg" alt="">
                <div class="contenido-anuncio">
                    <h3>"Ser líderes en el sector de la arquitectura, reconocidos por nuestra creatividad,
                        compromiso con la calidad y capacidad para adaptar tecnologías innovadoras a cada proyecto,
                        creando ambientes que inspiren y mejoren la calidad de vida de quienes los habitan."</h3>
                    <p class="precio">$1,000</p>
                    <a href="${pageContext.request.contextPath}/imagenes/VISION.jpeg" download class="boton boton-descargar d-block">Descargar Imagen</a>
                </div>
            </div>
            <div class="anuncio">
                <img src="${pageContext.request.contextPath}/imagenes/MISION.jpeg" alt="">
                <div class="contenido-anuncio">
                    <h3>"En ArquiDesk, nuestra misión es transformar ideas innovadoras en espacios funcionales y
                        estéticamente impactantes, brindando soluciones arquitectónicas de vanguardia que respondan
                        a las necesidades de nuestros clientes y contribuyan al desarrollo sostenible y urbano."</h3>
                    <p class="precio">$1,000</p>
                    <a href="${pageContext.request.contextPath}/imagenes/MISION.jpeg" download class="boton boton-descargar d-block">Descargar Imagen</a>
                </div>
            </div>
            <div class="anuncio">
                <img src="${pageContext.request.contextPath}/imagenes/VALOR.jpeg" alt="">
                <div class="contenido-anuncio">
                    <h3>-Innovación: Integramos diseño y tecnología de manera creativa.
                    -Compromiso: Cumplimos con las expectativas de nuestros clientes con ética.
                    -Sostenibilidad: Priorizamos prácticas respetuosas con el medio ambiente.
                    -Creatividad: Cada diseño es único y personalizado.
                    -Calidad: Superamos los estándares en cada etapa del proyecto.</h3>
                    <p class="precio">$1,000</p>
                    <a href="${pageContext.request.contextPath}/imagenes/VALOR.jpeg" download class="boton boton-descargar d-block">Descargar Imagen</a>
                </div>
            </div>
        </div>
                
              
    </section>
   
    <!-- Bootstrap JS (Popper.js incluido) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="../INCLUDE/footer.jsp" />
</body>
</html>
