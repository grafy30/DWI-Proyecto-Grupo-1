/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Services;



import DataAccessObject.ConexionMySQL;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        try {
            ConexionMySQL con = new ConexionMySQL();
            Connection conexion = con.getConexion();
            PreparedStatement pst = conexion.prepareStatement(
                    "SELECT * FROM usuarios WHERE usuario=? AND password=?");
            pst.setString(1, usuario);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String rol = rs.getString("rol");
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                session.setAttribute("rol", rol);

                if ("Administrador".equalsIgnoreCase(rol)) {
                    response.sendRedirect("INCLUDE/header_administrador.jsp");
                } else {
                    response.sendRedirect("INCLUDE/header_cliente.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=1");
            }

            conexion.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2");
        }
    }
}
