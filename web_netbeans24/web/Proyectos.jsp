<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, BusinessEntify.ProyectosBE, BusinessLogic.ProyectosBL, Util.ImagenUtils" %>
<%
    ProyectosBL proyectosBL = new ProyectosBL();
    List<ProyectosBE> lista = proyectosBL.ReadAll();
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Arqui Peru-Contacto</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>
        
        <!-- SECCION DE GALERIA -->
        <section class="proyectos">
            <h1>Proyectos</h1>
        </section>


        <section>
    <h1 class="galeria_titulo">Nuestros Proyectos</h1>
    <div class="gallery-container">
        <% for (ProyectosBE p : lista) { %>
            <div class="gallery-item">
                <% if (p.getImagen() != null) { %>
                    <img src="data:image/png;base64,<%= ImagenUtils.toBase64(p.getImagen()) %>" alt="Imagen Proyecto">
                <% } else { %>
                    <img src="imagenes/default.jpg" alt="Sin Imagen">
                <% } %>

                <div class="overlay">
                    <p class="description"><%= p.getNombre_proyecto() %></p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                <h2><%= p.getTitulo_proyecto() %></h2>
                <p><%= p.getDescripcion() %></p>
            </div>
        <% } %>
           
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="INCLUDE/footer.jsp" %>        
    </body>
</html>