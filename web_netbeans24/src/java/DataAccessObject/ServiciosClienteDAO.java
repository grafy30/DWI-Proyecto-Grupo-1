package DataAccessObject;

import BusinessEntify.ServiciosClienteBE;
import java.sql.*;
import java.util.ArrayList;

public class ServiciosClienteDAO extends ConexionMySQL implements IBaseDAO<ServiciosClienteBE> {

    @Override
    public boolean Create(ServiciosClienteBE input) {
        String sql = "INSERT INTO servicios_cliente (id_cliente, id_servicio, id_personal_asignado, "
                + "id_venta, fecha_inicio, fecha_fin, estado, precio_final, detalles, "
                + "calificacion, comentarios) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, input.getId_cliente());
            ps.setInt(2, input.getId_servicio());

            if (input.getId_personal_asignado() != null) {
                ps.setInt(3, input.getId_personal_asignado());
            } else {
                ps.setNull(3, Types.INTEGER);
            }

            if (input.getId_venta() != null) {
                ps.setInt(4, input.getId_venta());
            } else {
                ps.setNull(4, Types.INTEGER);
            }

            ps.setDate(5, input.getFecha_inicio());
            ps.setDate(6, input.getFecha_fin());
            ps.setString(7, input.getEstado());
            ps.setBigDecimal(8, input.getPrecio_final());
            ps.setString(9, input.getDetalles());

            if (input.getCalificacion() != null) {
                ps.setInt(10, input.getCalificacion());
            } else {
                ps.setNull(10, Types.TINYINT);
            }

            ps.setString(11, input.getComentarios());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    input.setId_servicio_cliente(rs.getInt(1));
                }
                return true;
            }
            return false;

        } catch (Exception e) {
            System.out.println("Error al crear servicios_cliente: " + e.getMessage());
            return false;
        }
    }

    @Override
    public ServiciosClienteBE Read(String input) {
        String sql = "SELECT * FROM servicios_cliente WHERE id_servicio_cliente = ?";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(input));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToEntity(rs);
            }

        } catch (Exception e) {
            System.out.println("Error al leer servicios_cliente: " + e.getMessage());
        }

        return null;
    }

    @Override
    public ArrayList<ServiciosClienteBE> ReadAll() {
        String sql = "SELECT * FROM servicios_cliente";
        ArrayList<ServiciosClienteBE> lista = new ArrayList<>();

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToEntity(rs));
            }

        } catch (Exception e) {
            System.out.println("Error al leer todos los servicios_cliente: " + e.getMessage());
        }

        return lista;
    }

    @Override
    public boolean Update(ServiciosClienteBE input) {
        String sql = "UPDATE servicios_cliente SET id_cliente = ?, id_servicio = ?, "
                + "id_personal_asignado = ?, id_venta = ?, fecha_inicio = ?, fecha_fin = ?, "
                + "estado = ?, precio_final = ?, detalles = ?, calificacion = ?, "
                + "comentarios = ? WHERE id_servicio_cliente = ?";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, input.getId_cliente());
            ps.setInt(2, input.getId_servicio());

            if (input.getId_personal_asignado() != null) {
                ps.setInt(3, input.getId_personal_asignado());
            } else {
                ps.setNull(3, Types.INTEGER);
            }

            if (input.getId_venta() != null) {
                ps.setInt(4, input.getId_venta());
            } else {
                ps.setNull(4, Types.INTEGER);
            }

            ps.setDate(5, input.getFecha_inicio());
            ps.setDate(6, input.getFecha_fin());
            ps.setString(7, input.getEstado());
            ps.setBigDecimal(8, input.getPrecio_final());
            ps.setString(9, input.getDetalles());

            if (input.getCalificacion() != null) {
                ps.setInt(10, input.getCalificacion());
            } else {
                ps.setNull(10, Types.TINYINT);
            }

            ps.setString(11, input.getComentarios());
            ps.setInt(12, input.getId_servicio_cliente());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            System.out.println("Error al actualizar servicios_cliente: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String input) {
        String sql = "DELETE FROM servicios_cliente WHERE id_servicio_cliente = ?";

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(input));
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            System.out.println("Error al eliminar servicios_cliente: " + e.getMessage());
            return false;
        }
    }

    // Método auxiliar para mapear ResultSet a ServiciosClienteBE
    private ServiciosClienteBE mapResultSetToEntity(ResultSet rs) throws SQLException {
        ServiciosClienteBE sc = new ServiciosClienteBE();
        sc.setId_servicio_cliente(rs.getInt("id_servicio_cliente"));
        sc.setId_cliente(rs.getInt("id_cliente"));
        sc.setId_servicio(rs.getInt("id_servicio"));
        sc.setId_personal_asignado(rs.getObject("id_personal_asignado") != null ? rs.getInt("id_personal_asignado") : null);
        sc.setId_venta(rs.getObject("id_venta") != null ? rs.getInt("id_venta") : null);
        sc.setFecha_contratacion(rs.getTimestamp("fecha_contratacion"));
        sc.setFecha_inicio(rs.getDate("fecha_inicio"));
        sc.setFecha_fin(rs.getDate("fecha_fin"));
        sc.setEstado(rs.getString("estado"));
        sc.setPrecio_final(rs.getBigDecimal("precio_final"));
        sc.setDetalles(rs.getString("detalles"));
        sc.setCalificacion(rs.getObject("calificacion") != null ? rs.getInt("calificacion") : null);
        sc.setComentarios(rs.getString("comentarios"));
        return sc;
    }

    // Método adicional para buscar servicios por cliente
    public ArrayList<ServiciosClienteBE> findByClienteId(int idCliente) {
        String sql = "SELECT * FROM servicios_cliente WHERE id_cliente = ?";
        ArrayList<ServiciosClienteBE> lista = new ArrayList<>();

        try (Connection con = getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                lista.add(mapResultSetToEntity(rs));
            }

        } catch (Exception e) {
            System.out.println("Error al buscar servicios por cliente: " + e.getMessage());
        }

        return lista;
    }
}
