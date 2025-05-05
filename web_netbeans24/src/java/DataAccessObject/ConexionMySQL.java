/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataAccessObject;

/**
 *
 * @author DIEGO DAMIAN
 */




import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionMySQL {

    private final String url = "jdbc:mysql://localhost:3306/arquitectura";
    private final String user = "root";
    private final String password = "";

    public Connection getConexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println(" Conectado exitosamente a MySQL.");
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println(" Error: Driver JDBC no encontrado.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println(" Error de conexión a MySQL:");
            e.printStackTrace();
        }
        return null;
    }
}