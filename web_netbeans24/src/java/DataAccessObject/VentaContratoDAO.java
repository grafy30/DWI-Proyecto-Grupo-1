package DataAccessObject;

import BusinessEntify.VentaContratoBE;
import java.sql.*;
import java.util.ArrayList;

public class VentaContratoDAO extends ConexionMySQL implements IBaseDAO<VentaContratoBE> {

    @Override
    public boolean Create(VentaContratoBE input) {
        String sql = "INSERT INTO venta_contrato (nombre, descripcion, ubicacion, fecha_inicio, " +
                     "fecha_fin, estado, cliente_id, presupuesto) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection con = getConexion();
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {
            ps.setString(1, input.getNombre());
            ps.setString(2, input.getDescripcion());
            ps.setString(3, input.getUbicacion());
            ps.setDate(4, input.getFecha_inicio());
            ps.setDate(5, input.getFecha_fin());
            ps.setString(6, input.getEstado());

            if (input.getCliente_id() != null) {
                ps.setInt(7, input.getCliente_id());
            } else {
                ps.setNull(7, Types.INTEGER);
            }

            ps.setBigDecimal(8, input.getPresupuesto());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        input.setId_venta(generatedKeys.getInt(1)); // Captura el ID generado
                    }
                }
                return true;
            }

        } catch (Exception e) {
            System.err.println("❌ Error al crear venta_contrato: " + e.getMessage());
        }

        return false;
    }

    @Override
    public VentaContratoBE Read(String input) {
        String sql = "SELECT * FROM venta_contrato WHERE id_venta = ?";

        try (
            Connection con = getConexion();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, Integer.parseInt(input));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    VentaContratoBE vc = new VentaContratoBE();
                    vc.setId_venta(rs.getInt("id_venta"));
                    vc.setNombre(rs.getString("nombre"));
                    vc.setDescripcion(rs.getString("descripcion"));
                    vc.setUbicacion(rs.getString("ubicacion"));
                    vc.setFecha_inicio(rs.getDate("fecha_inicio"));
                    vc.setFecha_fin(rs.getDate("fecha_fin"));
                    vc.setEstado(rs.getString("estado"));
                    vc.setCliente_id(rs.getObject("cliente_id") != null ? rs.getInt("cliente_id") : null);
                    vc.setPresupuesto(rs.getBigDecimal("presupuesto"));
                    return vc;
                }
            }

        } catch (Exception e) {
            System.err.println("❌ Error al leer venta_contrato: " + e.getMessage());
        }

        return null;
    }

    @Override
    public ArrayList<VentaContratoBE> ReadAll() {
        String sql = "SELECT * FROM venta_contrato";
        ArrayList<VentaContratoBE> lista = new ArrayList<>();

        try (
            Connection con = getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                VentaContratoBE vc = new VentaContratoBE();
                vc.setId_venta(rs.getInt("id_venta"));
                vc.setNombre(rs.getString("nombre"));
                vc.setDescripcion(rs.getString("descripcion"));
                vc.setUbicacion(rs.getString("ubicacion"));
                vc.setFecha_inicio(rs.getDate("fecha_inicio"));
                vc.setFecha_fin(rs.getDate("fecha_fin"));
                vc.setEstado(rs.getString("estado"));
                vc.setCliente_id(rs.getObject("cliente_id") != null ? rs.getInt("cliente_id") : null);
                vc.setPresupuesto(rs.getBigDecimal("presupuesto"));
                lista.add(vc);
            }

        } catch (Exception e) {
            System.err.println("❌ Error al leer todos los venta_contrato: " + e.getMessage());
        }

        return lista;
    }

    @Override
    public boolean Update(VentaContratoBE input) {
        String sql = "UPDATE venta_contrato SET nombre = ?, descripcion = ?, ubicacion = ?, " +
                     "fecha_inicio = ?, fecha_fin = ?, estado = ?, cliente_id = ?, presupuesto = ? " +
                     "WHERE id_venta = ?";

        try (
            Connection con = getConexion();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, input.getNombre());
            ps.setString(2, input.getDescripcion());
            ps.setString(3, input.getUbicacion());
            ps.setDate(4, input.getFecha_inicio());
            ps.setDate(5, input.getFecha_fin());
            ps.setString(6, input.getEstado());

            if (input.getCliente_id() != null) {
                ps.setInt(7, input.getCliente_id());
            } else {
                ps.setNull(7, Types.INTEGER);
            }

            ps.setBigDecimal(8, input.getPresupuesto());
            ps.setInt(9, input.getId_venta());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            System.err.println("❌ Error al actualizar venta_contrato: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String input) {
        String sql = "DELETE FROM venta_contrato WHERE id_venta = ?";

        try (
            Connection con = getConexion();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, Integer.parseInt(input));
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            System.err.println("❌ Error al eliminar venta_contrato: " + e.getMessage());
            return false;
        }
    }
}
