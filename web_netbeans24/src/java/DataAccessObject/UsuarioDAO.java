package DataAccessObject;
import java.sql.ResultSet;
import BusinessEntify.UsuariosBE;
import java.sql.PreparedStatement;
import java.util.ArrayList;

public class UsuarioDAO extends ConexionMySQL
        implements IBaseDAO<UsuariosBE> {

    @Override
    public boolean Create(UsuariosBE input) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public UsuariosBE Read(String input) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<UsuariosBE> ReadAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean Update(UsuariosBE input) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean Delete(String input) {
        boolean result = false;
        try {
            PreparedStatement pst
                    = getConexion().prepareStatement("DELETE FROM Usuarios WHERE id_usuario=?");
            pst.setString(1, input);
            result = pst.execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    public UsuariosBE login(String nickname, String password) {
        UsuariosBE user = null;
        try {
            String sql = "SELECT * FROM usuarios WHERE nickname=? AND password=?";
            PreparedStatement pst = getConexion().prepareStatement(sql);
            pst.setString(1, nickname);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                user = new UsuariosBE();
                user.setId_usuario(rs.getInt("id_usuario"));
                user.setUsuario(rs.getString("nickname"));
                user.setPassword(rs.getString("password"));
                user.setRol(rs.getString("rol"));
                
            }
            rs.close();
            pst.close();
            getConexion().close();
        } catch (Exception e) {
            System.out.println("Error en login: " + e.getMessage());
        }
        return user;
    }
}
