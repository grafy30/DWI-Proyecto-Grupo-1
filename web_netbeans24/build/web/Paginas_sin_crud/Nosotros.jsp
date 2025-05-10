<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Arqui Peru-Nosotros</title>
        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">        
        <link rel="stylesheet" href="../css/templatemo.css">
        <link rel="stylesheet" href="../css/style.css">

    </head>
<body>
    
    <jsp:include page="../INCLUDE/header.jsp"/>  
    

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
