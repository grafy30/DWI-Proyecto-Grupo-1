package DataAccessObject;

import BusinessEntify.ClientesBE;
import java.sql.*;
import java.util.ArrayList;

public class ClientesDAO extends ConexionMySQL implements IBaseDAO<ClientesBE> {

    @Override
    public boolean Create(ClientesBE input) {
        String query = "INSERT INTO clientes (id_usuario, telefono, direccion, empresa, tipo_cliente) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = getConexion(); PreparedStatement pst = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pst.setInt(1, input.getId_usuario()); // Debe estar seteado correctamente
            pst.setString(2, input.getTelefono());
            pst.setString(3, input.getDireccion());
            pst.setString(4, input.getEmpresa());
            pst.setString(5, input.getTipo_cliente());

            boolean result = pst.executeUpdate() > 0;
            if (result) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    input.setId_cliente(rs.getInt(1));
                }
            }
            return result;
        } catch (Exception e) {
            System.out.println("Error al crear cliente: " + e.getMessage());
            return false;
        }
    }

    @Override
    public ClientesBE Read(String id) {
        ClientesBE cliente = null;
        String query = "SELECT * FROM clientes WHERE id_cliente = ?";
        try (Connection con = getConexion(); PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, Integer.parseInt(id));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                cliente = toEntity(rs);
            }
        } catch (Exception e) {
            System.out.println("Error al leer cliente: " + e.getMessage());
        }
        return cliente;
    }

    // Buscar por id_usuario (útil para login)
    public ClientesBE findByUsuarioId(int idUsuario) {
        ClientesBE cliente = null;
        String query = "SELECT * FROM clientes WHERE id_usuario = ?";
        try (Connection con = getConexion(); PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, idUsuario);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                cliente = toEntity(rs);
            }
        } catch (Exception e) {
            System.out.println("Error al buscar cliente por id_usuario: " + e.getMessage());
        }
        return cliente;
    }

    @Override
    public ArrayList<ClientesBE> ReadAll() {
        ArrayList<ClientesBE> lista = new ArrayList<>();
        String sql = "SELECT c.*, u.nombres, u.email "
                + "FROM clientes c "
                + "JOIN usuarios u ON c.id_usuario = u.id_usuario";
        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ClientesBE cliente = new ClientesBE();
                cliente.setId_cliente(rs.getInt("id_cliente"));
                cliente.setId_usuario(rs.getInt("id_usuario"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setEmpresa(rs.getString("empresa"));
                cliente.setTipo_cliente(rs.getString("tipo_cliente"));
                cliente.setFecha_registro(rs.getString("fecha_registro"));
                cliente.setNombres(rs.getString("nombres"));
                cliente.setEmail(rs.getString("email"));
                lista.add(cliente);
            }
        } catch (Exception e) {
            System.out.println("Error al leer todos los clientes: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean Update(ClientesBE input) {
        String query = "UPDATE clientes SET telefono = ?, direccion = ?, empresa = ?, tipo_cliente = ? WHERE id_cliente = ?";
        try (Connection con = getConexion(); PreparedStatement pst = con.prepareStatement(query)) {

            pst.setString(1, input.getTelefono());
            pst.setString(2, input.getDireccion());
            pst.setString(3, input.getEmpresa());
            pst.setString(4, input.getTipo_cliente());
            pst.setInt(5, input.getId_cliente());
            return pst.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error al actualizar cliente: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String id) {
        String query = "DELETE FROM clientes WHERE id_cliente=?";
        try (Connection con = getConexion(); PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, Integer.parseInt(id));
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al eliminar cliente: " + e.getMessage());
            return false;
        }
    }

    private ClientesBE toEntity(ResultSet rs) throws Exception {
        ClientesBE cliente = new ClientesBE();
        cliente.setId_cliente(rs.getInt("id_cliente"));
        cliente.setId_usuario(rs.getInt("id_usuario"));
        cliente.setTelefono(rs.getString("telefono"));
        cliente.setDireccion(rs.getString("direccion"));
        cliente.setEmpresa(rs.getString("empresa"));
        cliente.setTipo_cliente(rs.getString("tipo_cliente"));
        cliente.setFecha_registro(rs.getString("fecha_registro"));
        return cliente;
    }
}
