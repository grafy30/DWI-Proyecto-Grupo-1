<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="BusinessEntify.UsuariosBE" %>
<%
    UsuariosBE user = (UsuariosBE) session.getAttribute("usuarioCompleto");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nuevo Mensaje</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white">
                <h4>Nuevo Mensaje</h4>
            </div>
            <div class="card-body">
                <form action="ContactoServlet" method="post">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre completo</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%= user.getNombre_completo() %>" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" id="correo" name="correo" value="<%= user.getEmail() %>" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="asunto" class="form-label">Asunto</label>
                        <input type="text" class="form-control" id="asunto" name="asunto" required>
                    </div>
                    <div class="mb-3">
                        <label for="mensaje" class="form-label">Mensaje</label>
                        <textarea class="form-control" id="mensaje" name="mensaje" rows="5" required></textarea>
                    </div>
                    <input type="hidden" name="id_usuario" value="<%= user.getId_usuario() %>">
                    <button type="submit" class="btn btn-success">Enviar</button>
                    <a href="welcome_usuario.jsp" class="btn btn-secondary ms-2">Cancelar</a>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS opcional -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
