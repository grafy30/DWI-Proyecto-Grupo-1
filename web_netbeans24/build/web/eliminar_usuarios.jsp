<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>

<% 
       if (request.getMethod().equals("POST")) {
           int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
           Connection con = null;
           PreparedStatement ps = null;

           try {
               Class.forName("com.mysql.jdbc.Driver");
               con = DriverManager.getConnection("jdbc:mysql://localhost:3306/consultoria_arquitectura", "root", "");

               String query = "DELETE FROM usuarios WHERE id_usuario = ?";
               ps = con.prepareStatement(query);
               ps.setInt(1, idUsuario);
               ps.executeUpdate();

               // Redireccionar o mostrar mensaje de éxito
response.sendRedirect(request.getContextPath() + "/listar_roles.jsp");

           } catch (ClassNotFoundException | SQLException e) {
               out.println("Error al eliminar usuario: " + e.getMessage());
           } finally {
               try {
                   if (ps != null) ps.close();
                   if (con != null) con.close();
               } catch (SQLException e) {
                   out.println("Error al cerrar la conexión: " + e.getMessage());
               }
           }
       }
%>