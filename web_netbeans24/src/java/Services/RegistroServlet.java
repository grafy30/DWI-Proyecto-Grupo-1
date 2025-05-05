/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Services;

import DataAccessObject.ConexionMySQL;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        String genero = request.getParameter("genero");
        String rol = request.getParameter("rol"); // Se puede usar 'Usuario' como default

        try {
            ConexionMySQL con = new ConexionMySQL();
            Connection conexion = con.getConexion();

            PreparedStatement pst = conexion.prepareStatement(
                    "INSERT INTO usuarios (usuario, password, rol, genero) VALUES (?, ?, ?, ?)");
            pst.setString(1, usuario);
            pst.setString(2, password);
            pst.setString(3, rol);
            pst.setString(4, genero);
            pst.executeUpdate();

            response.sendRedirect("login.jsp?registro=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registrar.jsp?error=1");
        }
    }
}