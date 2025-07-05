package BusinessLogic;

import BusinessEntify.ContactosBE;
import DataAccessObject.ContactosDAO;
import BusinessLogic.IBaseBL;
import java.util.ArrayList;

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

    // 🚀 Método adicional para marcar como atendido
    public boolean marcarComoAtendido(int idContacto) {
        return contactoDAO.marcarComoAtendido(idContacto);
    }
}

