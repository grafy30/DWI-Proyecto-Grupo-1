<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Arqui-Peru-Registrarse</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
    </head>
    <body>
        <%@ include file="INCLUDE/header.jsp" %>
        <div class="form-container">
            <div class="card-form">
                <h3 class="text-center mb-4">Registrarse</h3>
                <form action="${pageContext.request.contextPath}/UsuarioServlet" method="post">
                    <input type="hidden" name="accion" value="registrar">
                    <div class="mb-3">
                        <label for="username" class="form-label">Usuario</label>
                        <input type="text" class="form-control" id="usuario" name="usuario" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="nombres" class="form-label">Nombres</label>
                        <input type="text" class="form-control" id="nombres" name="nombres" required>
                    </div>

                    <button type="submit" class="btn btn-submit">Registrarse</button>
                </form>

            </div>
        </div>     
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="INCLUDE/footer.jsp" %>
    </body>
</html>
