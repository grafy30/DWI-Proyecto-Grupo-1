<%-- 
    Document   : Contacto
    Created on : 3 may. 2025, 20:30:40
    Author     : DIEGO DAMIAN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contacto</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --rojo: #E50914;
            --fondo: black;
        }

        body {
            background: var(--fondo);
            color: white;
            font-family: 'Open Sans', sans-serif;
        }

        .form-control,
        .form-control:focus,
        textarea.form-control {
            background-color: #333;
            color: white;
            border: 1px solid #aaa;
        }

        .form-btn {
            background-color: var(--rojo);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .form-btn:hover {
            background-color: #ff1f3d;
        }

        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.8);
            color: #fff;
            padding: 20px;
            border-radius: 10px;
            display: none;
            z-index: 9999;
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
            border-radius: 10px;
        }

        .h2, .h3 {
            color: white;
        }

        .contact-section {
            margin-top: 30px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/welcome.jsp">INICIO</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/Paginas_sin_crud/Contacto.jsp">CONTACTO</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Paginas_sin_crud/Nosotros.jsp">NOSOTROS</a></li>
                <li class="nav-item"><a class="nav-link" href="#">PROYECTOS</a></li>
                <li class="nav-item"><a class="nav-link" href="#">ARTÍCULOS</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">LOGIN</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container contact-section">
    <h2 class="h2 text-center">Contáctanos</h2>
    <p class="text-center mb-4">
        Si tienes alguna pregunta o comentario, escríbenos.
    </p>

    <div class="row">
        <!-- Formulario -->
        <div class="col-md-6 mb-4">
            <h3 class="h3 mb-3">Formulario de Contacto</h3>
            <form action="${pageContext.request.contextPath}/ContactoServlet" method="POST">
                <div class="mb-3">
                    <input type="text" name="fullname" class="form-control" placeholder="Nombre completo" required>
                </div>
                <div class="mb-3">
                    <input type="email" name="email" class="form-control" placeholder="Correo electrónico" required>
                </div>
                <div class="mb-3">
                    <textarea name="message" class="form-control" rows="5" placeholder="Tu mensaje" required></textarea>
                </div>
                <button type="submit" class="form-btn">Enviar mensaje</button>
            </form>
        </div>

        <!-- Mapa -->
        <div class="col-md-6 mb-4">
            <h3 class="h3 mb-3">Ubicación</h3>
            <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3901.4825187431094!2d-77.04523012443754!3d-12.122121544091834!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105cd8b1bbdb31b%3A0x3d9abbb5e6d59d14!2sMiraflores%2C%20Lima%2015084%2C%20Per%C3%BA!5e0!3m2!1ses!2spe!4v1695831226450!5m2!1ses!2spe" 
                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        </div>
    </div>
</div>

<!-- Popup -->
<div id="popup" class="popup">
    <p>Mensaje Enviado</p>
</div>

<!-- Mostrar popup si ?enviado=true -->
<%
    String enviado = request.getParameter("enviado");
    if ("true".equals(enviado)) {
%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const popup = document.getElementById("popup");
        popup.style.display = "block";
        setTimeout(() => popup.style.display = "none", 3000);
    });
</script>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="../INCLUDE/footer.jsp" />
</body>
</html>
