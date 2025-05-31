<%@page import="java.util.ArrayList"%>
<%@page import="BusinessLogic.ClientesBL"%>
<%@page import="BusinessLogic.ClientesBL"%>
<%@page import="BusinessEntify.ClientesBE"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //scriptlet 
    ClientesBL cli = new ClientesBL();

    String accion = request.getParameter("accion");
    String id = request.getParameter("code");
    if ("DELETE".equals(accion)) {
        cli.Delete(id);
        System.out.println("que paso");
    }

    ArrayList<ClientesBE> listaClientes = cli.ReadAll();
%>
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

        <!-- SweetAlert2 para mejores diálogos -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            function confirmarEliminacion(idCliente) {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: "No podrás revertir esto.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sí, eliminar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'admin_clientes.jsp?accion=DELETE&code=' + idCliente;
                    }
                });
            }
        </script>
    </head>
    <body>   
        <%@ include file="INCLUDE/header_administrador.jsp" %>

        <!-- Tabla de Clientes -->
        <section class="clientes-lista container mt-4 mb-5">
            <h3 class="text-center mb-4">Clientes Registrados</h3>
            <a class="btn btn-success btn-sm" href="edit_clientes.jsp?accion=NEW>"><i class="fa fa-plus fa-fw"></i></a>  
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th> </th>
                            <th scope="col">ID Cliente</th>
                            <th scope="col">Teléfono</th>
                            <th scope="col">Dirección</th>
                            <th scope="col">Empresa</th>
                            <th scope="col">Tipo Cliente</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listaClientes != null && !listaClientes.isEmpty()) {
                                for (ClientesBE c : listaClientes) {
                        %>
                        <tr>
                            <td> 
                                <a class="btn btn-danger btn-sm" href="javascript:void(0);" onclick="confirmarEliminacion(<%= c.getId_cliente()%>)"><i class="fa fa-trash fa-fw"></i></a>
                                <a class="btn btn-success btn-sm" href="edit_clientes.jsp?accion=UPDATE&code=<%= c.getId_cliente()%>"><i class="fa fa-pencil fa-fw"></i></a>  
                            </td>
                            <td><%= c.getId_cliente()%></td>
                            <td><%= c.getTelefono()%></td>
                            <td><%= c.getDireccion()%></td>
                            <td><%= c.getEmpresa()%></td>
                            <td><%= c.getTipo()%></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center text-muted">No hay clientes registrados.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </section>

        <%@ include file="INCLUDE/footer.jsp" %>
    </body>
</html>
