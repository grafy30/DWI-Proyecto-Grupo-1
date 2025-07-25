<%@page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="BusinessEntify.ContactosBE" %>
<%@ page import="BusinessLogic.ContactosBL" %>
<%@ page import="BusinessEntify.UsuariosBE" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UsuariosBE usuario = (UsuariosBE) session.getAttribute("usuarioCompleto");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<ContactosBE> pendientes = (List<ContactosBE>) request.getAttribute("pendientes");
    List<ContactosBE> atendidos = (List<ContactosBE>) request.getAttribute("atendidos");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mis mensajes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="container mt-5">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>📬 Mis mensajes</h2>
                <a href="welcome_usuario.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
            </div>

            <!-- Sección Pendientes -->
            <h4 class="mb-3">🕓 Pendientes</h4>
            <div class="row row-cols-1 row-cols-md-2 g-4 mb-5">
                <% if (pendientes != null && !pendientes.isEmpty()) {
                        for (ContactosBE c : pendientes) {%>
                <div class="col">
                    <div class="card border-warning shadow">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-user"></i> <%= c.getNombre()%></h5>
                            <p class="card-text"><strong>Mensaje:</strong> <%= c.getMensaje()%></p>
                            <span class="badge bg-warning text-dark">Pendiente</span>
                        </div>
                        <div class="card-footer text-end">
                            <form action="ElmMenU" method="post" class="d-inline">
                                <input type="hidden" name="id_contacto" value="<%= c.getId_contacto()%>">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash-alt"></i> Eliminar
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <%   }
                } else { %>
                <div class="col">
                    <div class="alert alert-info text-center" role="alert">
                        No hay mensajes pendientes.
                    </div>
                </div>
                <% } %>
            </div> <!-- cierre de row de pendientes -->

            <!-- Sección Atendidos -->
            <h4 class="mb-3">✅ Atendidos</h4>
            <div class="row row-cols-1 row-cols-md-2 g-4">
                <% if (atendidos != null && !atendidos.isEmpty()) {
                        for (ContactosBE c : atendidos) {%>
                <div class="col">
                    <div class="card border-success shadow">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-user-check"></i> <%= c.getNombre()%></h5>
                            <p class="card-text"><strong>Mensaje:</strong> <%= c.getMensaje()%></p>
                            <p class="card-text text-success"><strong>Respuesta:</strong> <%= c.getRespuesta()%></p>
                            <span class="badge bg-success">Atendido</span>
                        </div>
                        <div class="card-footer text-end">
                            <form action="ElmMenU" method="post" class="d-inline">
                                <input type="hidden" name="id_contacto" value="<%= c.getId_contacto()%>">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash-alt"></i> Eliminar
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <%   }
                } else { %>
                <div class="col">
                    <div class="alert alert-info text-center" role="alert">
                        No hay mensajes atendidos.
                    </div>
                </div>
                <% }%>
            </div> <!-- cierre de row de atendidos -->

        </div>

    </body>
</html>
