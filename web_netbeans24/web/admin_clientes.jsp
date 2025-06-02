<%@page import="java.util.ArrayList"%>
<%@page import="BusinessLogic.ClientesBL"%>
<%@page import="BusinessLogic.ClientesBL"%>
<%@page import="BusinessEntify.ClientesBE"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%       
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;
    
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
        <title>Crud de clientes</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
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
            <div class="card">
                <div class="card-header">
                    <h3 class="title text-center align-middle mt-2">Clientes Registrados</h3>
                </div>
                <div class="card-body">
                    <a class="btn btn-success btn-sm mb-3" href="edit_clientes.jsp?accion=NEW>"><i class="fa fa-plus fa-fw"></i></a>  
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead class="thead-dark">
                                <tr class="text-center align-middle">
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
                                <tr class="text-center align-middle">
                                    <td class="d-block justify-content-center gap-2"> 
                                        <a class="btn btn-danger btn-sm mb-2 mt-2" href="javascript:void(0);" onclick="confirmarEliminacion(<%= c.getId_cliente()%>)"><i class="fa fa-trash fa-fw"></i></a>
                                        <a class="btn btn-success btn-sm mb-2 mt-2" href="edit_clientes.jsp?accion=UPDATE&code=<%= c.getId_cliente()%>"><i class="fa fa-pencil fa-fw"></i></a>  
                                    </td>
                                    <td class="align-middle"><%= c.getId_cliente()%></td>
                                    <td class="align-middle"><%= c.getTelefono()%></td>
                                    <td class="align-middle"><%= c.getDireccion()%></td>
                                    <td class="align-middle"><%= c.getEmpresa()%></td>
                                    <td class="align-middle"><%= c.getTipo()%></td>
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
                </div>
            </div>
        </section>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
