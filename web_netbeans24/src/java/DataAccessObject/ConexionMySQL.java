package DataAccessObject;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionMySQL {
    private final String URL = "jdbc:mysql://localhost:3306/consultoria_arquitectura?useUnicode=true&characterEncoding=utf8";
    private final String USER = "root";
    private final String PASS = "admin1234";

    public ConexionMySQL() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Solo necesario una vez
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontró el driver MySQL: " + e.getMessage());
        }
    }

    // Cada vez que se llama, retorna una nueva conexión (¡mejor para web!)
    public Connection getConexion() {
        try {
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (SQLException e) {
            System.out.println("Error al obtener conexión MySQL: " + e.getMessage());
            return null;
        }
    }

    // Para pruebas directas desde main:
    public static void main(String[] args) {
        ConexionMySQL con = new ConexionMySQL();
        Connection c = con.getConexion();
        if (c != null) {
            System.out.println("¡Conexión exitosa!");
            try { c.close(); } catch (SQLException e) { }
        } else {
            System.out.println("Fallo al conectar.");
        }
    }
}
