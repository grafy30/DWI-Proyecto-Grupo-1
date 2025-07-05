<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BusinessEntify.ContactosBE" %>
<%
    ContactosBE contacto = (ContactosBE) request.getAttribute("contacto");
    if (contacto == null) {
        response.sendRedirect("solicitudes_contacto.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Revisar Mensaje</title>
    <%@ include file="INCLUDE/header_links.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@ include file="INCLUDE/header_administrador.jsp" %>

<div class="container mt-4">
    <div class="form-card full-width">
        <h3 class="form-title">Revisar Mensaje de Contacto</h3>

        <div class="mb-3">
            <label><strong>Nombre:</strong></label>
            <p><%= contacto.getNombre() %></p>
        </div>

        <div class="mb-3">
            <label><strong>Correo:</strong></label>
            <p><%= contacto.getCorreo() %></p>
        </div>

        <div class="mb-3">
            <label><strong>Fecha:</strong></label>
            <p><%= contacto.getFecha_contacto() %></p>
        </div>

        <div class="mb-3">
            <label><strong>Mensaje:</strong></label>
            <div class="border rounded p-3 bg-light" style="max-height: 250px; overflow-y: auto;">
                <%= contacto.getMensaje() %>
            </div>
        </div>

        <!-- Formulario para responder -->
        <form method="POST" action="${pageContext.request.contextPath}/ContactoServlet">
            <input type="hidden" name="accion" value="responder">
            <input type="hidden" name="idContacto" value="<%= contacto.getId_contacto()%>">
            <input type="hidden" name="correoDestino" value="<%= contacto.getCorreo()%>">

            <div class="mb-3">
                <label><strong>Tu Respuesta:</strong></label>
                <textarea name="respuesta" class="form-control" rows="6" placeholder="Escribe tu respuesta aquí..." required></textarea>
            </div>

            <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-success btn-sm">
                    <i class="fas fa-paper-plane"></i> Atendido
                </button>
            </div>
        </form>
    </div>
<
