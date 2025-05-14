<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Arqui Peru-Contacto</title>
        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">        
        <link rel="stylesheet" href="../css/templatemo.css">
        <link rel="apple-touch-icon" sizes="180x180" href="../imagenes/favicon_io/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="../imagenes/favicon_io/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="../imagenes/favicon_io/favicon-16x16.png">
        <link rel="manifest" href="/site.webmanifest">
        <link rel="stylesheet" href="../css/style.css">

    </head>
<body>
    <jsp:include page="../INCLUDE/header.jsp"/>

  <section class="servicios">
    <h1>Servicios</h1>
  </section>

  <section class="intro">
    <h2>Nuestros Servicios</h2>
    <p>
      Contamos con una amplia experiencia y compromiso en el desarrollo de diseños y proyectos exclusivos, funcionales y de alta calidad, logrando superar las expectativas de nuestros clientes, causando gran satisfacción.
    </p>
  </section>

  <!-- Sección 1 -->
  <section class="content-block">
    <div class="text-block">
      <h3>Servicios Generales y mantenimientos</h3>
      <ul>
        <li>Construcción, ampliaciones y remodelaciones de oficinas, viviendas y comercios.</li>
        <li>Pintura de pared, metales, coberturas metálicas techos.</li>
        <li>Armado de Drywall, Cielos Rasos, baldosas de techo.</li>
        <li>Electricidad, cableado en general, tableros eléctricos certificados.</li>
        <li>Mantenimientos a pozo a tierra y sub estación.</li>
        <li>Gasfitería, red de agua y desagüe.</li>
        <li>Instalaciones electromecánicas AACC.</li>
        <li>Carpintería metálica y en melamina.</li>
        <li>Instalación de pisos cerámicos, vinílicos y de madera.</li>
      </ul>
    </div>
    <div class="image-block">
      <img src="../imagenes/Servicios_Generales.jpg" alt="Equipo de obra" />
    </div>
  </section>

  <!-- Sección 2 -->
  <section class="content-block reverse">
    <div class="text-block">
      <h3>Anteproyectos y Obras Civiles</h3>
      <ul>
        <li>Elaboración de Planos de Arquitectura, Eléctricos y Sanitarios.</li>
        <li>Elaboración de cronograma y presupuesto de obra.</li>
        <li>Levantamientos topográficos y estudios de suelo.</li>
        <li>Supervisión de obra.</li>
      </ul>
    </div>
    <div class="image-block">
      <img src="../imagenes/obras_civiles.jpg" alt="Planos de arquitectura" />
    </div>
  </section>

  <!-- Sección 3 -->
  <section class="content-block">
    <div class="text-block">
      <h3>Elaboración de Expedientes Técnicos en edificaciones (INDECI – DEFENSA CIVIL)</h3>
      <ul>
        <li>Inspecciones de Seguridad en edificaciones.</li>
        <li>Planos de ubicación, arquitectura, eléctricos, etc.</li>
        <li>Memorias descriptivas, análisis de riesgo, planes de contingencia.</li>
      </ul>
    </div>
    <div class="image-block">
      <img src="../imagenes/Planos.jpg" alt="Certificado Defensa Civil" />
    </div>
  </section>

  <!-- Sección 4 -->
  <section class="content-block reverse">

    <div class="text-block">
      <h3>Tasaciones</h3>
      <ul>
        <li>Inmuebles, maquinarias y equipos.</li>
        <li>Bienes muebles para fines comerciales, judiciales o administrativos.</li>
        <li>Realizadas por peritos certificados bajo el Reglamento Nacional de Tasaciones.</li>
      </ul>
    </div>
    <div class="image-block">
      <img src="../imagenes/tasacion.jpg" alt="Tasaciones técnicas" />
    </div>
  </section>
  
    <!-- Bootstrap JS (Popper.js incluido) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="../INCLUDE/footer.jsp" />
</body>
</html>
