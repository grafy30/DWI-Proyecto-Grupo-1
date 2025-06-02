<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Arqui Peru-Contacto</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>
        
        <section class="contactanos">
            <h1>Contactanos</h1>
        </section>
        <section class="intro">
            <h2>Servicio al Usuario</h2>
            <p>
                Cualquier consulta, dejanos en mensaje, lo responderemos lo mas pronto posible.
            </p>
        </section>

        <div class="container contact-section">

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
        <% }%>        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="INCLUDE/footer.jsp" %>
    </body>
</html>
