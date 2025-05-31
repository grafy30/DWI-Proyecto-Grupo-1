<%@page import="BusinessEntify.ClientesBE"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BusinessLogic.ClientesBL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //scriptlet 
    ClientesBL cli=new ClientesBL();
    ArrayList <ClientesBE> lista= cli.ReadAll();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista Clientes</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <table>            
            <%for (int i = 0; i <lista.size(); i++) {%>
            <tr>
                <td><%=lista.get(i).getId_cliente() %></td>
                <td><%=lista.get(i).getDireccion() %></td>
                <td><%=lista.get(i).getEmpresa()%></td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
