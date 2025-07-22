package DataAccessObject;

import BusinessEntify.PagosBE;
import java.sql.*;
import java.util.ArrayList;

public class PagosDAO extends ConexionMySQL implements IBaseDAO<PagosBE> {

    @Override
    public boolean Create(PagosBE input) {
        String sql = "INSERT INTO pagos (id_servicio_cliente, monto, fecha_pago, metodo, estado, comprobante) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, input.getIdServicioCliente());
            ps.setDouble(2, input.getMonto());
            ps.setTimestamp(3, input.getFechaPago());
            ps.setString(4, input.getMetodo());
            ps.setString(5, input.getEstado());
            ps.setString(6, input.getComprobante());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error al crear Pago: " + e.getMessage());
            return false;
        }
    }

    @Override
    public PagosBE Read(String input) {
        String sql = "SELECT * FROM pagos WHERE id_pago = ?";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(input));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                PagosBE p = new PagosBE();
                p.setIdPago(rs.getInt("id_pago"));
                p.setIdServicioCliente(rs.getInt("id_servicio_cliente"));
                p.setMonto(rs.getDouble("monto"));
                p.setFechaPago(rs.getTimestamp("fecha_pago"));
                p.setMetodo(rs.getString("metodo"));
                p.setEstado(rs.getString("estado"));
                p.setComprobante(rs.getString("comprobante"));
                return p;
            }

        } catch (SQLException e) {
            System.err.println("Error al leer Pago: " + e.getMessage());
        }
        return null;
    }

    @Override
    public ArrayList<PagosBE> ReadAll() {
        ArrayList<PagosBE> lista = new ArrayList<>();
        String sql = "SELECT * FROM pagos";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PagosBE p = new PagosBE();
                p.setIdPago(rs.getInt("id_pago"));
                p.setIdServicioCliente(rs.getInt("id_servicio_cliente"));
                p.setMonto(rs.getDouble("monto"));
                p.setFechaPago(rs.getTimestamp("fecha_pago"));
                p.setMetodo(rs.getString("metodo"));
                p.setEstado(rs.getString("estado"));
                p.setComprobante(rs.getString("comprobante"));
                lista.add(p);
            }

        } catch (SQLException e) {
            System.err.println("Error al leer todos los Pagos: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean Update(PagosBE input) {
        String sql = "UPDATE pagos SET id_servicio_cliente = ?, monto = ?, fecha_pago = ?, metodo = ?, estado = ?, comprobante = ? WHERE id_pago = ?";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, input.getIdServicioCliente());
            ps.setDouble(2, input.getMonto());
            ps.setTimestamp(3, input.getFechaPago());
            ps.setString(4, input.getMetodo());
            ps.setString(5, input.getEstado());
            ps.setString(6, input.getComprobante());
            ps.setInt(7, input.getIdPago());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error al actualizar Pago: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String input) {
        String sql = "DELETE FROM pagos WHERE id_pago = ?";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(input));
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error al eliminar Pago: " + e.getMessage());
            return false;
        }
    }
}
