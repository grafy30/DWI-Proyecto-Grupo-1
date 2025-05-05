/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BusinessLogic;

/**
 *
 * @author DIEGO DAMIAN
 */



import BusinessEntify.UsuariosBE;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuariosBL {
    public UsuariosBE Read(String username) {
        UsuariosBE usuario = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/anime", "root", "");

            String sql = "SELECT * FROM usuario WHERE usuario = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new UsuariosBE();
                usuario.setId(rs.getInt("id_usuario"));
                usuario.setUserName(rs.getString("usuario"));
                usuario.setPasswd(rs.getString("password"));
                usuario.setUserRol(rs.getString("rol"));
                usuario.setUserGenero(rs.getString("genero")); 
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuario;
    }
}
