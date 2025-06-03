package DataAccessObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import BusinessEntify.UsuariosBE;

public class UsuariosDAO extends ConexionMySQL implements IBaseDAO<UsuariosBE> {

    @Override
    public boolean Create(UsuariosBE input) {
        String sql = "INSERT INTO usuarios (nombres, nickname, password, rol) VALUES (?, ?, ?, ?)";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, input.getNombres());
            ps.setString(2, input.getUsuario());
            ps.setString(3, input.getPassword());
            ps.setString(4, input.getRol());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al crear usuario: " + e.getMessage());
            return false;
        }
    }

    @Override
    public UsuariosBE Read(String id) {
        UsuariosBE user = null;
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id)); // ✅ conversión segura
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new UsuariosBE();
                user.setId_usuario(rs.getInt("id_usuario"));
                user.setNombres(rs.getString("nombres"));
                user.setUsuario(rs.getString("nickname"));
                user.setPassword(rs.getString("password"));
                user.setRol(rs.getString("rol"));
            }

            rs.close();
        } catch (Exception e) {
            System.out.println("❌ Error al leer usuario: " + e.getMessage());
        }

        return user;
    }

    @Override
    public ArrayList<UsuariosBE> ReadAll() {
        ArrayList<UsuariosBE> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                UsuariosBE user = new UsuariosBE();
                user.setId_usuario(rs.getInt("id_usuario"));
                user.setNombres(rs.getString("nombres"));
                user.setUsuario(rs.getString("nickname"));
                user.setPassword(rs.getString("password"));
                user.setRol(rs.getString("rol"));
                lista.add(user);
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer todos los usuarios: " + e.getMessage());
        }

        return lista;
    }

    @Override
    public boolean Update(UsuariosBE input) {
        String sql = "UPDATE usuarios SET nombres = ?, nickname = ?, password = ?, rol = ? WHERE id_usuario = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, input.getNombres());
            ps.setString(2, input.getUsuario());
            ps.setString(3, input.getPassword());
            ps.setString(4, input.getRol());
            ps.setInt(5, input.getId_usuario());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al actualizar usuario: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String id) {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id)); // ✅ conversión segura
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }

    public UsuariosBE login(String nickname, String password) {
        UsuariosBE user = null;
        String sql = "SELECT * FROM usuarios WHERE nickname = ? AND password = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nickname);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new UsuariosBE();
                user.setId_usuario(rs.getInt("id_usuario"));
                user.setNombres(rs.getString("nombres"));
                user.setUsuario(rs.getString("nickname"));
                user.setPassword(rs.getString("password"));
                user.setRol(rs.getString("rol"));
            }

            rs.close();

        } catch (Exception e) {
            System.out.println("❌ Error en login: " + e.getMessage());
        }

        return user;
    }
}
