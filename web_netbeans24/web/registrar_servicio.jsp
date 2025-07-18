<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, BusinessEntify.ServiciosBE" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Servicio</title>
</head>
<body>
    <h2>Registrar nuevo servicio</h2>
    <form action="ServiciosServlet" method="post">
        <label>Categoría (ID):</label>
        <input type="number" name="id_categoria" required><br>

        <label>Nombre del Servicio:</label>
        <input type="text" name="nombre_servicio" required><br>

        <label>Descripción:</label>
        <textarea name="descripcion" required></textarea><br>

        <label>Precio Base:</label>
        <input type="number" step="0.01" name="precio_base" required><br>

        <label>Duración Estimada (días):</label>
        <input type="number" name="duracion_estimada" required><br>

        <label>Imagen (URL o nombre):</label>
        <input type="text" name="imagen"><br>

        <input type="submit" value="Registrar">
    </form>

    <hr>
    <h2>Servicios Registrados</h2>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Categoría</th>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Duración</th>
                <th>Imagen</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<ServiciosBE> listaServicios = (List<ServiciosBE>) request.getAttribute("listaServicios");
                if (listaServicios != null) {
                    for (ServiciosBE s : listaServicios) {
            %>
            <tr>
                <td><%= s.getId_servicio() %></td>
                <td><%= s.getId_categoria() %></td>
                <td><%= s.getNombre_servicio() %></td>
                <td><%= s.getDescripcion() %></td>
                <td><%= s.getPrecio_base() %></td>
                <td><%= s.getDuracion_estimada() %></td>
                <td><%= s.getImagen() %></td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
