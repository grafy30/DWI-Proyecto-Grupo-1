package DataAccessObject;
import java.sql.DriverManager;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.sql.Connection;

public class ConexionMySQL {
    private String StrConxMySQL="jdbc:mysql://localhost:3306/consultoria_arquitectura";
    private String StrUserMySQL="root";
    private String StrPassMySQL="Primavera123#";
    private Connection conexion; //Null
    
    public static void main(String [] args){
        ConexionMySQL cn = new ConexionMySQL();
    }
    
    public ConexionMySQL() {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            DriverManager.setLoginTimeout(300);
            //Creacion 
            conexion = DriverManager
                    .getConnection(StrConxMySQL, StrUserMySQL, StrPassMySQL);
            if(conexion != null){
                DatabaseMetaData dm = conexion.getMetaData();
                System.out.println("Product Name:" + dm.getDatabaseProductName());
                System.out.println("Product version:" + dm.getDatabaseProductVersion());
            }
        }catch(ClassNotFoundException | SQLException e){
            System.out.println(e.getMessage());
        }
    }

    public Connection getConexion() {
        return conexion;
    }
    
}
