package BusinessLogic;

import BusinessEntify.ContactosBE;
import DataAccessObject.ContactosDAO;
import BusinessLogic.IBaseBL;
import java.util.ArrayList;
import java.util.List;

public class ContactosBL implements IBaseBL<ContactosBE> {

    private final ContactosDAO contactoDAO;

    public ContactosBL() {
        this.contactoDAO = new ContactosDAO();
    }

    @Override
    public boolean Create(ContactosBE input) {
        return contactoDAO.Create(input);
    }

    @Override
    public ContactosBE Read(String input) {
        return contactoDAO.Read(input);
    }

    @Override
    public ArrayList<ContactosBE> ReadAll() {
        return contactoDAO.ReadAll();
    }

    @Override
    public boolean Update(ContactosBE input) {
        return contactoDAO.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return contactoDAO.Delete(input);
    }

    // ✅ Método para responder mensaje y cambiar estado
    public boolean responderMensaje(int idContacto, String respuesta) {
        return contactoDAO.actualizarRespuestaYEstado(idContacto, respuesta);
    }

    public List<ContactosBE> listarRespondidosPorCorreo(String correo) {
        ContactosDAO dao = new ContactosDAO();
        return dao.listarRespondidosPorCorreo(correo);
    }


    public List<ContactosBE> ReadAtendidos() {
        return contactoDAO.ReadAtendidos(); // Llama al DAO para leer solo los atendidos
    }

}
