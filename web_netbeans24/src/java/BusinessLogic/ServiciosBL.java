package BusinessLogic;

import BusinessEntify.ServiciosBE;
import DataAccessObject.ServiciosDAO;
import java.util.ArrayList;
import java.util.List;

public class ServiciosBL implements IBaseBL<ServiciosBE> {

    private final ServiciosDAO serviciosDAO;

    public ServiciosBL() {
        this.serviciosDAO = new ServiciosDAO();
    }

    @Override
    public boolean Create(ServiciosBE input) {
        return serviciosDAO.Create(input);
    }

    @Override
    public ServiciosBE Read(String input) {
        return serviciosDAO.Read(input);
    }

    @Override
    public ArrayList<ServiciosBE> ReadAll() {
        return serviciosDAO.ReadAll();
    }

    @Override
    public boolean Update(ServiciosBE input) {
        return serviciosDAO.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return serviciosDAO.Delete(input);
    }

    public ArrayList<ServiciosBE> buscarPorCategoria(int idCategoria) {
        return serviciosDAO.buscarPorCategoria(idCategoria);
    }
}
