<%@ page import="java.util.ArrayList" %>
<%@ page import="BusinessEntify.ContactosBE" %>
<%@ page import="BusinessLogic.ContactosBL" %>
<%@ page import="BusinessEntify.UsuariosBE" %>
<%@page import=" javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList<ContactosBE> mensajesAtendidos = (ArrayList<ContactosBE>) request.getAttribute("mensajesRespondidos");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mis mensajes respondidos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Mensajes respondidos</h2>

    <% if (mensajesAtendidos != null && !mensajesAtendidos.isEmpty()) { %>
        <div class="list-group">
            <% for (ContactosBE contacto : mensajesAtendidos) { %>
                <div class="list-group-item mb-3">
                    <h5 class="mb-1">Mensaje atendido</h5>
                    <p class="mb-1"><strong>Tu mensaje:</strong> <%= contacto.getMensaje() %></p>
                    <p class="mb-1 text-success"><strong>Respuesta:</strong> <%= contacto.getRespuesta() %></p>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <div class="alert alert-info">No tienes mensajes respondidos aún.</div>
    <% } %>

    <a href="welcome_usuario.jsp" class="btn btn-secondary mt-4">Volver</a>
</div>

</body>
</html>
