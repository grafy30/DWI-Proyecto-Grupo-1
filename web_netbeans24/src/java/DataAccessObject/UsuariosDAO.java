package DataAccessObject;

import java.sql.*;
import java.util.ArrayList;
import BusinessEntify.UsuariosBE;

public class UsuariosDAO extends ConexionMySQL implements IBaseDAO<UsuariosBE> {

    @Override
    public boolean Create(UsuariosBE input) {
        String sql = "INSERT INTO usuarios (email, nickname, nombres, password, google_id, rol) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, input.getEmail());
            ps.setString(2, input.getNickname());
            ps.setString(3, input.getNombres());
            ps.setString(4, input.getPassword());
            ps.setString(5, input.getGoogle_id());
            ps.setString(6, input.getRol());

            boolean result = ps.executeUpdate() > 0;
            if (result) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    input.setId_usuario(rs.getInt(1));
                }
            }
            return result;

        } catch (Exception e) {
            System.out.println("❌ Error al crear usuario: " + e.getMessage());
            return false;
        }
    }

    // Crear usuario solo con Google (sin password ni nickname)
    public boolean createGoogle(UsuariosBE input) {
        String sql = "INSERT INTO usuarios (email, nombres, google_id, rol) VALUES (?, ?, ?, ?)";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, input.getEmail());
            ps.setString(2, input.getNombres());
            ps.setString(3, input.getGoogle_id());
            ps.setString(4, input.getRol());

            boolean result = ps.executeUpdate() > 0;
            if (result) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    input.setId_usuario(rs.getInt(1));
                }
            }
            return result;

        } catch (Exception e) {
            System.out.println("❌ Error al crear usuario Google: " + e.getMessage());
            return false;
        }
    }

    @Override
    public UsuariosBE Read(String id) {
        UsuariosBE user = null;
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = toEntity(rs);
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer usuario: " + e.getMessage());
        }
        return user;
    }

    @Override
    public ArrayList<UsuariosBE> ReadAll() {
        ArrayList<UsuariosBE> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(toEntity(rs));
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer todos los usuarios: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean Update(UsuariosBE input) {
        String sql = "UPDATE usuarios SET email = ?, nickname = ?, nombres = ?, password = ?, google_id = ?, rol = ? WHERE id_usuario = ?";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, input.getEmail());
            ps.setString(2, input.getNickname());
            ps.setString(3, input.getNombres());
            ps.setString(4, input.getPassword());
            ps.setString(5, input.getGoogle_id());
            ps.setString(6, input.getRol());
            ps.setInt(7, input.getId_usuario());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al actualizar usuario: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String id) {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }

    // ----------- Métodos adicionales para integración Google/email ----------
    public UsuariosBE findByEmail(String email) {
        UsuariosBE user = null;
        String sql = "SELECT * FROM usuarios WHERE email = ?";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new UsuariosBE();
                user.setId_usuario(rs.getInt("id_usuario"));
                user.setEmail(rs.getString("email"));
                user.setNombres(rs.getString("nombres"));
                user.setPassword(rs.getString("password"));
                user.setRol(rs.getString("rol"));
            }
            rs.close();
        } catch (Exception e) {
            System.out.println("Error en findByEmail: " + e.getMessage());
        }
        return user;
    }

    public UsuariosBE findByGoogleId(String googleId) {
        UsuariosBE user = null;
        String sql = "SELECT * FROM usuarios WHERE google_id = ?";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, googleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = toEntity(rs);
            }
        } catch (Exception e) {
            System.out.println("❌ Error en findByGoogleId: " + e.getMessage());
        }
        return user;
    }

    // Login clásico (puede ser email o nickname)
    public UsuariosBE login(String email, String password) {
        UsuariosBE user = null;
        String sql = "SELECT * FROM usuarios WHERE (email = ? OR nickname = ?) AND password = ?";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, email); // Permite login con nickname también si quieres
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = toEntity(rs);
            }
        } catch (Exception e) {
            System.out.println("❌ Error en login: " + e.getMessage());
        }
        return user;
    }

    private UsuariosBE toEntity(ResultSet rs) throws Exception {
        UsuariosBE user = new UsuariosBE();
        user.setId_usuario(rs.getInt("id_usuario"));
        user.setEmail(rs.getString("email"));
        user.setNickname(rs.getString("nickname"));
        user.setNombres(rs.getString("nombres"));
        user.setPassword(rs.getString("password"));
        user.setGoogle_id(rs.getString("google_id"));
        user.setRol(rs.getString("rol"));
        return user;
    }
}
