<%
    HttpSession sesion = request.getSession(false);
    String rol = (sesion != null) ? (String) sesion.getAttribute("rol") : null;
%>
<html>
    <head>    
        <title>Administrador</title>       
        <%@ include file="INCLUDE/header_links.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    </head>
    <body>   
        <%@ include file="INCLUDE/header_administrador.jsp" %>
        <section class="administrador text-center align-items-center mt-5">
            <h1>Bienvenido administrador</h1>
        </section>              
    </body>
    <!-- Scripts necesarios para Bootstrap para la hamburgesa-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
