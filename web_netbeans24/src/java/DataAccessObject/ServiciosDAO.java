package DataAccessObject;

import BusinessEntify.ServiciosBE;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para la gestión de servicios y pedidos de servicios de clientes.
 * Compatible con los procedimientos almacenados en servicios_functions.sql y tablas relacionadas.
 */
public class ServiciosDAO {

    // Cambia esto por tu propia cadena de conexión
    private final String jdbcURL = "jdbc:mysql://localhost:3306/consultoria_arquitectura?useUnicode=true&characterEncoding=utf8mb4";
    private final String jdbcUser = "root";
    private final String jdbcPass = "";

    // --- Métodos para el catálogo de servicios (tabla 'servicios') ---

    public boolean createServicio(ServiciosBE servicio) {
        String sql = "{CALL Registrar_Servicios(?, ?, ?, ?, ?, ?)}";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             CallableStatement cs = conn.prepareCall(sql)) {
            cs.setInt(1, servicio.getId_categoria());
            cs.setString(2, servicio.getNombre_servicio());
            cs.setString(3, servicio.getDescripcion());
            cs.setDouble(4, servicio.getPrecio_base());
            cs.setInt(5, servicio.getDuracion_estimada());
            cs.setString(6, servicio.getImagen());
            cs.execute();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public ServiciosBE readServicioById(int id) {
        String sql = "SELECT * FROM servicios WHERE id_servicio = ?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapServicio(rs);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<ServiciosBE> readAllServicios() {
        List<ServiciosBE> lista = new ArrayList<>();
        String sql = "CALL Listar_Servicios()";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             CallableStatement cs = conn.prepareCall(sql)) {
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                lista.add(mapServicio(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public boolean updateServicio(ServiciosBE servicio) {
        String sql = "UPDATE servicios SET id_categoria=?, nombre=?, descripcion=?, precio_base=?, duracion_estimada=?, imagen=? WHERE id_servicio=?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, servicio.getId_categoria());
            ps.setString(2, servicio.getNombre_servicio());
            ps.setString(3, servicio.getDescripcion());
            ps.setDouble(4, servicio.getPrecio_base());
            ps.setInt(5, servicio.getDuracion_estimada());
            ps.setString(6, servicio.getImagen());
            ps.setInt(7, servicio.getId_servicio());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean deleteServicio(int id) {
        String sql = "DELETE FROM servicios WHERE id_servicio = ?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // --- Métodos para pedidos de servicios de clientes (tabla 'servicios_cliente') ---

    public boolean createPedidoServicio(ServiciosBE pedido) {
        String sql = "INSERT INTO servicios_cliente (id_cliente, id_servicio, id_personal_asignado, id_venta, fecha_inicio, fecha_fin, estado, precio_final, detalles, calificacion, comentarios) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pedido.getId_cliente());
            ps.setInt(2, pedido.getId_servicio());
            if (pedido.getId_personal_asignado() != null) ps.setInt(3, pedido.getId_personal_asignado());
            else ps.setNull(3, Types.INTEGER);
            if (pedido.getId_venta() != null) ps.setInt(4, pedido.getId_venta());
            else ps.setNull(4, Types.INTEGER);
            ps.setString(5, pedido.getFecha_inicio());
            ps.setString(6, pedido.getFecha_fin());
            ps.setString(7, pedido.getEstado());
            if (pedido.getPrecio_final() != null) ps.setDouble(8, pedido.getPrecio_final());
            else ps.setNull(8, Types.DECIMAL);
            ps.setString(9, pedido.getDetalles());
            if (pedido.getCalificacion() != null) ps.setInt(10, pedido.getCalificacion());
            else ps.setNull(10, Types.TINYINT);
            ps.setString(11, pedido.getComentarios());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public ServiciosBE readPedidoServicioById(int id) {
        String sql = "SELECT * FROM servicios_cliente WHERE id_servicio_cliente = ?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapPedidoServicio(rs);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<ServiciosBE> readAllPedidosServicios() {
        List<ServiciosBE> lista = new ArrayList<>();
        String sql = "SELECT * FROM servicios_cliente";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapPedidoServicio(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public boolean updatePedidoServicio(ServiciosBE pedido) {
        String sql = "UPDATE servicios_cliente SET id_cliente=?, id_servicio=?, id_personal_asignado=?, id_venta=?, fecha_inicio=?, fecha_fin=?, estado=?, precio_final=?, detalles=?, calificacion=?, comentarios=? WHERE id_servicio_cliente=?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pedido.getId_cliente());
            ps.setInt(2, pedido.getId_servicio());
            if (pedido.getId_personal_asignado() != null) ps.setInt(3, pedido.getId_personal_asignado());
            else ps.setNull(3, Types.INTEGER);
            if (pedido.getId_venta() != null) ps.setInt(4, pedido.getId_venta());
            else ps.setNull(4, Types.INTEGER);
            ps.setString(5, pedido.getFecha_inicio());
            ps.setString(6, pedido.getFecha_fin());
            ps.setString(7, pedido.getEstado());
            if (pedido.getPrecio_final() != null) ps.setDouble(8, pedido.getPrecio_final());
            else ps.setNull(8, Types.DECIMAL);
            ps.setString(9, pedido.getDetalles());
            if (pedido.getCalificacion() != null) ps.setInt(10, pedido.getCalificacion());
            else ps.setNull(10, Types.TINYINT);
            ps.setString(11, pedido.getComentarios());
            ps.setInt(12, pedido.getId_servicio_cliente());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean deletePedidoServicio(int id) {
        String sql = "DELETE FROM servicios_cliente WHERE id_servicio_cliente = ?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // --- Métodos helper para mapear resultados a la entidad ---

    private ServiciosBE mapServicio(ResultSet rs) throws SQLException {
        ServiciosBE be = new ServiciosBE();
        be.setId_servicio(rs.getInt("id_servicio"));
        be.setId_categoria(rs.getInt("id_categoria"));
        be.setNombre_servicio(rs.getString("nombre"));
        be.setDescripcion(rs.getString("descripcion"));
        be.setPrecio_base(rs.getDouble("precio_base"));
        be.setDuracion_estimada(rs.getInt("duracion_estimada"));
        be.setImagen(rs.getString("imagen"));
        // Estado y otros campos del catálogo, si los necesitas
        return be;
    }

    private ServiciosBE mapPedidoServicio(ResultSet rs) throws SQLException {
        ServiciosBE be = new ServiciosBE();
        be.setId_servicio_cliente(rs.getInt("id_servicio_cliente"));
        be.setId_cliente(rs.getInt("id_cliente"));
        be.setId_servicio(rs.getInt("id_servicio"));
        be.setId_personal_asignado(rs.getObject("id_personal_asignado") != null ? rs.getInt("id_personal_asignado") : null);
        be.setId_venta(rs.getObject("id_venta") != null ? rs.getInt("id_venta") : null);
        be.setFecha_contratacion(rs.getString("fecha_contratacion"));
        be.setFecha_inicio(rs.getString("fecha_inicio"));
        be.setFecha_fin(rs.getString("fecha_fin"));
        be.setEstado(rs.getString("estado"));
        be.setPrecio_final(rs.getObject("precio_final") != null ? rs.getDouble("precio_final") : null);
        be.setDetalles(rs.getString("detalles"));
        be.setCalificacion(rs.getObject("calificacion") != null ? rs.getInt("calificacion") : null);
        be.setComentarios(rs.getString("comentarios"));
        return be;
    }
}