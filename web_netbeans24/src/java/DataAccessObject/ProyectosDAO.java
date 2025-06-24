package DataAccessObject;

import BusinessEntify.ProyectosBE;
import Util.ImagenUtils;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.ImageIcon;

public class ProyectosDAO extends ConexionMySQL implements IBaseDAO<ProyectosBE> {

    @Override
    public boolean Create(ProyectosBE input) {
        String sql = "INSERT INTO proyectos (titulo_proyecto, nombre_proyecto, descripcion, imagen) VALUES (?, ?, ?, ?)";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, input.getTitulo_proyecto());
            ps.setString(2, input.getNombre_proyecto());
            ps.setString(3, input.getDescripcion());

            byte[] imageBytes = getImageBytes(input.getImagen());
            ps.setBytes(4, imageBytes);

            boolean result = ps.executeUpdate() > 0;
            if (result) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        input.setId_proyecto(rs.getInt(1));
                    }
                }
            }
            return result;

        } catch (Exception e) {
            System.out.println("❌ Error al crear proyecto: " + e.getMessage());
            return false;
        }
    }

    @Override
    public ProyectosBE Read(String id) {
        String sql = "SELECT * FROM proyectos WHERE id_proyecto = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return toEntity(rs);
                }
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer proyecto: " + e.getMessage());
        }
        return null;
    }

    @Override
    public ArrayList<ProyectosBE> ReadAll() {
        ArrayList<ProyectosBE> lista = new ArrayList<>();
        String sql = "SELECT * FROM proyectos";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(toEntity(rs));
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer todos los proyectos: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean Update(ProyectosBE input) {
        String sql = "UPDATE proyectos SET titulo_proyecto = ?, nombre_proyecto = ?, descripcion = ?, imagen = ? WHERE id_proyecto = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, input.getTitulo_proyecto());
            ps.setString(2, input.getNombre_proyecto());
            ps.setString(3, input.getDescripcion());

            byte[] imageBytes = getImageBytes(input.getImagen());
            ps.setBytes(4, imageBytes);

            ps.setInt(5, input.getId_proyecto());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al actualizar proyecto: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String id) {
        String sql = "DELETE FROM proyectos WHERE id_proyecto = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al eliminar proyecto: " + e.getMessage());
            return false;
        }
    }

    private ProyectosBE toEntity(ResultSet rs) throws Exception {
        ProyectosBE proyecto = new ProyectosBE();
        proyecto.setId_proyecto(rs.getInt("id_proyecto"));
        proyecto.setTitulo_proyecto(rs.getString("titulo_proyecto"));
        proyecto.setNombre_proyecto(rs.getString("nombre_proyecto"));
        proyecto.setDescripcion(rs.getString("descripcion"));

        byte[] imgBytes = rs.getBytes("imagen");
        if (imgBytes != null && imgBytes.length > 0) {
            try {
                ImageIcon imagen = ImagenUtils.bytesToIcon(imgBytes);
                proyecto.setImagen(imagen);
            } catch (Exception e) {
                System.out.println("⚠️ Error al convertir bytes a imagen: " + e.getMessage());
            }
        }

        return proyecto;
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