package DataAccessObject;

import BusinessEntify.ServiciosBE;
import Util.ImagenUtils;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.ImageIcon;

public class ServiciosDAO extends ConexionMySQL implements IBaseDAO<ServiciosBE>{

    @Override
    public boolean Create(ServiciosBE input) {
        String sql = "INSERT INTO servicios (id_categoria, nombre, descripcion, precio_base, duracion_estimada, imagen) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, input.getId_categoria());
            ps.setString(2, input.getNombre_servicio());    
            ps.setString(3, input.getDescripcion());
            ps.setDouble(4, input.getPrecio_base());
            ps.setInt(5, input.getDuracion_estimada());

            byte[] imageBytes = getImageBytes(input.getImagen());
            ps.setBytes(6, imageBytes);

            boolean result = ps.executeUpdate() > 0;
            if (result) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        input.setId_servicio(rs.getInt(1));
                    }
                }
            }
            return result;

        } catch (Exception e) {
            System.out.println("❌ Error al crear Servicio: " + e.getMessage());
            return false;
        }
    }

    @Override
    public ServiciosBE Read(String id) {
        String sql = "SELECT * FROM servicios WHERE id_servicio  = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return toEntity(rs);
                }
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer Servicio: " + e.getMessage());
        }
        return null;
    }

    @Override
    public ArrayList<ServiciosBE> ReadAll() {
        ArrayList<ServiciosBE> lista = new ArrayList<>();
        String sql = "SELECT * FROM servicios";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(toEntity(rs));
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer todos los servicios: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean Update(ServiciosBE input) {
        String sql = "UPDATE servicios SET id_categoria = ?, nombre = ?, descripcion = ?, "
                   + "precio_base = ?, duracion_estimada = ?, imagen = ? WHERE id_servicio = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, input.getId_categoria());
            ps.setString(2, input.getNombre_servicio());
            ps.setString(3, input.getDescripcion());
            ps.setDouble(4, input.getPrecio_base());
            ps.setInt(5, input.getDuracion_estimada());

            byte[] imageBytes = getImageBytes(input.getImagen());
            ps.setBytes(6, imageBytes);

            ps.setInt(5, input.getId_servicio());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al actualizar el servicio: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String id) {
        String sql = "DELETE FROM servicios WHERE id_servicio = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al eliminar el servicio: " + e.getMessage());
            return false;
        }
    }
    
    private ServiciosBE toEntity(ResultSet rs) throws Exception {
        ServiciosBE servicios = new ServiciosBE();
        servicios.setId_servicio(rs.getInt("id_servicio"));
        servicios.setId_categoria(rs.getInt("id_categoria"));
        servicios.setNombre_servicio(rs.getString("nombre"));
        servicios.setDescripcion(rs.getString("descripcion"));
        servicios.setPrecio_base(rs.getDouble("precio_base"));
        servicios.setDuracion_estimada(rs.getInt("duracion_estimada"));

        byte[] imgBytes = rs.getBytes("imagen");
        if (imgBytes != null && imgBytes.length > 0) {
            try {
                ImageIcon imagen = ImagenUtils.bytesToIcon(imgBytes);
                servicios.setImagen(imagen);
            } catch (Exception e) {
                System.out.println("⚠️ Error al convertir bytes a imagen: " + e.getMessage());
            }
        }
        return servicios;
    }

    // Método auxiliar privado para reducir código repetido
    private byte[] getImageBytes(ImageIcon icon) {
        try {
            if (icon != null && icon.getImage() != null) {
                return ImagenUtils.iconToBytes(icon);
            }
        } catch (Exception e) {
            System.out.println("⚠️ Error al convertir imagen a bytes: " + e.getMessage());
        }
        return null;
    }
}