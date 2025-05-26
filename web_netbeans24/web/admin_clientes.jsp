<%@page import="BusinessEntify.ClientesBE"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crud de clientes</title>
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
    <%@ include file="INCLUDE/header_administrador.jsp" %>
        <section class="administrador">
        <h2>Tabla de clientes</h2>
        <p>Aquí puedes ver y gestionar a los clientes.</p>
        </section>
<!-- Tabla de Clientes -->
<section class="clientes-lista">
    <h3>Clientes Registrados</h3>
    <table border="1">
        <thead>
            <tr>
                <th>ID Cliente</th>
                <th>Teléfono</th>
                <th>Dirección</th>
                <th>Empresa</th>
                <th>Tipo Cliente</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (listaClientes != null && !listaClientes.isEmpty()) {
                    for (ClientesBE c : listaClientes) {
            %>
                <tr>
                    <td><%= c.getId_cliente()%></td>
                    <td><%= c.getTelefono() %></td>
                    <td><%= c.getDireccion() %></td>
                    <td><%= c.getEmpresa() %></td>
                    <td><%= c.getTipocliente()%></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="5">No hay clientes registrados.</td></tr>
            <%
                }
            %>
        </tbody>
    </table>
</section>
            <tbody>

    
    <%@ include file="INCLUDE/footer.jsp" %>
</body>
</html>
