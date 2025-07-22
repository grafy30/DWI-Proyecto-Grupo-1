package BusinessLogic;

import BusinessEntify.ServiciosClienteBE;
import DataAccessObject.ServiciosClienteDAO;
import java.util.ArrayList;

public class ServiciosClienteBL implements IBaseBL<ServiciosClienteBE> {

    private final ServiciosClienteDAO serviciosClienteDAO;

    public ServiciosClienteBL() {
        this.serviciosClienteDAO = new ServiciosClienteDAO();
    }

    @Override
    public boolean Create(ServiciosClienteBE input) {
        return serviciosClienteDAO.Create(input);
    }

    @Override
    public ServiciosClienteBE Read(String input) {
        return serviciosClienteDAO.Read(input);
    }

    @Override
    public ArrayList<ServiciosClienteBE> ReadAll() {
        return serviciosClienteDAO.ReadAll();
    }

    @Override
    public boolean Update(ServiciosClienteBE input) {
        return serviciosClienteDAO.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return serviciosClienteDAO.Delete(input);
    }
}
