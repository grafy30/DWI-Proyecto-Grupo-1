package DataAccessObject;
import BusinessEntify.ClientesBE;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
public class ClientesDAO extends ConexionMySQL
        implements IBaseDAO<ClientesBE>
{
    @Override
    public boolean Create(ClientesBE input) {
        boolean result = false;
        try {
            String query = "INSERT INTO clientes (id_usuario, telefono, direccion, empresa, tipo_cliente) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = getConexion().prepareStatement(query);
            pst.setInt(1, input.getId_cliente());
            pst.setString(2, input.getTelefono());
            pst.setString(3, input.getDireccion());
            pst.setString(4, input.getEmpresa());
            pst.setString(5, input.getTipo());
            result = pst.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al crear cliente: " + e.getMessage());
        }
        return result;
    }

    @Override
    public ClientesBE Read(String input) {
        ClientesBE cliente = null;
        try {
            String query = "SELECT * FROM clientes WHERE id_cliente = ?";
            PreparedStatement pst = getConexion().prepareStatement(query);
            pst.setString(1, input);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                cliente = new ClientesBE();
                cliente.setId_cliente(rs.getInt("id_cliente"));
                cliente.setId_cliente(rs.getInt("id_usuario"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setEmpresa(rs.getString("empresa"));
                cliente.setTipo(rs.getString("tipo_cliente"));
                cliente.setFecha_registro(rs.getString("fecha_registro"));
            }
        } catch (Exception e) {
            System.out.println("Error al leer cliente: " + e.getMessage());
        }
        return cliente;
    }

    @Override
    public ArrayList<ClientesBE> ReadAll() {
        ArrayList<ClientesBE> lista = new ArrayList<>();
        try {
            String query = "SELECT * FROM clientes";
            PreparedStatement pst = getConexion().prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ClientesBE cliente = new ClientesBE();
                cliente.setId_cliente(rs.getInt("id_cliente"));
                cliente.setId_cliente(rs.getInt("id_usuario"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setEmpresa(rs.getString("empresa"));
                cliente.setTipo(rs.getString("tipo_cliente"));
                cliente.setFecha_registro(rs.getString("fecha_registro"));
                lista.add(cliente);
            }
        } catch (Exception e) {
            System.out.println("Error al leer todos los clientes: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean Update(ClientesBE input) {
        boolean result = false;
        try {
            String query = "UPDATE clientes SET id_usuario = ?, telefono = ?, direccion = ?, empresa = ?, tipo_cliente = ? WHERE id_cliente = ?";
            PreparedStatement pst = getConexion().prepareStatement(query);
            pst.setInt(1, input.getId_cliente());
            pst.setString(2, input.getTelefono());
            pst.setString(3, input.getDireccion());
            pst.setString(4, input.getEmpresa());
            pst.setString(5, input.getTipo());
            pst.setInt(6, input.getId_cliente());
            result = pst.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al actualizar cliente: " + e.getMessage());
        }
        return result; 
    }

    @Override
    public boolean Delete(String input) {
        boolean result = false;
        try {
            PreparedStatement pst = 
                    getConexion().prepareStatement("DELETE FROM Clientes WHERE id_cliente=?");
            pst.setString(1, input);
            result = pst.execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result;
    }   
}
