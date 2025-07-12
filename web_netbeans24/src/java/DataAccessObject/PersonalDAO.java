package DataAccessObject;

import BusinessEntify.PersonalBE;
import Util.ImagenUtils;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.ImageIcon;

public class PersonalDAO extends ConexionMySQL implements IBaseDAO<PersonalBE>{

    @Override
    public boolean Create(PersonalBE input) {
        String sql = "INSERT INTO personal (nombres, cargo, correo, telefono, descripcion, foto) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, input.getNombre_personal());    
            ps.setString(2, input.getCargo_personal());
            ps.setString(3, input.getCorreo_personal());
            ps.setString(4, input.getTelefono_personal());
            ps.setString(5, input.getDescripcion());

            byte[] imageBytes = getImageBytes(input.getImagen());
            ps.setBytes(6, imageBytes);

            boolean result = ps.executeUpdate() > 0;
            if (result) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        input.setId_personal(rs.getInt(1));
                    }
                }
            }
            return result;

        } catch (Exception e) {
            System.out.println("❌ Error al crear personal: " + e.getMessage());
            return false;
        }
    }

    @Override
    public PersonalBE Read(String id) {
        String sql = "SELECT * FROM personal WHERE id_personal = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return toEntity(rs);
                }
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer personal: " + e.getMessage());
        }
        return null;
    }

    @Override
    public ArrayList<PersonalBE> ReadAll() {
        ArrayList<PersonalBE> lista = new ArrayList<>();
        String sql = "SELECT * FROM personal";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(toEntity(rs));
            }

        } catch (Exception e) {
            System.out.println("❌ Error al leer el personal: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean Update(PersonalBE input) {
        String sql = "UPDATE personal SET nombres = ?, cargo = ?, correo = ?, telefono = ?, descripcion = ?, foto = ? WHERE id_personal = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, input.getNombre_personal());
            ps.setString(2, input.getCargo_personal());
            ps.setString(3, input.getCorreo_personal());
            ps.setString(4, input.getTelefono_personal());
            ps.setString(5, input.getDescripcion());

            byte[] imageBytes = getImageBytes(input.getImagen());
            ps.setBytes(6, imageBytes);

            ps.setInt(7, input.getId_personal());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al actualizar personal: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean Delete(String id) {
        String sql = "DELETE FROM personal WHERE id_personal = ?";
        try (Connection con = getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(id));
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error al eliminar personal: " + e.getMessage());
            return false;
        }
    }
    
    private PersonalBE toEntity(ResultSet rs) throws Exception {
        PersonalBE personal = new PersonalBE();
        personal.setId_personal(rs.getInt("id_personal"));
        personal.setNombre_personal(rs.getString("nombres"));
        personal.setCargo_personal(rs.getString("cargo"));
        personal.setCorreo_personal(rs.getString("correo"));
        personal.setTelefono_personal(rs.getString("telefono"));
        personal.setDescripcion(rs.getString("descripcion"));

        byte[] imgBytes = rs.getBytes("foto");
        if (imgBytes != null && imgBytes.length > 0) {
            try {
                ImageIcon imagen = ImagenUtils.bytesToIcon(imgBytes);
                personal.setImagen(imagen);
            } catch (Exception e) {
                System.out.println("⚠️ Error al convertir bytes a imagen: " + e.getMessage());
            }
        }

        return personal;
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
