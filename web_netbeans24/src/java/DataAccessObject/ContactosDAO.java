package DataAccessObject;

import BusinessEntify.ContactosBE;
import java.sql.*;
import java.util.ArrayList;

public class ContactosDAO extends ConexionMySQL implements IBaseDAO<ContactosBE> {

    @Override
    public boolean Create(ContactosBE input) {
        boolean result = false;
        String sql = "INSERT INTO contactos (nombre, correo, mensaje, fecha_contacto, estado) " +
             "VALUES (?, ?, ?, NOW(), ?)";

        try (Connection conn = getConexion();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, input.getNombre());
            pst.setString(2, input.getCorreo());
            pst.setString(3, input.getMensaje());
            pst.setString(4, input.getEstado() != null ? input.getEstado() : "Pendiente");

            result = pst.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error al crear contacto: " + e.getMessage());
        }

        return result;
    }

    @Override
    public ContactosBE Read(String input) {
        ContactosBE contacto = null;
        String sql = "SELECT * FROM contactos WHERE id_contacto = ?";

        try (Connection conn = getConexion();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, input);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                contacto = new ContactosBE();
                contacto.setId_contacto(rs.getInt("id_contacto"));
                contacto.setNombre(rs.getString("nombre"));
                contacto.setCorreo(rs.getString("correo"));
                contacto.setMensaje(rs.getString("mensaje"));
                contacto.setFecha_contacto(rs.getTimestamp("fecha_contacto"));
                contacto.setEstado(rs.getString("estado"));
            }

        } catch (Exception e) {
            System.out.println("Error al leer contacto: " + e.getMessage());
        }

        return contacto;
    }

    @Override
    public boolean Update(ContactosBE input) {
        boolean result = false;
        String sql = "UPDATE contactos SET nombre=?, correo=?, mensaje=?, estado=? WHERE id_contacto=?";

        try (Connection conn = getConexion();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, input.getNombre());
            pst.setString(2, input.getCorreo());
            pst.setString(3, input.getMensaje());
            pst.setString(4, input.getEstado());
            pst.setInt(5, input.getId_contacto());

            result = pst.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error al actualizar contacto: " + e.getMessage());
        }

        return result;
    }

    @Override

    public boolean Delete(String input) {
        boolean result = false;
        String sql = "DELETE FROM contactos WHERE id_contacto = ?";

        try (Connection conn = getConexion(); PreparedStatement pst = conn.prepareStatement(sql)) {

            int id = Integer.parseInt(input); // 🔁 conversión de String a int
            pst.setInt(1, id);                // ✅ ahora lo pasamos como int

            result = pst.executeUpdate() > 0;

            System.out.println("✅ Eliminando contacto con ID: " + id);

        } catch (Exception e) {
            System.out.println("❌ Error al eliminar contacto: " + e.getMessage());
        }

        return result;
    }


    @Override
    public ArrayList<ContactosBE> ReadAll() {
        ArrayList<ContactosBE> lista = new ArrayList<>();
        String sql = "SELECT * FROM contactos ORDER BY fecha_contacto DESC";

        try (Connection conn = getConexion();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                ContactosBE contacto = new ContactosBE();
                contacto.setId_contacto(rs.getInt("id_contacto"));
                contacto.setNombre(rs.getString("nombre"));
                contacto.setCorreo(rs.getString("correo"));
                contacto.setMensaje(rs.getString("mensaje"));
                contacto.setFecha_contacto(rs.getTimestamp("fecha_contacto"));
                contacto.setEstado(rs.getString("estado"));

                lista.add(contacto);
            }

        } catch (Exception e) {
            System.out.println("Error al listar contactos: " + e.getMessage());
        }

        return lista;
    }

    // 🚀 Método adicional para marcar como "Atendido"
    public boolean marcarComoAtendido(int idContacto) {
        boolean result = false;
        String sql = "UPDATE contactos SET estado = 'Atendido' WHERE id_contacto = ?";

        try (Connection conn = getConexion();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, idContacto);
            result = pst.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error al marcar como atendido: " + e.getMessage());
        }

        return result;
    }
}

